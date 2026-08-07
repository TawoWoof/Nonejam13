enum GAME {
	MENU,		
	CUTSCENE,	
	GAP,		//Respiro
	LIVRE,		//Movimento sem gravação
	FREEZE,		//Sem movimento de entidades
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
		case GAME.LIVRE:		entrar_livre();		break;
		case GAME.FREEZE:		entrar_freeze();	break;
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
		case GAME.LIVRE:		passo_livre();		break;
		case GAME.FREEZE:		passo_freeze();		break;
		case GAME.LOOP:			passo_loop();		break;
		case GAME.MORTE:		passo_morte();		break;
	}
}
/// @desc Chama a gameplay
function jogo_rodando() {
	
	if (!global.frame_ativo) return false;
	
	return (	global.estado != GAME.MENU
			&&  global.estado != GAME.MORTE
			&&  global.estado != GAME.CUTSCENE
			&&  global.estado != GAME.GAP
			&&  global.estado != GAME.FREEZE);
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
	run_resetar();
	
	if (room != rm_menu) { room_goto(rm_menu); }
}

function passo_menu() {
	if (keyboard_check_pressed(vk_anykey)) {
		estado_trocar(GAME.GAP);
	}
}

function entrar_gap() {
	global.gravando = false;
	
	if (global.loop_atual <= 0) { global.fade = 1; }
	
	if (room != rm_base) { room_goto(rm_base); }
}

function passo_gap() {
	
	if (room != rm_base){ exit };
	if (!instance_exists(global.loop_master) || !instance_exists(global.player)){ exit };
	
	var _espera = (global.loop_atual <= 0) ? 0 : global.loop_gap;
	
	if (_espera > 0)
	{

		if (global.estado_timer >= global.gap_min && keyboard_check_pressed(vk_anykey))
		{
			global.estado_timer = max(global.estado_timer, _espera - global.transicao_dur);
		}
		
		var _falta = _espera - global.estado_timer;
		global.fade = clamp(1 - (_falta / global.transicao_dur), 0, 1);
		global.morph = -global.fade;
	}
	
	if (global.estado_timer < _espera){ exit };
	
	global.fade = 1;
	
	if (global.cartas_disponiveis > 0)
	{
		estado_trocar(GAME.FREEZE)
		exit;
	}
	
	estado_trocar(GAME.LOOP);
}

function entrar_loop() {
	
	if (!instance_exists(global.loop_master)) exit;
	
	if (array_length(global.loop_master.loops) == 0) {
		
		global.player.loop_start_x = global.player.x
		global.player.loop_start_y = global.player.y
		global.gravando = true;
	} else {
		with (global.loop_master) { loop_start(); }
	}
	
	global.loop_tempo = loop_tempo_calcular(global.loop_atual);
	global.pontos_abates = 0;
	global.pontos_tempo = 0;
	
	//Chega com efeitos de transição
	global.fade = 1;
	global.morph = 1;
	
	limpar_balas()
	
	limpar_balas()
}

function passo_loop() {

	if (global.fade > 0)
	{
		global.fade = max(0, global.fade - 1 / global.transicao_dur);
		global.morph = global.fade;
	}
	
	if (global.loop_tempo == TIMELESS) exit;
	
	//Relógio do loop
	if (global.estado_timer == global.loop_tempo) {
		timer_estourou();
	}
}

function entrar_morte() {
	global.fade = 0;
	global.morph = 0;
	global.gravando = false;
}

function passo_morte() {
	if (global.estado_timer >= global.morte_espera) {
		estado_trocar(GAME.MENU);
	}
}

function entrar_livre() {
	global.gravando = false;
	
	if (room != Room1) { room_goto(Room1); }
}

function passo_livre() {

}

function entrar_cutscene() {
	global.gravando = false;
}

function passo_cutscene() {
	if (global.estado_timer >= global.cutscene_duracao) {
		estado_trocar(global.cutscene_destino);
	}
}

/// @desc Steps que sobraram no relógio do loop
function loop_steps_restantes() {
	if (global.estado != GAME.LOOP) return 0;
	if (global.loop_tempo == TIMELESS) return 0;
	
	return max(0, global.loop_tempo - global.estado_timer);
}

/// @desc Milissegundos restantes
function loop_ms_restantes() {
	return floor(loop_steps_restantes() * 1000 / game_get_speed(gamespeed_fps));
}

/// @desc Formata tempo como S.MMM
/// @arg {REAL} _ms Milissegundos
function tempo_formatar(_ms) {
	var _seg = floor(_ms / 1000);
	var _mil = _ms mod 1000;
	
	//Zero à esquerda pra sempre ter 3 casas
	var _txt = string(_mil);
	while (string_length(_txt) < 3) { _txt = "0" + _txt; }
	
	return string(_seg) + "." + _txt;
}

function timer_estourou() {
	game_over();
}

/// @desc Calcula o relógio de um loop em steps
/// @arg {REAL} _loop Número do loop
function loop_tempo_calcular(_loop) {
	//Loops de tutorial rodam sem relógio
	if (_loop <= global.loops_tutorial) return TIMELESS;
	
	//Bônus vindo de carta
	var _bonus = instance_exists(global.player) ? global.player.tempo_bonus : 0;
	
	//Aumenta o tempo baseado na quantidade de clones
	return global.tempo_base + (global.tempo_por_clone * _loop) + _bonus;
}

/// @desc Texto do relógio pro HUD
function loop_tempo_texto() {
	if (global.estado != GAME.LOOP) return "";
	if (global.loop_tempo == TIMELESS) return "";
	
	return tempo_formatar(loop_ms_restantes());
}

function entrar_freeze()
{
	global.freeze_saindo = false;
	global.morph = 0;
	
	global.cartas_opcoes = cartas_sortear_varias(global.cartas_opcoes_n);
}

function passo_freeze()
{
	if (!global.freeze_saindo && global.fade > 0)
	{
		global.fade = max(0, global.fade - 1 / global.transicao_dur);
		exit;
	}
	
	if (global.freeze_saindo)
	{
		global.fade = min(1, global.fade + 1 / global.transicao_dur);
		global.morph = -global.fade;
		
		if (global.fade >= 1)
		{
			global.freeze_saindo = false;
			
			//Outra carta pendente reabre a escolha
			if (global.cartas_disponiveis > 0)
			{
				estado_trocar(GAME.FREEZE);
				exit;
			}
			
			estado_trocar(GAME.LOOP);
		}
		
		exit;
	}
	
	var _n = array_length(global.cartas_opcoes);
	
	if(_n == 0)
	{
		global.freeze_saindo = true;
		exit
	}
	
	for (var i=0; i < _n; i++)
	{
		if (!keyboard_check_pressed(ord(string(i+1)))){ continue }
		
		carta_obter(global.cartas_opcoes[i]);
		global.cartas_disponiveis -= 1;
		
		global.cartas_opcoes = []
		global.freeze_saindo = true;
		exit
	}
}

/// @desc Quantos loops até a carta
function cartas_faltam()
{
	if (global.loop_atual <= 0) return global.cartas_intervalo;
	
	return global.cartas_intervalo - 1 - ((global.loop_atual - 1) mod global.cartas_intervalo)
}

/// @desc Zera tudo que dura uma run.
/// Global sobrevive à troca de room, então precisa de reset explícito
function run_resetar()
{
	global.fade = 0;
	global.morph = 0;
	global.freeze_saindo = false;;
	
	global.inventario = start_inventario();
	global.cartas_disponiveis = 0;
	global.cartas_opcoes = [];
	
	global.loop_atual = 0;
	global.loop_tempo = TIMELESS;
	
	global.pontos = 0;
	global.pontos_abates = 0;
	global.pontos_tempo = 0;
	global.kills_loop = 0;
	
	global.gravando = false;
	global.hitstop = 0;
}

/// @desc Urgência do relógio para efeitos visuais (Separar da adrenalina)
function urgencia_visual()
{
	if (global.estado != GAME.LOOP) return 0;
	if (global.loop_tempo == TIMELESS) return 0;
	
	return power(0.5, loop_steps_restantes() / global.vinheta_meia_vida);
}