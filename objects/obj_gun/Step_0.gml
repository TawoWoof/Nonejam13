if (player == noone || !instance_exists(player)) exit;

var _angle = player.mira_atual;

x = player.x + lengthdir_x(orbita, _angle)
y = player.y + lengthdir_y(orbita, _angle)

image_angle = _angle

image_yscale = (_angle > 90 && _angle < 270) ? -1 : 1;