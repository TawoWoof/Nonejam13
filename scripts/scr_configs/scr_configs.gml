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
global.tutorial_x = 0;			//Coordenadas do clone tutorial na room
global.tutorial_y = 0;			//Coordenadas do clone tutorial na room

global.move_right	=	 ord("D");
global.move_left	=	 ord("A");
global.move_down	=	 ord("S");
global.move_up		=	 ord("W");
global.shoot		=	 mb_left;

function start_stats() {
	return {
		move_speed: 4,
		fire_rate: 10,
		bullet_speed: 8,
		bullet_dmg: 1,
		max_hp: 1,
		vel_x: 0,
		vel_y: 0,
		accel: 0.1,
		decel: 0.3,
		clone_bullet_multiplier: 0.5
	};
}