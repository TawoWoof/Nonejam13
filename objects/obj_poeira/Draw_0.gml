draw_set_color(cor);
draw_set_alpha((vida / vida_max) * global.poeira_alpha);

draw_circle(x, y, raio, false);

draw_set_alpha(1);
draw_set_color(c_white);