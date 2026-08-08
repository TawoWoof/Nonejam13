if (!global.frame_ativo) exit;

x += global.deriva_x;
y += global.deriva_y;

//Primeiro frame depois do congelamento = Vai jogar no vasco
if (!trocou)
{
	trocou = true;
	img = sprite_get_number(spr) - 1;
	ang = irandom(359);
}

var _mx = lengthdir_x(vel, dir);
var _my = lengthdir_y(vel, dir);

//Quique na parede, eixo por eixo
if (place_meeting(x + _mx, y, obj_wall))
{
	dir = 180 - dir;
	vel *= global.corpo_quique;
	giro *= -1;
	_mx = lengthdir_x(vel, dir);
	
	//Se o quique ainda entra na parede, trava o eixo
	if (place_meeting(x + _mx, y, obj_wall)) { _mx = 0; }
}
x += _mx;

if (place_meeting(x, y + _my, obj_wall))
{
	dir = -dir;
	vel *= global.corpo_quique;
	giro *= -1;
	_my = lengthdir_y(vel, dir);
	
	if (place_meeting(x, y + _my, obj_wall)) { _my = 0; }
}
y += _my;

ang += giro;

//Desaceleração exponencial
vel  *= global.corpo_atrito;
giro *= global.corpo_atrito;

//Mancha o caminho por onde passou
rastro_tick += 1;
if (rastro_tick >= global.corpo_rastro_int)
{
	rastro_tick = 0;
	
	tinta_splatter(x, y, global.corpo_rastro_raio, cor, global.corpo_rastro_gotas, dir + 180, global.corpo_rastro_forca);
}

//E morreu (Permanentemente)
if (vel < global.corpo_parada)
{
	tinta_corpo(spr, img, x, y, xs, ys, ang, cor);
	instance_destroy();
}