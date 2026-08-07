if (spr == -1) exit;

draw_sprite_ext(spr, img, x, y, xs, ys, ang, cor, (vida / vida_max) * global.rastro_alpha);