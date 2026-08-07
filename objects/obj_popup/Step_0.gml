if (!global.frame_ativo) exit;

y += vy;
vy *= global.popup_atrito;

vida -= 1;
if (vida <= 0) { instance_destroy(); }