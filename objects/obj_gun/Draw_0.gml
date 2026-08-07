var _cor = (player.type == BULLET_OWNER.CLONE) ? player.cor_viva : c_white;
var _alpha = (player.type == BULLET_OWNER.CLONE) ? player.alpha_atual : image_alpha;

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle,
	_cor, _alpha);

//Clarão na ponta do cano
if (flash_timer > 0)
{
	draw_sprite_ext(spr_muzzle_flash, 0,
		x + lengthdir_x(cano, image_angle),
		y + lengthdir_y(cano, image_angle),
		1, image_yscale, image_angle, c_white, 1);
}

if(!global.debug) exit;

draw_set_font(fnt_debug);

var _yy = y + 20;
var _font_size = font_get_size(fnt_debug);
var _spacing = 10 + _font_size;

var _info = [
	player
];

for(var i = 0; i < array_length(_info); i++)
{
	var _text = _info[i];
	
	draw_text(x + 20, _yy, _text);
	_yy += _spacing;
}

draw_set_font(-1);