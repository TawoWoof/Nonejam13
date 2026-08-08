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
	
	//DASH
	if (dash_timer > 0)
	{
		
		dash_timer -= 1;
		vel_x = lengthdir_x(dash_speed, dash_dir);
		vel_y = lengthdir_y(dash_speed, dash_dir);
		
		//rastro
		if (dash_timer mod global.rastro_intervalo == 0)
		{
			var _rc = (type == BULLET_OWNER.PLAYER)
				? make_colour_hsv(((dash_dur - dash_timer) * global.rastro_hue_passo) mod 256, 200, 255)
				: cor;
			
			rastro_criar(x, y, sprite_index, image_index, image_xscale, image_yscale, image_angle, _rc);
		}
		
		//poeira
		
		repeat (global.poeira_dash_n)
		{
			poeira_criar(x, y + global.poeira_offset_y, dash_dir + 180, global.poeira_dash_forca);
		}
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
		if (abs(vel_x) < 0.2){ vel_x = 0 };
		if (abs(vel_y) < 0.2){ vel_y = 0 };
	}
	
	var _preso = place_meeting(x, y, obj_wall);
	
	//Confirma colisão em alta velocidade para o X
	var _passo_x = vel_x;
	while(!_preso && _passo_x != 0 && place_meeting(x + _passo_x, y, obj_wall))
	{
		_passo_x = (abs(_passo_x) < 1) ? 0 : _passo_x - sign(_passo_x);
	}
	if (_passo_x != vel_x){
		bater_parede(abs(vel_x), (vel_x > 0) ? 0 : 180);
		vel_x = 0;
		};
	x += _passo_x
	
	//Confirma colisão em alta velocidade para o Y
	var _passo_y = vel_y;
	while(!_preso && _passo_y != 0 && place_meeting(x, y + _passo_y, obj_wall))
	{
		_passo_y = (abs(_passo_y) < 1) ? 0 : _passo_y - sign(_passo_y);
	}
	if (_passo_y != vel_y){
		bater_parede(abs(vel_y), (vel_y > 0) ? 270 : 90);
		vel_y = 0;
		};
	y += _passo_y

	//Poeira de caminhada
	if (dash_timer <= 0 && point_distance(0, 0, _passo_x, _passo_y) > global.poeira_vel_min)
	{
		poeira_tick += 1;
		
		if (poeira_tick >= global.poeira_int)
		{
			poeira_tick = 0;
			
			repeat(global.poeira_walk_n)
			{
				poeira_criar(x, y + global.poeira_offset_y,
				point_direction(_passo_x, _passo_y, 0, 0), global.poeira_walk_forca);
			}
		}
	}
	else
	{
		//Parado
		poeira_tick = global.poeira_int;
	}
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
	var _spawn_dist = (gun != noone && instance_exists(gun)) ? gun.orbita + gun.cano : 0;
	var _spawn_x = x + lengthdir_x(_spawn_dist, _mira);
	var _spawn_y = y + lengthdir_y(_spawn_dist, _mira);
	
	//Efeito de Spread
	var _meio = bullet_spread * 0.5
	
	var _spr = (type == BULLET_OWNER.PLAYER) ? spr_bullet_player : spr_bullet_enemy
	
	var _dmg = bullet_dmg
	if (berserk > 0 && max_hp > 0)
	{
		var _falta = max(0, 1 - hp/max_hp)
		_dmg += floor(berserk * global.berserk_fator * power(_falta, global.bersek_curva));
	}
	
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
		_bullet.bounces_left = ricochete
		_bullet.pierce_left = perfuracao
		_bullet.explosao = explosao
		_bullet.curva = mira_curva
		_bullet.cor = cor
	}
	
	//chama o shake se for o player
	//POR DISPARO, NÃO POR BALA
	if (type == BULLET_OWNER.PLAYER) { shake_add(global.shake_tiro, _mira); }
	
	//Clarão no cano
	if (gun != noone && instance_exists(gun))
	{
		gun.flash_timer = global.muzzle_dur;
		gun.recuo = 1;
	}
	
	//Ativa o cooldown
	cooldown = max(2, round(fire_rate * power(global.adrenalina_fator, adrenalina * urgencia_relogio())));
}

/// @desc Sinaliza a morte do player
function game_over() {
	if (instance_exists(global.player))
	{
		tinta_splatter(global.player.x, global.player.y, global.tinta_raio_morte * 1.4,
			global.cor_player, global.tinta_gotas_morte, undefined, global.tinta_forca_morte);
		
		//Dispara a animação de queda e some com a arma
		global.player.anim_morte = true;
		global.player.image_index = 0;
		
		if (global.player.gun != noone && instance_exists(global.player.gun))
		{
			instance_destroy(global.player.gun);
			global.player.gun = noone;
		}
	}
	
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

/// @desc fração de urgencia do relógio (aumentar a cadencia de tiro)
function urgencia_relogio()
{
	if (global.estado != GAME.LOOP) return 0;
	if (global.loop_tempo == TIMELESS || global.loop_tempo <= 0) return 0;
	
	return power(0.5, (loop_steps_restantes() / global.adrenalina_meia_vida));
}

/// @desc Dano em área
/// @arg {REAL} _x
/// @arg {REAL} _y
/// @arg {REAL} _raio
/// @arg {REAL} _dmg
/// @arg {REAL} _dono
/// @arg {Id.Instance} _ignorar
function explodir(_x, _y, _raio, _dmg, _dono, _ignorar = noone)
{
	if (_raio <= 0) exit
	
	shake_add(global.shake_explosao, irandom(359));
	
	if (_dono == BULLET_OWNER.CLONE)
	{
		var _p = global.player;
		
		if (	instance_exists(_p)
				&& _p != _ignorar
				&& _p.invul_timer <= 0
				&& point_distance(_x, _y, _p.x, _p.y) <= _raio)
		{
			_p.hp -= _dmg;
			_p.invul_timer = global.hit_invul;
			
			if (_p.hp <= 0){ game_over() }
		}
		exit
	}
	
	with (obj_clone)
	{
		
		if (id == _ignorar || invul_timer > 0) continue;
		if (point_distance(_x, _y, x, y) > _raio) continue;
		
		hp -= _dmg;
		if (hp <= 0){ die(id, global.corpo_forca_explosao, point_direction(_x, _y, x, y)) }
	}
}

/// @desc Alvo da bala teleguiada
/// @arg {REAL} _x
/// @arg {REAL} _y
/// @arg {REAL} _dir
/// @arg {Asset.GMObject} _obj
function alvo_curva(_x, _y, _dir, _obj)
{
	var _melhor = noone;
	var _melhor_dist = global.curva_alcance;
	
	with(_obj)
	{
		var _d = point_distance(_x, _y, x, y);
		
		if (_d > _melhor_dist) continue;
		
		//Fora do cone frontal, ignora
		var _dif = angle_difference(point_direction(_x, _y, x, y), _dir);
		if (abs(_dif) > global.curva_angulo) continue;
		
		_melhor_dist = _d;
		_melhor = id;
	}
	
	return _melhor;
}

/// @desc Empurra a instância pra fora de paredes, se estiver presa
/// @arg {REAL} _passo Distância entre anéis de busca
/// @arg {REAL} _max Raio máximo de busca
function desencavar(_passo = 16, _max = 384)
{
	if (!place_meeting(x, y, obj_wall)) exit;
	
	for (var _r = _passo; _r <= _max; _r += _passo)
	{
		for (var _a = 0; _a < 360; _a += 30)
		{
			var _nx = x + lengthdir_x(_r, _a);
			var _ny = y + lengthdir_y(_r, _a);
			var _bw = (bbox_right - bbox_left) * 0.5;
			var _bh = (bbox_bottom - bbox_top) * 0.5;

			if ((_nx - _bw) < 0 || (_nx + _bw) >= room_width) continue;
			if ((_ny - _bh) < 0 || (_ny + _bh) >= room_height) continue;
			if (place_meeting(_nx, _ny, obj_wall)) continue;
			
			
			x = _nx;
			y = _ny;
			exit;
		}
	}
}



/// @desc Reage a uma batida em parede
/// @arg {REAL} _vel Velocidade no instante do impacto
/// @arg {REAL} _dir Direção em que estava indo
function bater_parede(_vel, _dir)
{
	if (_vel < global.impacto_min) exit;
	
	var _forca = min(_vel * global.impacto_escala, global.impacto_max);
	
	var _horizontal = (abs(lengthdir_x(1, _dir)) > 0.5);
	anim_impacto += _horizontal ? -_forca : _forca;
	
	//Tinta no ponto de contato na cor de quem bateu
	var _raio = (bbox_right - bbox_left) * 0.5;
	
	tinta_splatter(x + lengthdir_x(_raio, _dir), y + lengthdir_y(_raio, _dir),
		global.impacto_tinta_raio, cor, global.impacto_tinta_gotas, _dir, global.impacto_tinta_forca);
}