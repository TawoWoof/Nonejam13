if (instance_number(obj_game) > 1) { instance_destroy(); exit; }

global.estado = GAME.MENU;
global.estado_anterior = GAME.MENU;
global.estado_timer = 0;

global.cutscene_destino = GAME.MENU;
global.cutscene_duracao = 120;

global.gravando = false;