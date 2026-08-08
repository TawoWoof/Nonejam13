spawn_tick += 1;
if (spawn_tick >= global.menu_spawn_int)
{
	spawn_tick = 0;
	
	global.menu_spawn_int = irandom_range(45, 140)
	
	menu_spawnar();
}

//Botões
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

global.menu_botao = -1;

for (var i = 0; i < array_length(global.menu_botoes); i++)
{
	var _r = menu_botao_rect(i);
	
	if (_mx >= _r[0] && _mx <= _r[2] && _my >= _r[1] && _my <= _r[3])
	{
		global.menu_botao = i;
		if (mouse_check_button_pressed(mb_left)) { global.menu_botoes[i].acao(); }
	}
}