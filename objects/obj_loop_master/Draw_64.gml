if (!global.debug) exit;

draw_set_font(fnt_debug);

var _yy = 20;
var _font_size = font_get_size(fnt_debug);
var _spacing = 10 + _font_size;

var _ultimo_loop = (array_length(loops) > 0) ? loops[array_length(loops) - 1] : undefined;

var _info = [
	"loop atual: " + string(loop_atual),
	"loops salvos: " + string(array_length(loops)),
	"global.win: " + string(global.win),
	"ultimo loop salvo: " + (is_undefined(_ultimo_loop) ? "nenhum ainda" : (string(_ultimo_loop.loop_index) + " (" + string(array_length(_ultimo_loop.buffer)) + " frames)")),
];

for (var i = 0; i < array_length(_info); i++) {
	draw_text(20, _yy, _info[i]);
	_yy += _spacing;
}

draw_set_font(-1);