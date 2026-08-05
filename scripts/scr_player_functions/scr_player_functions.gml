/// @desc Cria os inputs para o player
function criar_input() {
	return [
		{ name: "move_x",   read: method(self, function() { return keyboard_check(global.move_right) - keyboard_check(global.move_left); }) },
		{ name: "move_y",   read: method(self, function() { return keyboard_check(global.move_down) - keyboard_check(global.move_up); }) },
		{ name: "mira",     read: method(self, function() { var _m = mouse_mundo(); return point_direction(x, y, _m.x, _m.y); }) },
		{ name: "atirando", read: method(self, function() { return mouse_check_button(global.shoot); })},
		{ name: "dash",		read: method(self, function() { return has_dash && keyboard_check_pressed(global.dash); })}
	];
}

/// @desc Move a entidade baseado nos inputs
/// @arg {REAL} _move_x Força do movimento X
/// @arg {REAL} _move_y Força do movimento Y
function mover(_move_x, _move_y) {
	
	//Cooldown dash
	if (dash_cooldown > 0) { dash_cooldown -= 1 }
	if (invul_timer > 0 ) { invul_timer -=1 }
	
	if (dash_timer > 0)
	{
		dash_timer -= 1;
		vel_x = lengthdir_x(dash_speed, dash_dir);
		vel_y = lengthdir_y(dash_speed, dash_dir);
	}else{
		var _dist = point_distance(0, 0, _move_x, _move_y);
		if (_dist > 1)
		{
			_move_x /= _dist
			_move_y /= _dist
		}
	
		//Calcula o target do movimento
		var _target_x = _move_x * move_speed;
		var _target_y = _move_y * move_speed;
	
		//Calcula a aceleração/desaceleração
		var _rate_x = (_move_x != 0 ) ? accel : decel;
		var _rate_y = (_move_y != 0 ) ? accel : decel;
	
		//Aplica velocidade
		vel_x = lerp(vel_x, _target_x, _rate_x);
		vel_y = lerp(vel_y, _target_y, _rate_y);
	
		//Zera a velocidade se estiver no decimais
		if (abs(vel_x) < 0.05){ vel_x = 0 };
		if (abs(vel_y) < 0.05){ vel_y = 0 };
	}
	
	//Confirma colisão em alta velocidade para o X
	var _passo_x = vel_x
	while (_passo_x != 0 && place_meeting(x + _passo_x, y, obj_wall)) {
		 _passo_x = (abs(_passo_x) < 1) ? 0 : _passo_x - sign(_passo_x);
	}
	if (_passo_x != vel_x) vel_x = 0;
	x += _passo_x
	
	//Confirma colisão em alta velocidade para o Y
	var _passo_y = vel_y;
	while (_passo_y != 0 && place_meeting(x, y + _passo_y, obj_wall)) {
		_passo_y = (abs(_passo_y) < 1) ? 0 : _passo_y - sign(_passo_y);
	}
	if (_passo_y != vel_y) vel_y = 0;
	y += _passo_y
}

///@desc Calcula colisão entre entidades
function empurrar()
{
	//Pega a lista de tudo que pode ser empurrado
	var _lista = global.lista_empurrao
	
	//Limpa a lista
	ds_list_clear(_lista)
	
	//Preenche a lista com todas instâncias do clone
	var _instances = instance_place_list(x, y, obj_clone, _lista, false)
	
	//Se não houver nenhum clone, pode sairs
	if (_instances <= 0) exit;
	
	//Loopa entre todos os clones
	for(var i = 0; i < _instances; i++)
	{
		var _clone = _lista[| i];
		
		//Pega informações de posição ideal (lado a lado, sem entrar um no outro)
		var _rest = ((bbox_right - bbox_left) + (_clone.bbox_right - _clone.bbox_left)) *0.5
		var _dist = point_distance(x, y, _clone.x, _clone.y);
		var _ang = point_direction(x, y, _clone.x, _clone.y);
		var _collision = _rest-_dist;
		
		//Sem colisão, sai
		if(_collision <= 0) continue;
		
		//Calcula a força da correção a ser aplicada
		var _correction = _collision * 0.5
		var _x = lengthdir_x(_correction, _ang)
		var _y = lengthdir_y(_correction, _ang)
		
		//Avisa sobre a possível parede
		var _wall_x = true;
		var _wall_y = true;
		
		with (_clone)
		{
			//Se não houver parede, mover
			if(!place_meeting(x + _x, y, obj_wall)){ x += _x; _wall_x = false }
			if(!place_meeting(x, y + _y, obj_wall)){ y += _y; _wall_y = false }
		}
		
		//Se houver parede, transferir toda a correção ao aplicante
		_x = _wall_x ? _x * 2 : _x;
		_y = _wall_y ? _y * 2 : _y;
		
		//Se não houver parede, mover o aplicante
		if (!place_meeting(x - _x, y, obj_wall)){ x -= _x; }
		if (!place_meeting(x, y - _y, obj_wall)){ y -= _y; }
	}
}

/// @desc Atira baseado nos inputs
/// @arg {REAL} _mira Onde estava mirando
function atirar(_mira){
	//Se está no cooldown, sai
	if (cooldown > 0 || bullet_count <= 0){ exit };
	
	//Spawna a bala na posição correta
	var _spawn_dist = (gun != noone) ? gun.orbita+gun.cano : 0;
	var _spawn_x = x + lengthdir_x(_spawn_dist, _mira);
	var _spawn_y = y + lengthdir_y(_spawn_dist, _mira);
	
	//Efeito de Spread
	var _meio = bullet_spread * 0.5
	
	var _spr = (type == BULLET_OWNER.PLAYER) ? spr_bullet_player : spr_bullet_enemy
	
	var _espaco = sprite_get_width(_spr) * bullet_scale;
	var _raio = (bullet_count > 1) ? (bullet_count * _espaco) / (2 * pi) : 0;
	
	for (var i = 0; i < bullet_count; i++)
	{
		var _ang = _mira + random_range(-_meio, _meio)
		
		//Posição do anel (lá ele)
		var _ang_clump = _mira + (360 / bullet_count) * i;
		var _bx = _spawn_x + lengthdir_x(_raio, _ang_clump)
		var _by = _spawn_y + lengthdir_y(_raio, _ang_clump)
		
		var _bullet = instance_create_layer(_bx, _by, layer, obj_bullet);
	
		_bullet.bullet_dir = _ang;
		_bullet.bullet_speed = bullet_speed;
		_bullet.image_angle = _ang;
		_bullet.dmg = bullet_dmg;
		_bullet.owner_type = type;
		_bullet.sprite_index = (type == BULLET_OWNER.PLAYER) ? spr_bullet_player : spr_bullet_enemy;
		_bullet.image_xscale = bullet_scale
		_bullet.image_yscale = bullet_scale
	}
	
	//chama o shake se for o player
	//POR DISPARO, NÃO POR BALA
	if (type == BULLET_OWNER.PLAYER) { shake_add(global.shake_tiro, _mira); }
	
	//Ativa o cooldown
	cooldown = fire_rate;
}

/// @desc Sinaliza a morte do player
function game_over() {
	estado_trocar(GAME.MORTE);
}

/// @desc Limpa todas balas da tela
/// @arg {BOOL} _player_included Limpa as balas do player também se for true
function limpar_balas(_player_included = true)
{
	with (obj_bullet) {
		
		if(_player_included){ instance_destroy() }
		else
		{
			if(owner_type == BULLET_OWNER.CLONE)
			{
				instance_destroy()
			}
		}
	
	}
}

/// @desc Dasha na diração do movimento ou mouse
/// @arg {REAL} _move_x	Input Horizontal
/// @arg {REAL} _move_y	Input Vertival
/// @arg {REAL} _mira Angulo da mira
function dashear(_move_x, _move_y, _mira)
{
	if (!has_dash ||
		dash_cooldown > 0 ||
		dash_timer > 0) { exit; }
		
	//Checa se tem uma direção
	var _parado = (_move_x == 0 && _move_y == 0);
	dash_dir = _parado ? _mira : point_direction(0, 0, _move_x, _move_y);
	
	dash_timer = dash_dur;
	dash_cooldown = dash_cd;
	invul_timer = dash_dur + global.dash_invul_buffer
}

/// @desc Retorna se o player está perto do objeto
function perto_do_player(_dist = global.interacao_dist)
{
	if (!instance_exists(global.player)){ return false }
	
	var _dist_curta = (point_distance(x, y, global.player.x, global.player.y) <= _dist)
	
	return (_dist_curta)
}

/// @desc Desenha o aviso de interação
/// @arg {String} _texto
function desenhar_prompt(_texto)
{
	draw_set_font(fnt_debug)
	
	draw_set_halign(fa_center)
	
	draw_text(x, bbox_top - 12, _texto)
	
	draw_set_halign(fa_left)
	
	draw_set_font(-1)
}

/// @desc Decide qual interativo está mais perto
function interativo_atualizar()
{
	global.interacao_alvo = noone;
	
	if (!instance_exists(global.player)){ exit }
	
	var _melhor = noone;
	var _melhor_dist = global.interacao_dist;
	
	var _n = instance_number(obj_interativos)
	
	for(var i = 0; i < _n; i++)
	{
		var _inst = instance_find(obj_interativos, i);
		
		var _ok = false;
		with (_inst){ _ok = pode_interagir() }
		if (!_ok){ continue }
		
		var _d = point_distance(global.player.x, global.player.y, _inst.x, _inst.y)
		
		if(_d <= _melhor_dist)
		{
			_melhor_dist = _d;
			_melhor = _inst;
		}
	}
	
	global.interacao_alvo = _melhor;
}

/// @desc Esse objeto é o alvo de interação?
function interativo_ativo()
{
	return (global.interacao_alvo == id)
}