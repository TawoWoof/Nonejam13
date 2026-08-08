global.marcador_amp    = 10;	//Amplitude do bobbing
global.marcador_vel    = 0.12;	//Velocidade do bobbing
global.marcador_margem = 60;	//Distância da borda quando fora da tela
global.marcador_alt    = 16;	//Altura acima do clone quando na tela
global.marcador_esc    = 1;

/// @desc Clone vivo do loop mais recente
/// @returns {Id.Instance}
function marcador_alvo()
{
	var _melhor = noone;
	
	with (obj_clone)
	{
		if (_melhor == noone || loop_index > _melhor.loop_index) { _melhor = id; }
	}
	
	return _melhor;
}

/// @desc Seta apontando pro clone alvo, presa na borda quando ele sai da tela
function marcador_desenhar()
{
	var _alvo = marcador_alvo();
	if (_alvo == noone) exit;
	
	var _cam = view_camera[0];
	var _gw = display_get_gui_width();
	var _gh = display_get_gui_height();
	
	//Room -> GUI
	var _gx   = (_alvo.x - camera_get_view_x(_cam)) / camera_get_view_width(_cam)  * _gw;
	var _gy   = (_alvo.y - camera_get_view_y(_cam)) / camera_get_view_height(_cam) * _gh;
	var _topo = (_alvo.bbox_top - camera_get_view_y(_cam)) / camera_get_view_height(_cam) * _gh;
	
	var _bob = (sin(global.tick * global.marcador_vel) * 0.5 + 0.5) * global.marcador_amp;
	var _m = global.marcador_margem;
	
	var _px, _py, _ang;
	
	if (_gx >= 0 && _gx <= _gw && _gy >= 0 && _gy <= _gh)
	{
		//Na tela
		_px = _gx;
		_py = _topo - global.marcador_alt - _bob;
		_ang = 0;
	}
	else
	{
		//Fora
		var _dir = point_direction(_gw * 0.5, _gh * 0.5, _gx, _gy);
		
		_px = clamp(_gx, _m, _gw - _m) + lengthdir_x(_bob, _dir);
		_py = clamp(_gy, _m, _gh - _m) + lengthdir_y(_bob, _dir);
		
		_ang = _dir + 90;
	}
	
	draw_sprite_ext(spr_marcador, 0, _px, _py, global.marcador_esc, global.marcador_esc,
		_ang, _alvo.cor_viva, 1);
}