//Sem player ou sem dono, ignorar o step
if (player == noone || !instance_exists(player)) exit;

//Muda o angulo
var _angle = player.mira_atual;

//Configura a posição
x = player.x + lengthdir_x(orbita, _angle)
y = player.y + lengthdir_y(orbita, _angle)

//Configura a sprite
image_angle = _angle
image_yscale = (_angle > 90 && _angle < 270) ? -1 : 1;