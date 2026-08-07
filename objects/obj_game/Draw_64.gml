draw_set_font(fnt_debug);

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

#region HUD de O Jogo (perdi)
if (room == rm_base && global.estado == GAME.LOOP || global.estado == GAME.GAP || global.estado == GAME.FREEZE)
{
	if (instance_exists(global.player))
	{
		var _lado = 10;
		var _gap = 4;
		
		for (var i = 0; i < global.player.max_hp; i++)
		{
			var _x1 = 16 + i * (_lado + _gap);
			
			var _oco = (i >= global.player.hp);
			
			draw_rectangle_color(_x1, 16, _x1 + _lado, 16 + _lado, c_white, c_white, c_white, c_white, _oco)
		}
	}
	
	var _tempo = loop_tempo_texto();
	if (_tempo != "")
	{
		draw_set_halign(fa_center);
			draw_text(_gw * 0.5, 14, _tempo)
		draw_set_halign(fa_left);
	}
	
	draw_set_halign(fa_right);
	draw_text(_gw - 16, 14, string(global.pontos))
	
	var _falta = cartas_faltam()
	draw_text(_gw - 16, 34, (_falta <=0) ? "CARTA AO FINAL DO LOOP" : "CARTA EM " + string(_falta))
	draw_set_halign(fa_left);
}
#endregion

#region TELAS DE ESTADO
switch (global.estado) {
	case GAME.MENU:
		draw_text(40, 40, "APERTE QUALQUER TECLA");
		break;
	
	case GAME.MORTE:
		draw_text(40, 40, "MORREU — loop " + string(global.loop_atual));
		draw_text(40, 60, "PONTOS: " + string(global.pontos));
		break;
	
	case GAME.CUTSCENE:
		draw_text(40, 40, "[cutscene]");
		break;
	
	case GAME.GAP:
		if (global.loop_atual > 0)
		{
			draw_set_halign(fa_center)
			
			draw_text(_gw * 0.5, 120, "LOOP " + string(global.loop_atual) + " FECHADO");
			draw_text(_gw * 0.5, 156, "ABATES " + string(global.pontos_abates));
			draw_text(_gw * 0.5, 176, "TEMPO " + string(global.pontos_tempo));
			draw_text(_gw * 0.5, 206, "TOTAL " + string(global.pontos));
			
			draw_set_halign(fa_left)
		}
	break;
	
	
	case GAME.FREEZE:
	
		draw_set_halign(fa_center)
		draw_text(_gw * 0.5, 90, "ESCOLHA UMA CARTA");
		
		for (var i = 0; i < array_length(global.cartas_opcoes); i++)
		{
			var _c = global.cartas_opcoes[i];
			var _yy = 140 + (i * 50);
			
			draw_text(_gw * 0.5, + _yy, string( i + 1 ) + ") " + _c.nome);
			draw_text(_gw * 0.5, + _yy + 18, _c.desc);
		}
		draw_set_halign(fa_left)
	break;
}
#endregion

draw_set_font(-1);