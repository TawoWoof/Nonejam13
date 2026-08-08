spawn_tick = 0;

global.deriva_x = 0;
global.deriva_y = 0;
global.tinta_off_x = 0;
global.tinta_off_y = 0;
global.tinta_fade = 0;

global.menu_botoes = [
	{texto: "PLAY", acao: function() { estado_trocar(GAME.GAP); }},
	{texto: "CONFIGS", acao: function() { estado_trocar(GAME.GAP); }},
	{texto: "CRÉDITOS", acao: function() { estado_trocar(GAME.GAP); }},
	{texto: "SAIR", acao: function() { estado_trocar(GAME.GAP); }}
];