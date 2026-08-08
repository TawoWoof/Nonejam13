if (instance_number(obj_game) > 1) { instance_destroy(); exit; }

window_set_fullscreen(true);

global.estado = GAME.MENU;
global.estado_anterior = GAME.MENU;
global.estado_timer = 0;

global.cutscene_destino = GAME.MENU;
global.cutscene_duracao = 120;

global.gravando = false;

run_resetar();

display_set_gui_size(1920, 1080)

global.mouse_preso = true;

recordes_carregar();