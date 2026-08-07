//Pose congelada do instante do abate
spr_vivo = spr_clone;
img_vivo = 0;
ang_vivo = 0;
alpha_vivo = 1;

//Pose morta
spr = spr_clone_death;
img = 0;

cor = c_white;
xs = 1;
ys = 1;
ang = 0;

vel = 0;			//Velocidade do arrasto
dir = 0;			//Direção do arrasto
giro = 0;			//Rotação por step

trocou = false;		//Já virou corpo?
rastro_tick = 0;