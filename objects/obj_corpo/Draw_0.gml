//Segurando a pose viva durante o hitstop, ainda com o flash do impacto
if (!trocou)
{
	gpu_set_fog(true, global.flash_cor, 0, 0);
	draw_sprite_ext(spr_vivo, img_vivo, x, y, xs, ys, ang_vivo, c_white, alpha_vivo);
	gpu_set_fog(false, c_black, 0, 0);
	exit;
}

draw_sprite_ext(spr, img, x, y, xs, ys, ang, cor, global.tinta_alpha);