draw_set_font(fnt_final);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _a = min(1, vida / global.popup_fade);

draw_texto_color(x, y, texto, FNT_MEDIUM, cor, _a);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);