//Sem player ou sem dono, ignorar o step
if (player == noone || !instance_exists(player)) exit;

var _angle = player.mira_atual;

x = player.x + lengthdir_x(orbita, _angle)
y = player.y + lengthdir_y(orbita, _angle)

image_angle = _angle
image_yscale = (_angle > 90 && _angle < 270) ? -1 : 1;

if (!global.frame_ativo) exit;

if (flash_timer > 0) { flash_timer -= 1; }

recuo *= global.arma_recuo_amort;
if (recuo < 0.01) { recuo = 0; }

//Aviso: só clone tem
windup = (player.type == BULLET_OWNER.CLONE) ? player.windup : 0;

//Positivo estica no eixo do cano (aviso), negativo comprime (recuo)
def = global.windup_estica * windup - global.arma_recuo * recuo;

//Espirro na boca REAL, deformada e tudo
var _n = round(global.windup_particulas * windup);

if (_n > 0)
{
	var _ang = image_angle + (global.arma_recuo_ang * recuo - global.windup_ang * windup) * sign(image_yscale);
	var _bx = x + lengthdir_x(cano * (1 + def), _ang);
	var _by = y + lengthdir_y(cano * (1 + def), _ang);
	
	repeat (_n)
	{
		var _p = poeira_criar(_bx, _by, player.mira_atual, global.windup_forca * windup);
		
		_p.cor = player.cor;
		_p.depth = global.windup_depth;
		_p.dir = player.mira_atual + random_range(-global.windup_cone, global.windup_cone);
		
		_p.atrito = global.windup_atrito;
		_p.alpha_max = global.windup_alpha;
		_p.fade = global.windup_fade;
		
		_p.vida = global.windup_vida;
		_p.vida_max = global.windup_vida;
		
		_p.raio = global.windup_raio * random_range(0.7, 1.3);
		_p.raio_alvo = _p.raio;
	}
}