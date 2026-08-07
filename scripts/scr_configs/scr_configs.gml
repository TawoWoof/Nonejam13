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
global.player = noone;			//Obejto do player
global.loop_master = noone;		//Controlador de loops
global.loop_atual = 0;			//loop atual

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

global.adrenalina_meia_vida = 120;		//Calculo adrenalina
global.adrenalina_fator = 0.8;			//Calculo adrenalina
global.berserk_fator = 3.1;				//Calculo berserk
global.bersek_curva = 1.6;				//Calculo berserk
global.curva_alcance = 160;				//Calculo aimbot
global.curva_angulo = 25;				//Calculo aimbot

global.cartas_disponiveis = 0;			//Cartas pra tiragem
global.cartas_intervalo = 5;			//Rounds entre cartas
global.cartas_opcoes = [];				//Cartas escolhidas para tiragem
global.cartas_opcoes_n = 3;				//Quantidade de cartas oferecidas
global.freeze_saindo = false;			//Fechando pro preto?

//Hitstop
global.hitstop = 0;				//Frames de congelamento restantes
global.hitstop_kill = 5;		//Congelamento por abate
global.hitstop_final = 16;		//Congelamento ao matar o último clone do loop
global.frame_ativo = true;		//False = frame congelado (hitstop)

//Flash de hit
global.flash_cor = make_color_rgb(255, 255, 255);	//Cor do flash
global.flash_dur = 8;								//Frames de flash

//Números de pontuação
global.popup_dur = 45;			//Frames de vida
global.popup_fade = 20;			//Frames finais em que some
global.popup_subida = 1.2;		//Velocidade inicial pra cima
global.popup_atrito = 0.92;		//Desaceleração da subida
global.popup_depth = -9000;		//Desenha por cima de tudo

//Muzzle flash
global.muzzle_dur = 6;			//Frames de clarão no cano

//Rastro do dash
global.rastro_dur = 14;			//Frames de vida do fantasma
global.rastro_alpha = 0.55;		//Opacidade inicial
global.rastro_intervalo = 1;	//Numero de frames entre fantasmas
global.rastro_hue_passo = 22;	//Controle de mudança de cor pro player
global.rastro_depth = 50;		//Atrás das entidades

//Zoom punch
global.zoom_kill = 0.035;		//Impulso de zoom por abate
global.zoom_mola = 0.25;		//Rigidez da mola
global.zoom_amort = 0.75;		//Amortecimento


//Vinheta e relógio
global.tick = 0;				//Contador pra pulsos visuais
global.vinheta_meia_vida = 240;					//Steps restantes que cortam a vinheta pela metade
global.vinheta_cor = make_color_rgb(140, 0, 0);	//Cor da vinheta
global.vinheta_espessura = 70;					//Largura da borda, em pixels de GUI
global.vinheta_pulso = 0.12;					//Velocidade da pulsação
global.relogio_tremor = 3;						//Deslocamento máximo do relógio

//Spawn do clone
global.clone_spawn_alpha = 0.25;	//Opacidade com que o clone nasce

//Transição de spawn
global.fade = 0;				//0 = normal, 1 = tela preta
global.morph = 0;				//Squash/Stretch // -1 = fino e alto, +1 = largo e baixo
global.transicao_dur = 18;		//Frames de cada metade da transição
global.transicao_estica = 0.35;	//Intensidade do squash/stretch

//Animação
global.anim_vel_idle = 0.12;	//Frames de sprite por step, parado
global.anim_vel_walk = 0.25;	//Frames de sprite por step, andando
global.anim_vel_morte = 0.2;	//Velocidade da animação de morte
global.anim_dash_saida = 3;		//Steps iniciais do dash
global.anim_pouso_dur = 8;		//Steps de aterrissagem
global.anim_mira_zona = 0.15;	//Zona morta da mira

//Squash/stretch procedural
global.anim_fase_idle = 0.06;		//Velocidade do sinewave parado (radianos/step)
global.anim_fase_walk = 0.22;		//Velocidade do sinewave andando
global.anim_squash_idle = 0.03;		//Amplitude do squash parado
global.anim_squash_walk = 0.08;		//Amplitude do squash andando
global.anim_giro_walk = 4;			//Balanço lateral andando, em graus
global.anim_squash_dash = 0.22;		//Amplitude do squash no dash

//Impacto em parede
global.impacto_min = 1.2;			//Velocidade mínima pra registrar batida
global.impacto_escala = 0.045;		//Squash por unidade de velocidade
global.impacto_max = 0.30;			//Teto do squash de impacto
global.impacto_amort = 0.82;		//Amortecimento por step
global.impacto_tinta_raio = 6;		//Tinta deixada na parede
global.impacto_tinta_gotas = 4;
global.impacto_tinta_forca = 10;

//Corpo deslizante
global.corpo_depth = 60;			//Atrás das entidades vivas
global.corpo_impulso = 1.6;			//Velocidade inicial = velocidade da bala * esse fator aqui
global.corpo_quique = 0.75;			//Velocidade que sobra depois de bater na parede
global.corpo_atrito = 0.90;			//Desaceleração por step
global.corpo_parada = 0.35;			//Abaixo disso o corpo assenta e vira mancha
global.corpo_giro = 3;				//Giro inicial máximo, em graus por step
global.corpo_forca_explosao = 10;	//Empurrão de quem morre por explosão
global.corpo_rastro_int = 2;		//Steps entre manchas do arrasto
global.corpo_rastro_forca = 4;	//Raio da mancha por unidade de velocidade
global.corpo_rastro_raio = 18;		//Teto do raio do arrasto
global.corpo_rastro_gotas = 3;		//respingo por arrasto
global.mask_corpo = spr_clone;		//Mascara de colisão

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
		has_dash: true,
		dash_speed: 8,
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
global.cor_tutorial = make_color_rgb(228, 231, 238);	//Cor do tutorial
global.clone_dessat = 0.55;		//0 = cor cheia, 1 = cinza
global.clone_clarear = 0.35;	//0 = cor cheia, 1 = branco

//MORTE
global.tinta_raio_morte = 34;	//Raio da poça de morte
global.tinta_gotas_morte = 18;	//Respingos por morte
global.tinta_forca_morte = 44;	//Alcance extra dos respingos na direção do tiro
global.tinta_cone = 40;			//Abertura do leque de respingo, em graus
global.tinta_alpha = 0.85;		//Força da mancha. Manchas sobrepostas somam

//HIT
global.tinta_raio_hit = 12;		//Poça de hit que não mata
global.tinta_gotas_hit = 9;
global.tinta_forca_hit = 20;

global.tinta_raio_parede = 3;	//Marca de bala na parede
global.tinta_gotas_parede = 2;

//POEIRA
global.poeira_depth = 55;			//Abaixo das entidades, acima do corpo caído
global.poeira_cor = make_color_rgb(170, 174, 186);
global.poeira_alpha = 0.5;			//Opacidade ao nascer
global.poeira_dur = 22;				//Frames de vida
global.poeira_atrito = 0.88;		//Desaceleração do sopro
global.poeira_cone = 35;			//Abertura do leque, em graus
global.poeira_raio_ini = 1.5;		//Raio ao nascer
global.poeira_raio_fim = 6;			//Raio pro qual expande
global.poeira_expansao = 0.12;		//Velocidade da expansão
global.poeira_offset_y = 8;			//Altura do pé em relação à origem do sprite
global.poeira_int = 5;				//Steps entre nuvens andando
global.poeira_vel_min = 0.8;		//Velocidade mínima pra levantar poeira
global.poeira_walk_forca = 0.7;		//Sopro da caminhada
global.poeira_walk_n = 2;			//Nuvens por frame de walk
global.poeira_dash_n = 4;			//Nuvens por frame de dash
global.poeira_dash_forca = 2.2;		//Sopro do dash