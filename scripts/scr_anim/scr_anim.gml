/// @desc Troca de sprite
/// @arg {Asset.GMSprite} _spr
function anim_trocar(_spr)
{
	if (sprite_index == _spr) exit;
	
	sprite_index = _spr;
	image_index = 0;
}

/// @desc Escolhe sprite, frame e direção. Compartilhada entre player e clone
/// @arg {REAL} _move_x Input horizontal deste step
/// @arg {REAL} _move_y Input vertical deste step
function sprite_atualizar(_move_x, _move_y)
{
	//Morte
	if (anim_morte)
	{
		anim_trocar(spr_morte);
		image_index = min(image_index + global.anim_vel_morte, sprite_get_number(sprite_index) - 1);
		exit;
	}
	
	//Lado em que a arma está
	var _lx = lengthdir_x(1, mira_atual);
	if (abs(_lx) > global.anim_mira_zona) { facing_mira = sign(_lx); }
	
	//Dash
	if (dash_timer > 0 || pouso_timer > 0)
	{
		//Dash vertical
		var _dx = lengthdir_x(1, dash_dir);
		facing = (abs(_dx) > global.anim_mira_zona) ? sign(_dx) : facing_mira;
		image_xscale = abs(image_xscale) * facing;
		
		anim_trocar(spr_dash);
		
		if (dash_timer > 0)
		{
			//Rearma a aterrissagem a cada step do dash
			pouso_timer = global.anim_pouso_dur;
			image_index = (dash_timer > dash_dur - global.anim_dash_saida) ? 0 : 1;
		}
		else
		{
			pouso_timer -= 1;
			image_index = (pouso_timer > global.anim_pouso_dur * 0.5) ? 2 : 3;
		}
		
		exit;
	}
	
	//Idle e walk
	facing = facing_mira;
	image_xscale = abs(image_xscale) * facing;
	
	var _andando = (_move_x != 0 || _move_y != 0);
	
	anim_trocar(_andando ? spr_walk : spr_idle);
	
	//Andar contra o lado da arma = reverte animação
	var _sentido = (_andando && _move_x != 0 && sign(_move_x) != facing) ? -1 : 1;
	
	image_index += (_andando ? global.anim_vel_walk : global.anim_vel_idle) * _sentido;
	
	var _n = max(1, sprite_get_number(sprite_index));
	image_index = ((image_index mod _n) + _n) mod _n;
}