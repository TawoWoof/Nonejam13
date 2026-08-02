if (player == noone) exit;

var _angle = point_direction(player.x, player.y, mouse_x, mouse_y)

x = player.x + lengthdir_x(orbita, _angle)
y = player.y + lengthdir_y(orbita, _angle)

image_angle = _angle

image_yscale = (_angle > 90 && _angle < 270) ? -1 : 1;