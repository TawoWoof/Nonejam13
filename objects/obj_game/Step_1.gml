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

estado_passo();