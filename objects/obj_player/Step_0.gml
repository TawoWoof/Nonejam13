//Calcula a diração do movimento
var _move_x = keyboard_check(global.move_right) - keyboard_check(global.move_left);
var _move_y = keyboard_check(global.move_down) - keyboard_check(global.move_up);

//Normaliza a velocidade das diagonais
var _dist = point_distance(0, 0, _move_x, _move_y)
if(_dist > 1){
	_move_x /= _dist;
	_move_y /= _dist;
}

//executa o movimento
x += _move_x * move_speed;
y += _move_y * move_speed;