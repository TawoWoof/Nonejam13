#macro TIMELESS -1

enum BULLET_OWNER
{
	PLAYER,
	CLONE
}

global.lista_empurrao = ds_list_create();

global.debug = false;			//Mostra texto debug
global.gravando = false;		//Grava os inputs

global.loop_gap = 45;			//Tempo após limpar sala
global.morte_espera = 120;		//Tempo na tela de morte
global.delay = 45;				//Tempo antes dos clones se moverem

global.loop_tempo = TIMELESS;	//Relógio DESTE loop, recalcula a cada entrada
global.loops_tutorial = 1;		//Qual loop finaliza o tutorial
global.tempo_base = 600;		//Mínimo de tempo em loop (60 = 1s)
global.tempo_por_clone = 300;	//Tempo extra por clone

global.pontos = 0;				//Pontuação da run
global.kills_loop = 0;			//Kills acumuladas no loop atual
global.pontos_segundo = 1000;	//Pontos por segundo restante no relógio

global.clone_pontos = 100;		//Valor base de um clone
global.loop_factor = 1;			//Peso do loop de origem no valor do clone
global.pontos_abates = 0;		//Pontos de abate no loop atual
global.pontos_tempo = 0;		//Pontos de relógio do último loop

global.inventario = ["arma_inicial"];			//ID de upgrades (Repetir = empilhar)

global.tutorial_x = 0;			//Coordenadas do clone tutorial na room
global.tutorial_y = 0;			//Coordenadas do clone tutorial na room

global.move_right	=	 ord("D");
global.move_left	=	 ord("A");
global.move_down	=	 ord("S");
global.move_up		=	 ord("W");
global.interagir	=	 ord("F")
global.dash			=	 vk_space;
global.shoot		=	 mb_left;

global.dash_invul_buffer = 5;	//Invulnerabilidade EXTRA (depois do dash)
global.hit_invul = 40;			//Invulnerabilidade após dano
global.interacao_dist = 64;		//Distância máxima pra interagir com objetos
global.interacao_alvo = noone	//objeto alvo de interação

global.cartas_disponiveis = 0;	//	
global.cartas_intervalo = 5;	//	
global.cartas_opcoes = [];		//
global.cartas_opcoes_n = 3;		//

global.player = noone;
global.loop_master = noone;

function start_stats() {
	return {
		move_speed: 4,
		fire_rate: 20,
		bullet_speed: 8,
		bullet_dmg: 1,
		bullet_count: 1, //0
		bullet_spread: 0, //18
		bullet_scale: 1,
		
		ricochete: 0,
		perfuracao: 0,
		sanguessuga: 0,
		tempo_por_kill: 0,
		adrenalina: 0,
		berserk: 0,
		explosao: 0,
		estilhacos: 0,
		sono: 0,
		mira_curva: 0,
		
		max_hp: 1,
		accel: 0.1,
		decel: 0.3,
		clone_bullet_multiplier: 0.5,
		has_dash: false,
		dash_speed: 14,
		dash_dur: 10,
		dash_cd: 45,
		teleport_dist: 96,
		tempo_bonus: 0,
		pontos_bonus: 0
		
	};
}