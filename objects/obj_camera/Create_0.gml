//Salva o objeto como Camera pra reutiliza as variáveis
global.camera = id;

//Posição LÓGICA da câmera (pivot central)
cam_x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) * 0.5;
cam_y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) * 0.5;

mouse_influencia = 0.25;   //0 = ignora o mouse, 1 = cursor na borda joga o player pra borda oposta
suavidade = 0.1;          //fração do caminho coberta por frame: menor = mais preguiçosa
primeiro = true;          //primeiro frame cola no alvo em vez de deslizar até ele

//Shake por recoil
shake_x = 0;			//deslocamento atual
shake_y = 0;
shake_vel_x = 0;        //velocidade do deslocamento
shake_vel_y = 0;
shake_forca = 1;		//rigidez da mola: maior = volta mais rápido, tremor mais agudo
shake_amort = 0.5;		//Duração (1 = infinito)
shake_max = 30;			//Limite do recoil

//Zoom punch
zoom = 0;
zoom_vel = 0;
view_base_w = camera_get_view_width(view_camera[0]);
view_base_h = camera_get_view_height(view_camera[0]);