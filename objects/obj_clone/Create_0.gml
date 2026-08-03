//Infos do playback
buffer = [];
playback_step = 0;
frozen = false;

//cria a arma e define o dono dela
gun = instance_create_layer(x, y, layer, obj_gun);
gun.player = id;

//Inicializa os status
var _stats = start_stats();
move_speed = _stats.move_speed;
fire_rate = _stats.fire_rate;
bullet_speed = _stats.bullet_speed;
bullet_dmg = _stats.bullet_dmg;
cooldown = 0;

max_hp = _stats.max_hp;
hp = max_hp

type = BULLET_OWNER.CLONE;
mira_atual = 0;

