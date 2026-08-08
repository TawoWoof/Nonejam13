var _t = vida / vida_max;

draw_set_color(cor);
draw_set_alpha(alpha_max * min(1, _t / max(0.01, fade)));

draw_circle(x, y, raio, false);

draw_set_alpha(1);
draw_set_color(c_white);