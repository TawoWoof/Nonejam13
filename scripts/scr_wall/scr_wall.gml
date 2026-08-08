/// @desc Caixas de colisão de um tile
/// @arg {REAL} _tile Índice do tile
function wall_caixas(_tile)
{
	switch (_tile)
	{
		//Barra horizontal
		case 15: case 17: case 18:
			return [[0, 20, 128, 88]];
		
		//Barra vertical
		case 16: case 19: case 20:
			return [[20, 0, 88, 128]];
		
		//Pilar central
		case 14:
			return [[8, 8, 112, 112]];
		
		//Cruz
		case 41:
			return [[20, 0, 88, 128], [0, 20, 128, 88]];
		
		//T deitado (barra vertical + bico lateral)
		case 27:	return [[20, 0, 88, 128], [108, 20, 20, 88]];
		case 13:	return [[20, 0, 88, 128], [0, 20, 20, 88]];
		
		//T em pé (barra horizontal + bico vertical)
		case 26:	return [[0, 20, 128, 88], [20, 0, 88, 20]];
		case 25:	return [[0, 20, 128, 88], [20, 108, 88, 20]];
		
		//Cotovelos
		case 21:	return [[20, 20, 108, 88], [20, 20, 88, 108]];
		case 22:	return [[0, 20, 108, 88], [20, 20, 88, 108]];
		case 23:	return [[20, 20, 108, 88], [20, 0, 88, 108]];
		case 24:	return [[0, 20, 108, 88], [20, 0, 88, 108]];
	}
	
	return [];
}

/// @desc Cria os obj_wall a partir da camada de tiles
function walls_do_tilemap()
{
	var _lay = layer_get_id(global.tile_layer);
	if (_lay == -1) exit;
	
	var _map = layer_tilemap_get_id(_lay);
	if (_map == -1) exit;
	
	var _tw = tilemap_get_tile_width(_map);
	var _th = tilemap_get_tile_height(_map);
	
	var _ox = sprite_get_xoffset(spr_wall);
	var _oy = sprite_get_yoffset(spr_wall);
	var _sw = sprite_get_width(spr_wall);
	var _sh = sprite_get_height(spr_wall);
	
	for (var _j = 0; _j < tilemap_get_height(_map); _j++)
	{
		for (var _i = 0; _i < tilemap_get_width(_map); _i++)
		{
			var _caixas = wall_caixas(tile_get_index(tilemap_get(_map, _i, _j)));
			
			for (var _k = 0; _k < array_length(_caixas); _k++)
			{
				var _c = _caixas[_k];
				
				var _ex = _c[2] / _sw;
				var _ey = _c[3] / _sh;
				
				var _px = _i * _tw + _c[0];
				var _py = _j * _th + _c[1];
				
				var _w = instance_create_depth(_px + _ox * _ex, _py + _oy * _ey, global.wall_depth, obj_wall);
				
				_w.image_xscale = _ex;
				_w.image_yscale = _ey;
				_w.visible = false;
			}
		}
	}
}