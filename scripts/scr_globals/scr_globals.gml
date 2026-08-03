global.debug = true

global.move_right	=	 ord("D");
global.move_left	=	 ord("A");
global.move_down	=	 ord("S");
global.move_up		=	 ord("W");
global.shoot		=	 mb_left;

enum BULLET_OWNER
{
	PLAYER,
	CLONE
}

global.win = false