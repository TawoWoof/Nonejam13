#macro TIMELESS -1

enum BULLET_OWNER
{
	PLAYER,
	CLONE
}

global.lista_empurrao = ds_list_create();

global.debug = false;			//Mostra texto debug
global.gravando = false;		//Grava os inputs

global.loop_gap = 120;			//Tempo após limpar sala
global.gap_min = 30;			//Frames antes de poder pular a contagem
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

global.inventario = start_inventario();			//ID de upgrades (Repetir = empilhar)

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

global.adrenalina_meia_vida = 120;
global.adrenalina_fator = 0.8;
global.berserk_fator = 3.1;
global.bersek_curva = 1.6;
global.curva_alcance = 160;
global.curva_angulo = 25;

global.cartas_disponiveis = 0;
global.cartas_intervalo = 5;		
global.cartas_opcoes = [];		
global.cartas_opcoes_n = 3;		

global.player = noone;
global.loop_master = noone;
global.loop_atual = 0;

function start_stats() {
	return {
		move_speed: 4,
		fire_rate: 20,
		bullet_speed: 8,
		bullet_dmg: 1,
		bullet_count: 0,
		bullet_spread: 18,
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
		
		max_hp: 3,
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

function start_inventario() { return ["arma_inicial"] };

global.tinta = noone;

global.paleta_loops = [
	make_color_rgb(224,  49,  49),	//vermelho
	make_color_rgb(232, 110,  48),	//laranja
	make_color_rgb(214, 158,  46),	//ouro
	make_color_rgb(130, 168,  46),	//lima
	make_color_rgb( 47, 158,  68),	//verde
	make_color_rgb( 32, 156, 138),	//turquesa
	make_color_rgb( 34, 139, 230),	//azul
	make_color_rgb( 60,  90, 214),	//indigo
	make_color_rgb(121,  80, 242),	//violeta
	make_color_rgb(174,  62, 201),	//roxo
	make_color_rgb(214,  51, 148),	//magenta
	make_color_rgb(201,  42,  86),	//carmim
];

global.cor_player = make_color_rgb(32, 32, 38);	//Cor do player (marcas de bala dele)
global.clone_dessat = 0.55;		//0 = cor cheia, 1 = cinza
global.clone_clarear = 0.35;	//0 = cor cheia, 1 = branco
global.tinta_spr_corpo = spr_clone_death;

global.tinta_raio_morte = 20;	//Raio da poça de morte
global.tinta_gotas_morte = 10;	//Respingos por morte
global.tinta_forca_morte = 26;	//Alcance extra dos respingos na direção do tiro
global.tinta_cone = 40;			//Abertura do leque de respingo, em graus
global.tinta_alpha = 0.85;		//Força da mancha. Manchas sobrepostas somam

global.tinta_raio_hit = 5;		//Poça de hit que não mata
global.tinta_gotas_hit = 3;

global.tinta_raio_parede = 3;	//Marca de bala na parede
global.tinta_gotas_parede = 2;