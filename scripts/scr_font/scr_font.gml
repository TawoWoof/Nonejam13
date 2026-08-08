/// Sistema de tamanho de fonte
#macro FNT_BASE 200			//Tamanho real da fonte

//Tiers de tamanho, em pixels finais na tela
#macro FNT_SMALL	 24
#macro FNT_MEDIUM	 48
#macro FNT_BIG		 72
#macro FNT_GIGANTIC	144
#macro FNT_HUD		 30

//Onde a tinta das maiúsculas fica dentro da célula de 257px da fnt_final
#macro FNT_INK_TOP	 73
#macro FNT_INK_BOT	206

/// @desc Escala pra desenhar fnt_final num tamanho alvo em pixels
/// @arg {Real} _px
/// @returns {Real}
function fnt_esc(_px) { return _px / FNT_BASE; }

/// @desc Compensa o padding vazio da célula do glifo no valign atual
/// @arg {Real} _e		Escala já calculada
/// @returns {Real}
function fnt_offset_y(_e)
{
	switch (draw_get_valign())
	{
		case fa_middle: return -(FNT_INK_TOP + FNT_INK_BOT) * 0.5 * _e;
		case fa_bottom: return -FNT_INK_BOT * _e;
		default:        return 0;
	}
}

/// @desc draw_text_transformed ja na escala certa
/// @arg {Real} _x
/// @arg {Real} _y
/// @arg {String} _txt
/// @arg {Real} _px		Tamanho alvo em pixels
/// @arg {Real} _mult	Multiplicador extra (animações)
function draw_texto(_x, _y, _txt, _px, _mult = 1)
{
	var _e = fnt_esc(_px) * _mult;
	var _va = draw_get_valign();
	var _oy = fnt_offset_y(_e);
	
	draw_set_valign(fa_top);
	draw_text_transformed(round(_x), round(_y + _oy), _txt, _e, _e, 0);
	draw_set_valign(_va);
}

/// @desc Igual draw_texto, mas com cor e alpha
/// @arg {Real} _x
/// @arg {Real} _y
/// @arg {String} _txt
/// @arg {Real} _px
/// @arg {Id.Color} _cor
/// @arg {Real} _alpha
/// @arg {Real} _mult
function draw_texto_color(_x, _y, _txt, _px, _cor, _alpha = 1, _mult = 1)
{
	var _e = fnt_esc(_px) * _mult;
	var _va = draw_get_valign();
	var _oy = fnt_offset_y(_e);
	
	draw_set_valign(fa_top);
	draw_text_transformed_color(round(_x), round(_y + _oy), _txt, _e, _e, 0, _cor, _cor, _cor, _cor, _alpha);
	draw_set_valign(_va);
}