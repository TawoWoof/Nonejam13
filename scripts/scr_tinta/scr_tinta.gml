/// @desc Cor do loop de origem (paleta ciclica)
/// @arg {REAL} _loop
function loop_cor(_loop)
{
	var _n = array_length(global.paleta_loops);
	
	var _i = ((_loop mod _n) + _n) mod _n;
	
	return global.paleta_loops[_i];
}

/// @desc Puxa uma cor na direção do cinza de mesmo brilho
/// @arg {REAL} _cor
/// @arg {REAL} _t 0 = intacta, 1 = cinza
function cor_dessaturar(_cor, _t)
{
	var _r = color_get_red(_cor);
	var _g = color_get_green(_cor);
	var _b = color_get_blue(_cor);
	
	var _lum = _r * 0.299 + _g * 0.587 + _b * 0.114;
	
	return make_color_rgb(lerp(_r, _lum, _t), lerp(_g, _lum, _t), lerp(_b, _lum, _t));
}

/// @desc Registra uma mancha. O aleatório é resolvido aqui, não no desenho
/// @arg {REAL} _x
/// @arg {REAL} _y
/// @arg {REAL} _raio
/// @arg {REAL} _cor
/// @arg {REAL} _gotas Respingos ao redor
/// @arg {REAL} _dir Direção do espalhamento (undefined = pra todo lado)
/// @arg {REAL} _forca Alcance extra na direção
function tinta_splatter(_x, _y, _raio, _cor, _gotas = 6, _dir = undefined, _forca = 0)
{
	if (!instance_exists(global.tinta)) exit;
	
	//Poça central
	var _circulos = [ { x: _x, y: _y, r: _raio * 0.8 } ];
	
	for (var i = 0; i < _gotas; i++)
	{
		var _a = is_undefined(_dir) ? irandom(359)
			: _dir + random_range(-global.tinta_cone, global.tinta_cone);
		
		var _d = random(_raio) + random(_forca);
		
		array_push(_circulos, {
			x: _x + lengthdir_x(_d, _a),
			y: _y + lengthdir_y(_d, _a),
			r: _raio * random_range(0.2, 0.65)
		});
	}
	
	array_push(global.tinta.historico, { tipo: "mancha", cor: _cor, circulos: _circulos });
}

/// @desc Registra um corpo no chão
function tinta_corpo(_spr, _img, _x, _y, _xs, _ys, _ang, _cor)
{
	if (!instance_exists(global.tinta)) exit;
	
	array_push(global.tinta.historico, {
		tipo: "corpo",
		spr: _spr, img: _img, x: _x, y: _y,
		xs: _xs, ys: _ys, ang: _ang, cor: _cor
	});
}

/// @desc Clareia uma cor puxando pro branco
/// @arg {REAL} _cor
/// @arg {REAL} _t 0 = intacta, 1 = branco
function cor_clarear(_cor, _t)
{
	return make_color_rgb(
		lerp(color_get_red(_cor),   255, _t),
		lerp(color_get_green(_cor), 255, _t),
		lerp(color_get_blue(_cor),  255, _t)
	);
}

