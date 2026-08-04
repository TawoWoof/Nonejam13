enum GAME {
	MENU,		
	CUTSCENE,	
	GAP,		//Respiro
	LOOP,		//Jogando e Gravando
	MORTE		
}

/// @desc Transiciona pela pipeline do jogo
/// @arg {REAL} _novo Estado de destino
function estado_trocar(_novo) {
	global.estado_anterior = global.estado;
	global.estado = _novo;
	global.estado_timer = 0;
	
	switch (_novo) {
		case GAME.MENU:			entrar_menu();		break;
		case GAME.CUTSCENE:		entrar_cutscene();	break;
		case GAME.GAP:			entrar_gap();		break;
		case GAME.LOOP:			entrar_loop();		break;
		case GAME.MORTE:		entrar_morte();		break;
	}
}

/// @desc Roda o estado atual. Chamado uma vez por step pelo obj_game
function estado_passo() {
	global.estado_timer += 1;
	
	switch (global.estado) {
		case GAME.MENU:			passo_menu();		break;
		case GAME.CUTSCENE:		passo_cutscene();	break;
		case GAME.GAP:			passo_gap();		break;
		case GAME.LOOP:			passo_loop();		break;
		case GAME.MORTE:		passo_morte();		break;
	}
}
/// @desc Chama a gameplay
function jogo_rodando() {
	return (	global.estado != GAME.MENU
			&&  global.estado != GAME.MORTE
			&&  global.estado != GAME.CUTSCENE);
}
/// @desc Entra numa cutscene e então vai para o destino
/// @arg {REAL} _destino Estado depois da cutscene
/// @arg {REAL} _duracao Steps de duração
function cutscene_ir(_destino, _duracao = 120) {
	global.cutscene_destino = _destino;
	global.cutscene_duracao = _duracao;
	estado_trocar(GAME.CUTSCENE);
}

function entrar_menu() {
	global.gravando = false;
	if (room != rm_menu) { room_goto(rm_menu); }
}

function passo_menu() {
	if (keyboard_check_pressed(vk_anykey)) {
		estado_trocar(GAME.GAP);
	}
}

function entrar_gap() {
	if (room != Room1) { room_goto(Room1); }
}

function passo_gap() {
	if (global.estado_timer >= global.loop_gap) {
		estado_trocar(GAME.LOOP);
	}
}

function entrar_loop() {
	if (!instance_exists(global.loop_master)) exit;
	
	if (array_length(global.loop_master.loops) == 0) {
		global.gravando = true;
		exit;
	}
	
	with (global.loop_master) { loop_start(); }
}

function passo_loop() {
	//Loop End = GAP
	//Game Over() = MORTE
}

function entrar_morte() {
	global.gravando = false;
}

function passo_morte() {
	if (global.estado_timer >= global.morte_espera) {
		estado_trocar(GAME.MENU);
	}
}

function entrar_cutscene() {
	global.gravando = false;
}

function passo_cutscene() {
	if (global.estado_timer >= global.cutscene_duracao) {
		estado_trocar(global.cutscene_destino);
	}
}