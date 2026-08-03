var _move_x = lengthdir_x(bullet_speed, bullet_dir);
var _move_y = lengthdir_y(bullet_speed, bullet_dir);

x += _move_x;
y += _move_y;

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

timer_vida -= 1;
if (timer_vida <= 0) {
	instance_destroy();
	exit;
}

var _margin = 32;
var _x_exit = (x < -_margin || x > room_width + _margin);
var _y_exit = (y < -_margin || y > room_height + _margin);

if (_x_exit || _y_exit) {
	instance_destroy();
}