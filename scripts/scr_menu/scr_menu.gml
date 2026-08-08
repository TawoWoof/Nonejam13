/// @desc Retângulo de um botão do menu na GUI
function menu_botao_rect(_i)
{
	var _cx = display_get_gui_width() * 0.5;
	var _y = global.menu_botao_y + _i * global.menu_botao_dy;
	
	return [_cx - global.menu_botao_w * 0.5, _y,
			_cx + global.menu_botao_w * 0.5, _y + global.menu_botao_h];
}

function menu_spawnar()
{
	var _cor = loop_cor(irandom(11));
	var _m = 300;
	var _x = 0, _y = 0, _dir = 0;
	
	switch (irandom(3))
	{
		case 0: _x = -_m;                 _y = irandom(room_height); _dir = irandom_range(-40, 40);  break;
		case 1: _x = room_width + _m;     _y = irandom(room_height); _dir = irandom_range(140, 220); break;
		case 2: _x = irandom(room_width); _y = -_m;                  _dir = irandom_range(230, 310); break;
		case 3: _x = irandom(room_width); _y = room_height + _m;     _dir = irandom_range(50, 130);  break;
	}
	
	//Força alta = atravessa muito. Baixa = para logo depois de entrar
	var _forca = (random(1) < global.menu_tipo2_chance) ? random_range(70, 130) : random_range(35, 60);
	
	tinta_splatter(_x, _y, global.tinta_raio_morte, _cor,
		global.tinta_gotas_morte, _dir, global.tinta_forca_morte);
	
	corpo_solto(_x, _y, _cor, _forca, _dir);
}

/// @desc Título e botões do menu
function menu_desenhar()
{
	var _cx = display_get_gui_width() * 0.5;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_black);
	
	draw_set_font(fnt_final);
	
	draw_texto(_cx, global.menu_titulo_y, "HERANÇA", FNT_GIGANTIC);
	
	for (var i = 0; i < array_length(global.menu_botoes); i++)
	{
		var _r = menu_botao_rect(i);
		var _sel = (global.menu_botao == i);
		
		draw_set_alpha(_sel ? 1 : 0.55);
		draw_sprite_stretched(spr_menu_button, 0, _r[0], _r[1], _r[2] - _r[0], _r[3] - _r[1])
		draw_texto((_r[0] + _r[2]) * 0.5, (_r[1] + _r[3]) * 0.5, global.menu_botoes[i].texto, FNT_MEDIUM);
	}
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(-1);
}

/// @desc Desenha um botão com bordas grossas
/// @arg {REAL} _x1
/// @arg {REAL} _y1
/// @arg {REAL} _x2
/// @arg {REAL} _y2
/// @arg {Id.Color} _color
/// @arg {REAL} _w
function draw_botao(_x1, _y1, _x2, _y2, _color, _w)
{
	draw_line_width_colour(_x1, _y1, _x2, _y1, _w, _color, _color)
	draw_line_width_colour(_x1, _y2, _x2, _y2, _w, _color, _color)
	draw_line_width_colour(_x1, _y1, _x1, _y2, _w, _color, _color)
	draw_line_width_colour(_x2, _y1, _x2, _y2, _w, _color, _color)
}