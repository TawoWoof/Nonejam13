if (!jogo_rodando()) exit;

//Ataque Teleguiado
if (curva > 0)
{
	var _dono = (owner_type == BULLET_OWNER.PLAYER) ? obj_clone : obj_player
	var _alvo_curva = alvo_curva(x, y, bullet_dir, _dono);
	
	if (_alvo_curva != noone)
	{
		var _dif = angle_difference(point_direction(x, y, _alvo_curva.x, _alvo_curva.y), bullet_dir)
		
		bullet_dir += clamp(_dif, -curva, curva)
		image_angle = bullet_dir
	}
}

//Movimentação do tiro
//Calcula o ângulo
var _move_x = lengthdir_x(bullet_speed, bullet_dir);
var _move_y = lengthdir_y(bullet_speed, bullet_dir);


//Colisão com parede
//Precisa ser por eixo pra calcular o bounce

//Colisão X
if (place_meeting(x + _move_x, y, obj_wall))
{
	if (bounces_left > 0)
	{
		bounces_left -= 1;
		bullet_dir = 180 - bullet_dir;
		image_angle = bullet_dir;
		_move_x = lengthdir_x(bullet_speed, bullet_dir)
	}
	else
	{
		tinta_splatter(x, y, global.tinta_raio_parede, cor, global.tinta_gotas_parede, bullet_dir + 180, 4);
		instance_destroy();
		exit
	}
}
x += _move_x;

//Colisão Y
if (place_meeting(x, y + _move_y, obj_wall))
{
	if (bounces_left > 0)
	{
		bounces_left -= 1;
		bullet_dir = -bullet_dir;
		image_angle = bullet_dir;
		_move_y = lengthdir_y(bullet_speed, bullet_dir)
	}
	else
	{
		tinta_splatter(x, y, global.tinta_raio_parede, cor, global.tinta_gotas_parede, bullet_dir + 180, 4);
		instance_destroy();
		exit
	}
}
y += _move_y;

//Busca acertos
if (owner_type == BULLET_OWNER.PLAYER) {
	
	var _alvo = instance_place(x, y, obj_clone);
	
	if (_alvo == noone)
	{
		ultimo_alvo = noone
	}
	else if (_alvo != ultimo_alvo && _alvo.invul_timer <= 0) {
		
		ultimo_alvo = _alvo;
		
		_alvo.hp -= dmg;
		_alvo.ultimo_hit_dir = bullet_dir;
		_alvo.flash_timer = global.flash_dur;
		
		if (_alvo.hp > 0)
		{
			tinta_splatter(_alvo.x, _alvo.y, global.tinta_raio_hit, _alvo.cor,
				global.tinta_gotas_hit, bullet_dir, global.tinta_forca_hit);
		}
		
		if (explosao > 0){ explodir(x, y, explosao, dmg, owner_type, _alvo) }
		
		if (_alvo.hp <= 0) {
			die(_alvo, bullet_speed, bullet_dir)
		}
		
		if (pierce_left > 0)
		{
			pierce_left -= 1;
		}else{
			tinta_splatter(x, y, global.tinta_raio_parede, cor, global.tinta_gotas_parede, bullet_dir + 180, 4);
			instance_destroy();
			exit;
		}
	}
} else if (owner_type == BULLET_OWNER.CLONE) {
	
	var _tocando = place_meeting(x, y, obj_player)
	
	if (!_tocando)
	{
		ja_atingiu_player = false
	}else if (!ja_atingiu_player) {
		
		ja_atingiu_player = true;
		
		if(global.player.invul_timer <= 0)
		{
			global.player.hp -= dmg;
			global.player.invul_timer = global.hit_invul;
			global.player.flash_timer = global.flash_dur;
			
			if (explosao > 0){ explodir(x, y, explosao, dmg, owner_type, global.player) }
			
			if (global.player.hp <= 0) {
			game_over();
		}
		}
		
		if (pierce_left > 0)
		{
			pierce_left -= 1;
		}else{
			tinta_splatter(x, y, global.tinta_raio_parede, cor, global.tinta_gotas_parede, bullet_dir + 180, 4);
			instance_destroy()
			exit
		}
	}
}

//Rede de segurança
var _margem = 64;
var _x1 = 0 - _margem
var _x2 = room_width + _margem
var _y1 = 0 - _margem
var _y2 = room_height + _margem

if(x < _x1 || x > _x2 || y < _y1 || y > _y2)
{
	instance_destroy()
}