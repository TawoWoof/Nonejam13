prompt = (global.cartas_disponiveis > 0) ? "PEGUE SUA CARTA" : "COMEÇAR LOOP"

if (!interativo_ativo()){ exit }
if (!keyboard_check_pressed(global.interagir)){ exit }

if (global.cartas_disponiveis > 0){ exit };

estado_trocar(GAME.LOOP);