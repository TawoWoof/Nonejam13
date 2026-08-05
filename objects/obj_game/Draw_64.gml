draw_set_font(fnt_debug);

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
	
	case GAME.FREEZE:
		draw_text(40, 40, "ESCOLHA UMA CARTA");
		
		for (var i = 0; i < array_length(global.cartas_opcoes); i++)
		{
			var _c = global.cartas_opcoes[i];
			var _yy = 80 + (i * 50);
			
			draw_text(40, _yy,      string(i + 1) + ") " + _c.nome);
			draw_text(60, _yy + 18, _c.desc);
		}
	break;
	
	case GAME.LOOP:
		draw_text(40, 20, "PONTOS: " + string(global.pontos));
		draw_text(40, 40, "TEMPO: " + loop_tempo_texto());
		draw_text(40, 60, "ABATES: " + string(global.pontos_abates));
		break;
	
	case GAME.GAP:
		draw_text(40, 20, "PONTOS: " + string(global.pontos));
		break;
		
	case GAME.LIVRE:
		draw_text(40, 20, "PONTOS: " + string(global.pontos));
		if (global.cartas_disponiveis > 0)
		{
			draw_text(40, 40, "CARTAS PENDENTES: " + string(global.cartas_disponiveis));
		}
		break;
}

draw_set_font(-1);