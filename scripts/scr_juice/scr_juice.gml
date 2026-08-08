/// @desc Congela o jogo por N frames
/// @arg {REAL} _frames
function hitstop_add(_frames)
{
	//NÃO SOMAR. Já congelou o jogo e eu passei duas horas tentando entender :(
	global.hitstop = max(global.hitstop, _frames);
}

/// @desc Número flutuante que sobe e some
/// @arg {REAL} _x
/// @arg {REAL} _y
/// @arg {String} _texto
/// @arg {REAL} _cor
function popup_criar(_x, _y, _texto, _cor)
{
	var _p = instance_create_depth(_x, _y, global.popup_depth, obj_popup);
	
	_p.texto = _texto;
	_p.cor = merge_color(_cor, c_black, 0.5);
}

/// @desc Fantasma do rastro de dash
function rastro_criar(_x, _y, _spr, _img, _xs, _ys, _ang, _cor)
{
	var _g = instance_create_depth(_x, _y, global.rastro_depth, obj_rastro);
	
	_g.spr = _spr;
	_g.img = _img;
	_g.xs  = _xs;
	_g.ys  = _ys;
	_g.ang = _ang;
	_g.cor = _cor;
}

/// @desc Empurra o zoom da câmera
/// @arg {REAL} _forca
function zoom_add(_forca)
{
	if (_forca == 0) exit;
	if (!instance_exists(global.camera)) exit;
	
	global.camera.zoom_vel += _forca;
}

/// @desc Vinheta nas bordas da tela
/// @arg {REAL} _forca 0..1
/// @arg {REAL} _cor
function vinheta_desenhar(_forca, _cor)
{
	if (_forca <= 0) exit;
	
	var _w = display_get_gui_width();
	var _h = display_get_gui_height();
	var _e = global.vinheta_espessura;
	
	//Cada borda é um quad com alpha cheio na margem e zero pro centro
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_colour(0, 0, _cor, _forca);   draw_vertex_colour(_w, 0, _cor, _forca);
	draw_vertex_colour(0, _e, _cor, 0);       draw_vertex_colour(_w, _e, _cor, 0);
	draw_primitive_end();
	
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_colour(0, _h, _cor, _forca);  draw_vertex_colour(_w, _h, _cor, _forca);
	draw_vertex_colour(0, _h - _e, _cor, 0);  draw_vertex_colour(_w, _h - _e, _cor, 0);
	draw_primitive_end();
	
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_colour(0, 0, _cor, _forca);   draw_vertex_colour(0, _h, _cor, _forca);
	draw_vertex_colour(_e, 0, _cor, 0);       draw_vertex_colour(_e, _h, _cor, 0);
	draw_primitive_end();
	
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_colour(_w, 0, _cor, _forca);      draw_vertex_colour(_w, _h, _cor, _forca);
	draw_vertex_colour(_w - _e, 0, _cor, 0);      draw_vertex_colour(_w - _e, _h, _cor, 0);
	draw_primitive_end();
}

/// @desc Solta uma nuvenzinha de poeira
/// @arg {REAL} _x
/// @arg {REAL} _y
/// @arg {REAL} _dir Direção do sopro
/// @arg {REAL} _forca Velocidade inicial
function poeira_criar(_x, _y, _dir, _forca)
{
	var _p = instance_create_depth(_x, _y, global.poeira_depth, obj_poeira);
	
	_p.dir = _dir + random_range(-global.poeira_cone, global.poeira_cone);
	_p.vel = _forca * random_range(0.6, 1.2);
	_p.raio = global.poeira_raio_ini;
	_p.raio_alvo = global.poeira_raio_fim * random_range(0.7, 1.3);
	
	return _p;
}