//Infos do playback -- Todo são settados na criação
buffer = [];			//Buffer (Memória do que o player fez)
playback_step = 0;		//Step que está sendo tocado atualmente
frozen = false;			//Congelamento para quando o playback terminar
delay = global.delay	//Delay entre Spawnar e tocar o replay
loop_index = 0			//Loop de origem do clone
cartas = []				//Cartas Herdadas
flash_timer = 0;		//Tempo do flash de hit
alpha_atual = global.clone_spawn_alpha  //Opacidade inicial
acordou = false							//flag de opacidade

//Criação da arma
gun = instance_create_layer(x, y, layer, obj_gun);	//Cria a arma
gun.player = id;									//Setta o dono

//Inicialização de Status
stats_escrever(id, stats_montar([], true));

//Estado / Contadores
hp = max_hp								//HP atual
cooldown = 0;							//Timer do cooldown entre tiros
vel_x = 0;								//Velocidade Atual do eixo X
vel_y = 0;								//Velocidade Atual do eixo Y
dash_timer = 0;							//Frames DO DASH
dash_cooldown = 0;						//Cooldown do dash
dash_dir = 0;							//Direção do dash
invul_timer = 0;						//Invulnerabilidade
delay_max = global.delay;							//Delay Máximo
type = BULLET_OWNER.CLONE;				//Time
mira_atual = 0;							//Onde está mirando atualmente
mira_inicial = 0;						//Onde a mira começou
mira_alvo = 0;							//Onde a mira precisa chegar
windup = 0;								//0..1 de tiro iminente

cor = global.cor_player;				//Cor cheia (sobrescrita no spawn_clones)
cor_viva = global.cor_player;			//Versão dessaturada, usada enquanto vivo
ultimo_hit_dir = undefined;				//Direção do último tiro recebido

//Animação
image_speed = 0;
facing = 1;							//1 = direita, -1 = esquerda
facing_mira = 1;					//Lado em que a arma está
pouso_timer = 0;
anim_morte = false;
anim_fase = random(6.28);			//Fase do sinewave
anim_esticar = 0;					//Deformação atual = + largo e baixo, - fino e alto
anim_girar = 0;						//Rotação visual
anim_impacto = 0;					//Squash residual de batida em parede

spr_idle  = spr_clone;
spr_walk  = spr_clone_walk;
spr_dash  = spr_clone_dash;
spr_morte = spr_clone_death;

poeira_tick = 0;