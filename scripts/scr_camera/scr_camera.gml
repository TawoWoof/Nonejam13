global.camera = noone; //Inicia camera
global.shake_tiro = 6; //Força do tiro no shake
global.shake_explosao = 14; //Força do tiro no shake

/// @desc Soma um impulso de shake numa direção
/// @arg {REAL} _forca Intensidade do impulso
/// @arg {REAL} _dir Direção do impulso em graus
function shake_add(_forca, _dir) {
	if (!instance_exists(global.camera)) exit;
	
	with (global.camera) {
		
		shake_vel_x += lengthdir_x(_forca, _dir);
		shake_vel_y += lengthdir_y(_forca, _dir);
		
		//cappar a magnitude
		var _mag = point_distance(0, 0, shake_vel_x, shake_vel_y);
		if (_mag > shake_max) {
			shake_vel_x = shake_vel_x / _mag * shake_max;
			shake_vel_y = shake_vel_y / _mag * shake_max;
		}
	}
}

/// @desc Retornar o mouse ignorando efeitos de tela
function mouse_mundo() {
	if (!instance_exists(global.camera)) return { x: mouse_x, y: mouse_y };
	
	var _cam = view_camera[0];
	
	//canto lógico = centro lógico - metade da view; o que sobrar pro canto real é o shake
	var _off_x = camera_get_view_x(_cam) - (global.camera.cam_x - camera_get_view_width(_cam) * 0.5);
	var _off_y = camera_get_view_y(_cam) - (global.camera.cam_y - camera_get_view_height(_cam) * 0.5);
	
	return {
		x: mouse_x - _off_x,
		y: mouse_y - _off_y
	};
}