enum PLACAR{
	
	AGUARDA,
	RESPIRO,
	ESPERA,
	ABATES,
	TEMPO,
	PONTOS,
	JUNTA,
	FIM
	
}

/// @desc Prepara o placar com os valores do loop que acabou
function placar_iniciar()
{
	global.placar_fase = PLACAR.AGUARDA;
	global.placar_timer = 0;
	
	global.placar_junta = 0;
	global.placar_total_punch = 0;
	
	//Pontuação ANTES deste loop = total menos o que foi ganho agora
	global.placar_alvo = [
		global.pontos - global.pontos_abates - global.pontos_tempo,
		global.pontos_abates,
		global.pontos_tempo
	];
	
	global.placar_val = [0, 0, 0];
	global.placar_punch = [0, 0, 0];
}

/// @desc Troca de fase zerando o timer
function placar_fase_trocar(_f)
{
	global.placar_fase = _f;
	global.placar_timer = 0;
}

/// @desc Conta um dos três números. Devolve true quando chega no alvo
/// @arg {REAL} _i Pontuação / Abates / Tempo
function placar_contar(_i)
{
	//Respiro antes de cada contagem
	if (global.placar_timer < global.placar_pausa) return false;
	
	var _alvo = global.placar_alvo[_i];
	
	if (global.placar_val[_i] >= _alvo)
	{
		global.placar_val[_i] = _alvo;
		return true;
	}
	
	//Ease-out
	var _falta = _alvo - global.placar_val[_i];
	var _passo = max(global.placar_min, ceil(_falta * global.placar_taxa));
	
	global.placar_val[_i] = min(_alvo, global.placar_val[_i] + _passo);
	
	global.placar_punch[_i] = min(global.placar_punch[_i] + global.placar_punch_tique,
								  global.placar_punch_max);
	
	//Punch
	if (global.placar_val[_i] >= _alvo)
	{
		global.placar_punch[_i] = global.placar_punch_fim;
		shake_add(global.placar_shake, irandom(359));
		return true;
	}
	
	return false;
}

/// @desc Avança um frame da animação do placar
function placar_passo()
{
	for (var i = 0; i < 3; i++) { global.placar_punch[i] *= global.placar_punch_amort; }
	global.placar_total_punch *= global.placar_punch_amort;
	
	global.placar_timer += 1;
	
	switch (global.placar_fase)
	{
		case PLACAR.AGUARDA:
			if (instance_number(obj_corpo) == 0) { placar_fase_trocar(PLACAR.RESPIRO) }
			break;
			
		case PLACAR.RESPIRO:
			if(global.placar_timer >= global.placar_respiro)
			{
				placar_fase_trocar(PLACAR.ESPERA)
			}
			break;
		
		case PLACAR.ESPERA:
			if (global.placar_timer >= global.placar_espera) { placar_fase_trocar(PLACAR.ABATES) }
			break;
		
		case PLACAR.ABATES:	if (placar_contar(1)) { placar_fase_trocar(PLACAR.TEMPO)  } break;
		case PLACAR.TEMPO:	if (placar_contar(2)) { placar_fase_trocar(PLACAR.PONTOS) } break;
		case PLACAR.PONTOS:	if (placar_contar(0)) { placar_fase_trocar(PLACAR.JUNTA)  } break;
		
		case PLACAR.JUNTA:
			global.placar_junta = min(1, global.placar_timer / global.placar_junta_dur);
			
			if (global.placar_junta >= 1)
			{
				global.placar_total_punch = global.placar_punch_fim * 1.7;
				shake_add(global.placar_shake * 2.5, irandom(359));
				placar_fase_trocar(PLACAR.FIM);
			}
			break;
	}
}

/// @desc Corta a animação pro fim
function placar_pular()
{
	with(obj_corpo)
	{
		if (!trocou)
		{
			trocou = true;
			img = sprite_get_number(spr) -1;
			ang = irandom(359);
		}
		
		tinta_corpo(spr, img, x, y, xs, ys, ang, cor);
		instance_destroy();
	}
	
	for (var i = 0; i < 3; i++) { global.placar_val[i] = global.placar_alvo[i]; }
	
	global.placar_junta = 1;
	placar_fase_trocar(PLACAR.FIM);
}

function placar_terminou() { return (global.placar_fase == PLACAR.FIM) }

/// @desc Desenha o placar
function placar_desenhar()
{
	var _cx = display_get_gui_width() * 0.5;
	var _y = global.placar_y;
	var _j = global.placar_junta;
	
	draw_set_font(fnt_final);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	//Animação Central
	if (_j < 1)
	{
		var _nomes = ["PONTUAÇÃO", "ABATES", "TEMPO"];
		var _a = 1 - _j;
		
		for (var i = 0; i < 3; i++)
		{
			var _px = lerp(_cx + (i - 1) * global.placar_espaco, _cx, _j);
			
			draw_set_alpha(_a * 0.7);
			draw_texto(_px, _y - global.placar_rotulo_dy, _nomes[i], FNT_SMALL, 2);
			
			var _e = 4 * (1 + global.placar_punch[i]);
			
			draw_set_alpha(_a);
			draw_texto(_px, _y, string(global.placar_val[i]), FNT_SMALL, _e);
			
			//Sinal de mais entre as parcelas
			if (i < 2)
			{
				draw_set_alpha(_a * 0.5);
				draw_texto(lerp(_cx + (i - 0.5) * global.placar_espaco, _cx, _j),
					_y, "+", FNT_SMALL, 2);
			}
		}
	}
	
	//O total
	if (_j > 0)
	{
		var _e = _j * (1 + global.placar_total_punch) * global.placar_total_esc;
		
		draw_set_alpha(_j * 0.7);
		draw_texto(_cx, _y - global.placar_rotulo_dy, "PONTUAÇÃO ATUAL", FNT_SMALL, 2);
		
		draw_set_alpha(_j);
		draw_texto(_cx, _y, string(global.pontos), FNT_SMALL, _e);
	}
	
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(-1);
}