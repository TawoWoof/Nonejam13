/// @desc Troca de sprite
/// @arg {Asset.GMSprite} _spr
function anim_trocar(_spr)
{
	if (sprite_index == _spr) exit;
	
	sprite_index = _spr;
	image_index = 0;
}

/// @desc Escolhe sprite, frame e direção. Compartilhada entre player e clone
/// @arg {REAL} _move_x Input horizontal deste step
/// @arg {REAL} _move_y Input vertical deste step
function sprite_atualizar(_move_x, _move_y)
{
	//Squash de impacto diminui SEMPRE
	anim_impacto *= global.impacto_amort;
	if (abs(anim_impacto) < 0.005) { anim_impacto = 0; }
	
	//Morte
	if (anim_morte)
	{
		anim_trocar(spr_morte);
		image_index = min(image_index + global.anim_vel_morte, sprite_get_number(sprite_index) - 1);
		
		anim_esticar = 0;
		anim_girar = 0;
		exit;
	}
	
	//Lado em que a arma está
	var _lx = lengthdir_x(1, mira_atual);
	if (abs(_lx) > global.anim_mira_zona) { facing_mira = sign(_lx); }
	
	//Dash
	if (dash_timer > 0 || pouso_timer > 0)
	{
		//Dash vertical
		var _dx = lengthdir_x(1, dash_dir);
		facing = (abs(_dx) > global.anim_mira_zona) ? sign(_dx) : facing_mira;
		image_xscale = abs(image_xscale) * facing;
		
		anim_trocar(spr_dash);
		anim_girar = 0;
		
		var _eixo = (abs(lengthdir_x(1, dash_dir)) > abs(lengthdir_y(1, dash_dir))) ? 1 : -1;
		
		if (dash_timer > 0)
		{
			//Rearma a aterrissagem a cada step do dash
			pouso_timer = global.anim_pouso_dur;
			image_index = (dash_timer > dash_dur - global.anim_dash_saida) ? 0 : 1;
			
			var _t = 1 - (dash_timer / max(1, dash_dur));
			
			var _env = (_t < 0.5) ? 1 : lerp(1, global.anim_dash_fim, (_t - 0.5) * 2);
			
			anim_esticar = anim_deformar(-cos(_t * 2 * pi) * global.anim_squash_dash * _env * _eixo);
		}
		else
		{
			pouso_timer -= 1;
			image_index = (pouso_timer > global.anim_pouso_dur * 0.5) ? 2 : 3;
			
			//Aterrissagem
			var _p = pouso_timer / max(1, global.anim_pouso_dur);
			anim_esticar = anim_deformar(-_p * global.anim_squash_dash * global.anim_dash_fim  * _eixo);
		}
		
		exit;
	}
	
	//Idle e walk
	facing = facing_mira;
	image_xscale = abs(image_xscale) * facing;
	
	var _andando = (_move_x != 0 || _move_y != 0);
	
	anim_trocar(_andando ? spr_walk : spr_idle);
	
	//Andar contra o lado da arma = reverte animação
	var _sentido = (_andando && _move_x != 0 && sign(_move_x) != facing) ? -1 : 1;
	
	image_index += (_andando ? global.anim_vel_walk : global.anim_vel_idle) * _sentido;
	
	var _n = max(1, sprite_get_number(sprite_index));
	image_index = ((image_index mod _n) + _n) mod _n;
	
	//Pulsa mais rápido e mais forte andando
	anim_fase += _andando ? global.anim_fase_walk : global.anim_fase_idle;
	
	var _amp = _andando ? global.anim_squash_walk : global.anim_squash_idle;
	anim_esticar = anim_deformar(sin(anim_fase) * _amp);
	
	//Balanço na METADE da frequência do squash e uma inclinação por ciclo
	anim_girar = _andando ? sin(anim_fase * 0.5) * global.anim_giro_walk * facing : 0;
}

/// @desc Soma a deformação da animação com o impacto
/// @arg {REAL} _base Deformação vinda da animação
function anim_deformar(_base)
{
	return clamp(_base + anim_impacto, -global.anim_esticar_max, global.anim_esticar_max);
}

/// @desc Deslocamento que mantém o PÉ do sprite parado durante a deformação
/// @arg {REAL} _my Escala Y final do desenho
function anim_pivo_y(_my)
{
	//Distância da origem até a base do sprite, e o quanto a escala mexeu nela
	return (sprite_get_height(sprite_index) - sprite_get_yoffset(sprite_index)) * (1 - _my);
}