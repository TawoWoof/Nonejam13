if (!jogo_rodando()) exit;

//Movimentação do tiro
//Calcula o ângulo
var _move_x = lengthdir_x(bullet_speed, bullet_dir);
var _move_y = lengthdir_y(bullet_speed, bullet_dir);

//Efetua a Movimentação
x += _move_x;
y += _move_y;

//Colisão com parede
if (place_meeting(x, y, obj_wall)) {
	instance_destroy();
	exit;
}

//Busca acertos
if (owner_type == BULLET_OWNER.PLAYER) {
	
	//Descobre qual clone foi atingido
	var _alvo = instance_place(x, y, obj_clone);
	if (_alvo != noone) {
		_alvo.hp -= dmg;
		if (_alvo.hp <= 0) {
			die(_alvo)
		}
		instance_destroy();
		exit;
	}
} else if (owner_type == BULLET_OWNER.CLONE) {
	
	//Checa colisão com o player
	if (place_meeting(x, y, obj_player)) {
		global.player.hp -= dmg;
		if (global.player.hp <= 0) {
			game_over();
		}
		instance_destroy();
		exit;
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