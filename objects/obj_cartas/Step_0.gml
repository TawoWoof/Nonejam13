if (!jogo_rodando()){ exit };

if (keyboard_check_pressed(ord("P")))
{
	var _carta = carta_sortear()
	
	if (is_undefined(_carta))
	{
		show_debug_message("Nenhuma carta disponível")
		exit;
	}
	
	carta_obter(_carta)
}