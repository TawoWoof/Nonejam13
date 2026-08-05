//Infos do playback -- Todo são settados na criação
buffer = [];			//Buffer (Memória do que o player fez)
playback_step = 0;		//Step que está sendo tocado atualmente
frozen = false;			//Congelamento para quando o playback terminar
delay = global.delay	//Delay entre Spawnar e tocar o replay
loop_index = 0			//Loop de origem do clone

//Criação da arma
gun = instance_create_layer(x, y, layer, obj_gun);	//Cria a arma
gun.player = id;									//Setta o dono

//Inicialização de Status (Fixo por enquanto, alterar se der tempo)
var _stats = start_stats();				//Chama a função para pegar status padrão

max_hp = _stats.max_hp;					//HP máximo
hp = max_hp								//HP atual

fire_rate = _stats.fire_rate;			//Cadência de tiro
bullet_speed = _stats.bullet_speed * _stats.clone_bullet_multiplier; //Velocidade do tiro
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

type = BULLET_OWNER.CLONE;				//Time
mira_atual = 0;							//Onde está mirando atualmente
mira_inicial = 0;						//Onde a mira começou
mira_alvo = 0;							//Onde a mira precisa chegar
