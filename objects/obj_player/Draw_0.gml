draw_self()

var _move_x = keyboard_check(global.move_right) - keyboard_check(global.move_left);
var _move_y = keyboard_check(global.move_down) - keyboard_check(global.move_up);

var _dist = point_distance(0, 0, _move_x, _move_y);

draw_text(0, 0,_move_x);
draw_text(0, 15,_move_y);
draw_text(0, 30,_dist);