if (!global.frame_ativo) exit;

x += lengthdir_x(vel, dir);
y += lengthdir_y(vel, dir);

vel *= global.poeira_atrito;

//Cresce enquanto some
raio = lerp(raio, raio_alvo, global.poeira_expansao);

vida -= 1;
if (vida <= 0) { instance_destroy(); }