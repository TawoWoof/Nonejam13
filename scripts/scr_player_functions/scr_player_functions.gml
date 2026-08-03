function mover(_move_x, _move_y) {
	var _dist = point_distance(0, 0, _move_x, _move_y);
	if (_dist > 1) {
		_move_x /= _dist;
		_move_y /= _dist;
	}
	
	x += _move_x * move_speed;
	y += _move_y * move_speed;
}

function atirar(_mira){
	if (cooldown > 0) exit;
	
	var _spawn_dist = (gun != noone) ? gun.orbita+gun.cano : 0;
	var _spawn_x = x + lengthdir_x(_spawn_dist, _mira);
	var _spawn_y = y + lengthdir_y(_spawn_dist, _mira);
	var _bullet = instance_create_layer(_spawn_x, _spawn_y, layer, obj_bullet);
	
	_bullet.bullet_dir = _mira;
	_bullet.bullet_speed = bullet_speed;
	_bullet.image_angle = _mira;
	_bullet.dmg = bullet_dmg;
	_bullet.owner_type = type;
	
	cooldown = fire_rate;
}

function game_over() {
	//Show message para avisar bem na cara que morreu!
	show_message("Player morreu (hp <= 0)");
}