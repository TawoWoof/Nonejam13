draw_set_font(fnt_debug);

switch (global.estado) {
	case GAME.MENU:
		draw_text(40, 40, "APERTE QUALQUER TECLA");
		break;
	
	case GAME.MORTE:
		draw_text(40, 40, "MORREU — loop " + string(global.loop_atual));
		break;
	
	case GAME.CUTSCENE:
		draw_text(40, 40, "[cutscene]");
		break;
}

draw_set_font(-1);