//cria a arma e define o dono dela
gun = instance_create_layer(x, y, layer, obj_gun)
gun.player = id

//Inicialização de Status (Fixo por enquanto, alterar se der tempo)
var _stats = start_stats();				//Chama a função para pegar status padrão

max_hp = _stats.max_hp;					//HP máximo
hp = max_hp								//HP atual

fire_rate = _stats.fire_rate;			//Cadência de tiro
bullet_speed = _stats.bullet_speed;		//Velocidade do tiro
bullet_dmg = _stats.bullet_dmg;			//Dano do tiro
cooldown = 0;							//Timer do cooldown entre tiros

move_speed = _stats.move_speed;			//Velocidade de Movimento
accel = _stats.accel;					//Aceleração
decel = _stats.decel;					//Desaceleração
vel_x = _stats.vel_x;					//Velocidade Atual do eixo X
vel_y = _stats.vel_y;					//Velocidade Atual do eixo Y

has_dash = _stats.has_dash;				//Tem dash?
dash_speed = _stats.dash_speed;			//Velocidade do dash
dash_timer = 0;							//Frames DO DASH
dash_cooldown = 0;						//Cooldown do dash
dash_dir = 0;							//Direção do dash
invul_timer = 0;						//Invulnerabilidade

type = BULLET_OWNER.PLAYER;		//Define o time
mira_atual = 0;					//Onde está mirando

//Gravador de input inicial
loop_start_x = x;					//Posição X inicial
loop_start_y = y;					//Posição Y inicial
input_actions = criar_input();		//Cria o input do player
recording_buffer = [];				//Buffer (Lugar onde vai gravar)
record_step = 0;					//Step de gravação atual

global.player = id;					//Salva seu ID como player

last_input = { move_x: 0, move_y: 0, mira: 0, atirando: false, dash: false }; //Último input. É mais pra debug, tem informação pra evitar crash