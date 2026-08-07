//cria a arma e define o dono dela
gun = instance_create_layer(x, y, layer, obj_gun)
gun.player = id
cor = global.cor_player;		//Cor das marcas de bala

//Inicialização de stats. Edições em start_stats()
stats_escrever(id, start_stats())

//Estados / Contadores

hp = max_hp								//HP atual
cooldown = 0;							//Timer do cooldown entre tiros
vel_x = 0								//Velocidade Atual do eixo X
vel_y = 0								//Velocidade Atual do eixo Y
dash_timer = 0;							//Frames DO DASH
dash_cooldown = 0;						//Cooldown do dash
dash_dir = 0;							//Direção do dash
invul_timer = 0;						//Invulnerabilidade
kills_cura = 0;							//Abates acumulados para a cura


type = BULLET_OWNER.PLAYER;		//Define o time
mira_atual = 0;					//Onde está mirando

//Gravador de input inicial
loop_start_x = x;					//Posição X inicial
loop_start_y = y;					//Posição Y inicial
input_actions = criar_input();		//Cria o input do player
recording_buffer = [];				//Buffer (Lugar onde vai gravar)
record_step = 0;					//Step de gravação atual

global.player = id;					//Salva seu ID como player
flash_timer = 0;

last_input = { move_x: 0, move_y: 0, mira: 0, atirando: false, dash: false }; //Último input. É mais pra debug, tem informação pra evitar crash

stats_recalcular();

//Animação
image_speed = 0;					//Avanço manual, pra congelar junto com o hitstop
facing = 1;							//1 = direita, -1 = esquerda
facing_mira = 1;					//Lado em que a arma está
pouso_timer = 0;					//Frames restantes de aterrissagem do dash
anim_morte = false;

spr_idle  = spr_player;
spr_walk  = spr_player_walk;
spr_dash  = spr_player_dash;
spr_morte = spr_player_death;