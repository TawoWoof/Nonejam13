if (!instance_exists(global.player)) exit;

var _cam = view_camera[0];
var _w = camera_get_view_width(_cam);
var _h = camera_get_view_height(_cam);

//Evita retroalimentação da posição do mouse
var _rx = clamp(window_mouse_get_x() / max(1, window_get_width()), 0, 1) - 0.5;
var _ry = clamp(window_mouse_get_y() / max(1, window_get_height()), 0, 1) - 0.5;

//Camera settada pra acompanha o player com influência de cursor
var _alvo_x = global.player.x + _rx * _w * mouse_influencia;
var _alvo_y = global.player.y + _ry * _h * mouse_influencia;


if (primeiro) {
	cam_x = _alvo_x;
	cam_y = _alvo_y;
	primeiro = false;
} else {
	cam_x = lerp(cam_x, _alvo_x, suavidade);
	cam_y = lerp(cam_y, _alvo_y, suavidade);
}

//Shake por recoil
shake_vel_x -= shake_x * shake_forca;
shake_vel_y -= shake_y * shake_forca;

shake_vel_x *= shake_amort;
shake_vel_y *= shake_amort;

shake_x += shake_vel_x;
shake_y += shake_vel_y;

//Corta o resíduo pra parar de verdade
if (abs(shake_x) < 0.05 && abs(shake_vel_x) < 0.05) { shake_x = 0; shake_vel_x = 0; }
if (abs(shake_y) < 0.05 && abs(shake_vel_y) < 0.05) { shake_y = 0; shake_vel_y = 0; }

//Zoom punch
zoom_vel -= zoom * global.zoom_mola;
zoom_vel *= global.zoom_amort;
zoom += zoom_vel;

if (abs(zoom) < 0.0005 && abs(zoom_vel) < 0.0005) { zoom = 0; zoom_vel = 0; }

var _zw = round(view_base_w * (1 - zoom));
var _zh = round(view_base_h * (1 - zoom));

camera_set_view_size(_cam, _zw, _zh);

//Centro não canto, arredondado pro grid de pixel
camera_set_view_pos(_cam, round(cam_x - _zw * 0.5 + shake_x), round(cam_y - _zh * 0.5 + shake_y));