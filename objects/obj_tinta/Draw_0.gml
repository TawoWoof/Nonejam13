if (!surface_exists(tinta))
{
	tinta = surface_create(room_width, room_height);
	
	surface_set_target(tinta);
	draw_clear(c_white);
	surface_reset_target();
	
	carimbados = 0;				
}

//Carimba só o que ainda não foi
if (global.tinta_fade > 0)
{
	surface_set_target(tinta);
	draw_set_alpha(global.tinta_fade);
	draw_rectangle_color(0, 0, surface_get_width(tinta), surface_get_height(tinta),
		c_white, c_white, c_white, c_white, false);
	draw_set_alpha(1);
	surface_reset_target();
}

//Poda ANTES de medir o total
if (array_length(historico) > global.tinta_historico_max)
{
	var _corte = array_length(historico) - global.tinta_historico_max;
	array_delete(historico, 0, _corte);
	carimbados = max(0, carimbados - _corte);
}

var _total = array_length(historico);

if (carimbados < _total)
{
	var _sw = surface_get_width(tinta);
	var _sh = surface_get_height(tinta);
	
	surface_set_target(tinta);
	
	for (var i = carimbados; i < _total; i++)
	{
		var _m = historico[i];
		
		if (_m.tipo == "corpo")
		{
			draw_sprite_ext(_m.spr, _m.img, _m.x, _m.y, _m.xs, _m.ys, _m.ang, _m.cor, global.tinta_alpha);
			continue;
		}
		
		draw_set_color(_m.cor);
		draw_set_alpha(global.tinta_alpha);
		
		var _c = _m.circulos;
		for (var j = 0; j < array_length(_c); j++)
		{
			draw_circle(_c[j].x, _c[j].y, _c[j].r, false);
		}
		
		draw_set_alpha(1);
	}
	
	draw_set_color(c_white);
	surface_reset_target();
	
	carimbados = _total;
}

gpu_set_blendmode_ext(bm_dest_colour, bm_zero);

draw_surface(tinta, 0, 0);

gpu_set_blendmode(bm_normal);