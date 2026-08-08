draw_set_font(fnt_final);
draw_set_color(c_black)

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

#region HUD de O Jogo (perdi)
if (room == rm_base && global.estado == GAME.LOOP || global.estado == GAME.GAP || global.estado == GAME.FREEZE)
{
	if (instance_exists(global.player))
	{
		var _lado = 25;
		var _gap = 10;
		
		for (var i = 0; i < global.player.max_hp; i++)
		{
			var _x1 = 40 + i * (_lado + _gap);
			var _oco = (i >= global.player.hp);
			draw_rectangle_color(_x1, 40, _x1 + _lado, 40 + _lado, c_black, c_black, c_black, c_black, _oco)
		}
	}
	
	var _tempo = loop_tempo_texto();
	if (_tempo != "")
	{
		var _u = urgencia_visual();
		
		//Treme e esquenta conforme o tempo acaba
		var _tx = random_range(-1, 1) * _u * global.relogio_tremor;
		var _ty = random_range(-1, 1) * _u * global.relogio_tremor;
		var _cr = merge_colour(c_black, global.vinheta_cor, _u);
		
		draw_set_halign(fa_center);
		draw_texto_color(_gw * 0.5 + _tx, 35 + _ty, _tempo, FNT_HUD, _cr);
		draw_set_halign(fa_left);
	}
	
	draw_set_halign(fa_right);
	draw_texto(_gw - 40, 35, string(global.pontos), FNT_HUD)
		
	var _falta = cartas_faltam()
	draw_texto(_gw - 40, 85, (_falta <=0) ? "CARTA AO FINAL DO LOOP" : "CARTA EM " + string(_falta), FNT_HUD)
	draw_set_halign(fa_left);
}

marcador_desenhar();

#endregion

#region TELAS DE ESTADO
switch (global.estado) {
	case GAME.MENU:
		menu_desenhar();
	break;
	
	case GAME.MORTE:
		go_desenhar();
	break;
	
	case GAME.CUTSCENE:
		draw_texto(100, 100, "[cutscene]", FNT_HUD);
	break;
	
	case GAME.GAP:
	
		if (global.loop_atual > 0 && global.placar_fase > PLACAR.RESPIRO) { placar_desenhar(); }
		
	break;
	
	
	case GAME.FREEZE:
	
		draw_set_halign(fa_center)
		draw_set_halign(fa_center)
		draw_texto(_gw * 0.5, 225, "ESCOLHA UMA CARTA", FNT_HUD);
			
		for (var i = 0; i < array_length(global.cartas_opcoes); i++)
		{
			var _c = global.cartas_opcoes[i];
			var _yy = 350 + (i * 125);
				
			draw_texto(_gw * 0.5, _yy, string( i + 1 ) + ") " + _c.nome, FNT_HUD);
			draw_texto(_gw * 0.5, _yy + 45, _c.desc, FNT_HUD);
		}
		draw_set_halign(fa_left)
	break;
}
#endregion

//Vinheta de tempo acabando (pulsa)
var _uv = urgencia_visual();
if (_uv > 0)
{
	var _pulso = 0.65 + 0.35 * sin(global.tick * global.vinheta_pulso);
	vinheta_desenhar(_uv * _pulso, global.vinheta_cor);
}

//Transição de loop
if (global.fade > 0)
{
	draw_set_alpha(global.fade);
	draw_rectangle_color(0, 0, _gw, _gh, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}

draw_set_halign(fa_left);
draw_set_font(-1);