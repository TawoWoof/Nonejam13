// Inherit the parent event
event_inherited();

prompt = "PEGAR CARTA";
pode_interagir = function() { return (global.estado == GAME.LIVRE && global.cartas_disponiveis > 0)}