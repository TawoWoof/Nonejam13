event_inherited();		//Herda as configurações do clone original

global.tutorial_x = x;	//Salva sua posição atual
global.tutorial_y = y;	//Salva sua posição atual

//Nasce sólido
cor = global.cor_tutorial;
cor_viva = global.cor_tutorial;
alpha_atual = 1;
acordou = true;

//Não se move nem atira: só o idle desarmado
spr_idle  = spr_clone_nogun;
spr_walk  = spr_clone_nogun;
spr_dash  = spr_clone_nogun;
spr_morte = spr_clone_death;

sprite_index = spr_clone_nogun;

//Sem arma porque o jogador precisa ser UM MONSTRO!! MATANDO GENTE INOCENTE, QUE FEIO!!!!
if (gun != noone && instance_exists(gun)) { instance_destroy(gun); }
gun = noone;

hp = 1;