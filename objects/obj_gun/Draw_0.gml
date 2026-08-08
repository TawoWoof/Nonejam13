var _dono_clone = (player.type == BULLET_OWNER.CLONE);

var _xs = image_xscale * (1 + def);
var _ys = image_yscale * (1 - def * global.arma_perp);
var _ang = image_angle + (global.arma_recuo_ang * recuo - global.windup_ang * windup) * sign(image_yscale);

draw_sprite_ext(sprite_index, image_index, x, y, _xs, _ys, _ang,
	_dono_clone ? player.cor_viva : c_white,
	_dono_clone ? player.alpha_atual : image_alpha);

//Clarão na ponta do cano
if (flash_timer > 0)
{
	draw_sprite_ext(spr_muzzle_flash, 0,
		x + lengthdir_x(cano * (1 + def), _ang),
		y + lengthdir_y(cano * (1 + def), _ang),
		1, _ys, _ang, c_white, 1);
}