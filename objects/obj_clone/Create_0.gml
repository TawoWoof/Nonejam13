//Infos do playback -- Todo são settados na criação
buffer = [];			//Buffer (Memória do que o player fez)
playback_step = 0;		//Step que está sendo tocado atualmente
frozen = false;			//Congelamento para quando o playback terminar
delay = global.delay	//Delay entre Spawnar e tocar o replay
loop_index = 0			//Loop de origem do clone
cartas = []				//Cartas Herdadas

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
delay = 0;								//Delay do começo
delay_max = 0;							//Delay Máximo

type = BULLET_OWNER.CLONE;				//Time
mira_atual = 0;							//Onde está mirando atualmente
mira_inicial = 0;						//Onde a mira começou
mira_alvo = 0;							//Onde a mira precisa chegar
