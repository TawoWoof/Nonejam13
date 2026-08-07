draw_set_font(fnt_debug);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _a = min(1, vida / global.popup_fade);

draw_text_color(x, y, texto, cor, cor, cor, cor, _a);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);