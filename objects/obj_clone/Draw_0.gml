if(flash_timer > 0)
{
	gpu_set_fog(true, global.flash_cor, 0, 0);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, cor_viva, alpha_atual);
	gpu_set_fog(false, c_black, 0, 0);
}
else
{
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, cor_viva, alpha_atual);
}
if(!global.debug) exit;

draw_set_font(fnt_debug);
var _yy = y + 20;
var _font_size = font_get_size(fnt_debug);
var _spacing = 10 + _font_size;

var _info = [
	"step: " + string(playback_step) + "/" + string(array_length(buffer)),
	"frozen: " + string(frozen),
];

for(var i = 0; i < array_length(_info); i++)
{
	var _text = _info[i];
	
	draw_text(x - 20, _yy, _text);
	_yy += _spacing;
}

draw_set_font(-1);