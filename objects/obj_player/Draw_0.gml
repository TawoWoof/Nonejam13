var _m = global.morph * global.transicao_estica;
var _mx = image_xscale * (1 + _m);
var _my = image_yscale * (1 - _m);

if(flash_timer > 0)
{
	gpu_set_fog(true, global.flash_cor, 0, 0)
	draw_sprite_ext(sprite_index, image_index, x, y, _mx, _my, image_angle, c_white, image_alpha);
	gpu_set_fog(false, c_black, 0, 0);
}
else
{
	draw_sprite_ext(sprite_index, image_index, x, y, _mx, _my, image_angle, c_white, image_alpha);
}
draw_set_colour(c_black)
draw_text(x, y, hp)
draw_set_colour(-1)

if(!global.debug) exit;

draw_set_font(fnt_debug);
var _yy = y + 20;
var _font_size = font_get_size(fnt_debug);
var _spacing = 10 + _font_size;

var _info = [
	"step: " + string(record_step),
	"buffer: " + string(array_length(recording_buffer)) + " frames",
	"move: x: " + string(last_input.move_x) + ", y: " + string(last_input.move_y),
	"mira: " + string(last_input.mira),
	"atirando: " + string(last_input.atirando),
	"cooldown: " + string(cooldown),
	"VEL X : " + string(vel_x) + " VEL Y : " + string(vel_y),
];

for(var i = 0; i < array_length(_info); i++)
{
	var _text = _info[i];
	
	draw_text(x - 20, _yy, _text);
	_yy += _spacing;
}

draw_set_font(-1);