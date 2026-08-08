enum GO { TITULO, LOOP_IMP, LOOP_ROT, PONTOS_IMP, PONTOS_CONTA, RECORDES, BOTOES }

function recordes_carregar()
{
	ini_open("heranca.ini");
	global.recorde_loop = ini_read_real("rec", "loop", 0);
	global.recorde_pontos = ini_read_real("rec", "pontos", 0);
	ini_close();
}

function recordes_salvar()
{
	global.recorde_loop = max(global.recorde_loop, global.loop_atual);
	global.recorde_pontos = max(global.recorde_pontos, global.pontos);
	
	ini_open("heranca.ini");
	ini_write_real("rec", "loop", global.recorde_loop);
	ini_write_real("rec", "pontos", global.recorde_pontos);
	ini_close();
}

function go_iniciar()
{
	global.go_fase = GO.TITULO;
	global.go_timer = 0;
	global.go_pontos = 0;
	global.go_punch = [0, 0];
	global.go_alpha = [0,0,0,0,0,0];
	global.go_botao = -1;
	
	recordes_salvar();
}

function go_fase_trocar(_f) { global.go_fase = _f; global.go_timer = 0; }

/// @desc Sobe um alpha até 1
function go_acender(_i)
{
	global.go_alpha[_i] = min(1, global.go_alpha[_i] + 1 / global.go_fade);
	return (global.go_alpha[_i] >= 1);
}

function go_passo()
{
	global.go_timer += 1;
	global.go_punch[0] *= global.go_punch_amort;
	global.go_punch[1] *= global.go_punch_amort;
	
	switch (global.go_fase)
	{
		case GO.TITULO:
			global.go_alpha[0] = min(1, global.go_timer / global.go_fade_titulo);
			if (global.go_timer >= global.go_fade_titulo + global.go_espera) { go_fase_trocar(GO.LOOP_IMP) }
			break;
		
		//Número do loop bate na tela
		case GO.LOOP_IMP:
			global.go_alpha[5] = 1;
			global.go_punch[0] = 1.2;
			shake_add(global.go_shake, irandom(359));
			go_fase_trocar(GO.LOOP_ROT);
			break;
		
		case GO.LOOP_ROT:
			if (go_acender(1)) { go_fase_trocar(GO.PONTOS_IMP) }
			break;
		
		case GO.PONTOS_IMP:
			global.go_punch[1] = 1.2;
			shake_add(global.go_shake, irandom(359));
			go_fase_trocar(GO.PONTOS_CONTA);
			break;
		
		case GO.PONTOS_CONTA:
			go_acender(2);
			
			if (global.go_pontos < global.pontos)
			{
				var _falta = global.pontos - global.go_pontos;
				global.go_pontos = min(global.pontos, global.go_pontos + max(1, ceil(_falta * global.go_taxa)));
				global.go_punch[1] = min(global.go_punch[1] + 0.1, 0.3);
				
				if (global.go_pontos >= global.pontos)
				{
					global.go_punch[1] = 1;
					shake_add(global.go_shake, irandom(359));
				}
			}
			else if (global.go_alpha[2] >= 1) { go_fase_trocar(GO.RECORDES) }
			break;
		
		case GO.RECORDES:
			if (go_acender(3)) { go_fase_trocar(GO.BOTOES) }
			break;
		
		case GO.BOTOES:
			go_acender(4);
			go_botoes_passo();
			break;
	}
}

/// @desc Retângulo de um botão: [x1, y1, x2, y2]
function go_botao_rect(_i)
{
	var _cx = display_get_gui_width() * 0.5;
	var _bx = _cx + (_i == 0 ? -375 : 25);
	
	return [_bx, 850, _bx + 350, 945];
}

function go_botoes_passo()
{
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	
	global.go_botao = -1;
	
	for (var i = 0; i < 2; i++)
	{
		var _r = go_botao_rect(i);
		
		if (_mx >= _r[0] && _mx <= _r[2] && _my >= _r[1] && _my <= _r[3])
		{
			global.go_botao = i;
			
			if (mouse_check_button_pressed(mb_left))
			{
				if (i == 0) { run_reiniciar(); } else { estado_trocar(GAME.MENU); }
			}
		}
	}
}

/// @desc Recomeça a run do zero sem passar pelo menu
function run_reiniciar()
{
	if (instance_exists(global.loop_master)) { global.loop_master.loops = []; }
	
	run_resetar();
	estado_trocar(GAME.GAP);
	room_restart();
}

function go_desenhar()
{
	var _gw = display_get_gui_width();
	var _cx = _gw * 0.5;
	var _ex = _cx - 325;	//coluna esquerda
	var _dx = _cx + 325;	//coluna direita
	
	//Fundo preto
	draw_set_alpha(1);
	draw_rectangle_color(0, 0, _gw, display_get_gui_height(), c_black, c_black, c_black, c_black, false);
	
	draw_set_font(fnt_final);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	
	//Título
	draw_set_alpha(global.go_alpha[0]);
	draw_texto(_cx, 225, "VOCÊ MORREU", FNT_BIG);
	
	//Números grandes
	var _e0 = 3 * (1 + global.go_punch[0]);
	var _e1 = 3 * (1 + global.go_punch[1]);
	
	draw_set_alpha(global.go_alpha[5]);
	draw_texto(_ex, 500, string(global.loop_atual), FNT_SMALL, _e0);
	
	if (global.go_fase >= GO.PONTOS_IMP)
	{
		draw_set_alpha(1);
		draw_texto(_dx, 500, string(global.go_pontos), FNT_SMALL, _e1);
	}
	
	//Rótulos pequenos acima
	draw_set_alpha(global.go_alpha[1] * 0.75);
	draw_texto(_ex, 425, "MORREU NO LOOP", FNT_SMALL);
	
	draw_set_alpha(global.go_alpha[2] * 0.75);
	draw_texto(_dx, 425, "PONTUAÇÃO TOTAL", FNT_SMALL);
	
	//Recordes
	draw_set_alpha(global.go_alpha[3] * 0.75);
	draw_texto(_ex, 645, "MELHOR LOOP", FNT_SMALL);
	draw_texto(_dx, 645, "MELHOR PONTUAÇÃO", FNT_SMALL);
	
	draw_set_alpha(global.go_alpha[3]);
	draw_texto(_ex, 725, string(global.recorde_loop), FNT_SMALL, 2);
	draw_texto(_dx, 725, string(global.recorde_pontos), FNT_SMALL, 2);
	
	//Botões
	var _nomes = ["TENTAR NOVAMENTE", "VOLTAR PRO MENU"];
	
	for (var i = 0; i < 2; i++)
	{
		var _r = go_botao_rect(i);
		var _sel = (global.go_botao == i);
		
		draw_set_alpha(global.go_alpha[4] * (_sel ? 1 : 0.5));
		
		draw_sprite_stretched(spr_menu_button, 1, _r[0], _r[1], _r[2] - _r[0], _r[3] - _r[1])
		
		draw_set_alpha(global.go_alpha[4] * (_sel ? 1 : 0.7));
		draw_texto((_r[0] + _r[2]) * 0.5, (_r[1] + _r[3]) * 0.5, _nomes[i], FNT_SMALL);
	}
	
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(-1);
}