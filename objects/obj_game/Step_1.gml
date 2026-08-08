if (keyboard_check_pressed(vk_f11)) { window_set_fullscreen(!window_get_fullscreen()); }

global.tick += 1;
global.frame_ativo = true;

//Hitstop: congela TUDO, inclusive o relógio do loop
if (global.hitstop > 0)
{
	global.hitstop -= 1;
	global.frame_ativo = false;
	exit;
}

if (!global.mouse_preso || !window_has_focus()) exit;

var _wx = window_get_x();
var _wy = window_get_y();
var _ww = window_get_width();
var _wh = window_get_height();

var _mx = display_mouse_get_x();
var _my = display_mouse_get_y();

var _cx = clamp(_mx, _wx + 1, _wx + _ww - 2);
var _cy = clamp(_my, _wy + 1, _wy + _wh - 2);

if (_mx != _cx || _my != _cy) { display_mouse_set(_cx, _cy); }

estado_passo();