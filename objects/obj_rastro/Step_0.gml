if (global.hitstop > 0) exit;

vida -= 1;
if (vida <= 0) { instance_destroy(); }