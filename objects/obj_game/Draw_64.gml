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
		draw_text(40, 40, "F PARA COMEÇAR O LOOP");
		break;
}

draw_set_font(-1);