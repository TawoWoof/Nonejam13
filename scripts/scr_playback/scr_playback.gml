/// @desc Finaliza a gravação do loop
function loop_end() {
	if (global.player == noone || !global.gravando) exit;
	
	//Adiciona os pontos de tempo
	global.pontos_tempo = floor(loop_ms_restantes() * global.pontos_segundo / 1000);
	global.pontos += global.pontos_tempo;
	global.kills_loop = 0;
	
	global.gravando = false;
	
	var _loop = {
		loop_index: global.loop_atual,
		buffer: global.player.recording_buffer,
		spawn_x: global.player.loop_start_x,
		spawn_y: global.player.loop_start_y,
		cartas: heranca_calcular()
	};
	
	array_push(loops, _loop);
	
	if (global.loop_atual > 0 && global.loop_atual mod global.cartas_intervalo == 0)
	{
		global.cartas_disponiveis += 1;	
	}
	
	limpar_balas();
	
	if (global.cartas_disponiveis > 0)
	{
		estado_trocar(GAME.FREEZE);
		exit
	}
	
	estado_trocar(GAME.GAP);
}

/// @desc Inicia a gravação do loop
function loop_start()
{
	if (global.player == noone || global.gravando) exit;
	
	global.loop_atual += 1;
	spawn_clones();
	
	var _pos;
	with (global.player) {
		_pos = spawn_player();
	}
	global.player.x = _pos.x;
	global.player.y = _pos.y;
	
	//Reseta a gravação do player
	global.player.recording_buffer = [];
	global.player.record_step = 0;
	global.player.vel_x = 0;
	global.player.vel_y = 0;
	global.player.cooldown = 0;
	global.player.loop_start_x = global.player.x;
	global.player.loop_start_y = global.player.y;
	
	
	global.gravando = true;
}

/// @desc Calcula locais de possível spawn random para o player
function spawn_player(_dist = 128) {
	
	//Se for o primeiro loop, envia as informações 
	if (global.loop_atual == 1){ return { x: global.tutorial_x, y: global.tutorial_y }; }
	
	var _try = 60;
	var _melhor_x = x;
	var _melhor_y = y;
	var _melhor_folga = -1;
	
	for (var t = 0; t < _try; t++)
	{
		var _try_x = irandom(room_width);
		var _try_y = irandom(room_height);
		
		//Checa se está fora da parede
		if (place_meeting(_try_x, _try_y, obj_wall)){ continue }
		
		//Checa se está muito perto de alguma entidade
		var _folga = room_width + room_height;
		var _clones = instance_number(obj_clone);
		
		with (obj_clone)
		{
			_folga = min(_folga, point_distance(_try_x, _try_y, x, y));
		}
			
		//Salva o melhor candidato
		if (_folga > _melhor_folga)
		{
			_melhor_folga = _folga;
			_melhor_x = _try_x;
			_melhor_y = _try_y;
		}
			
		//Folga suficiente? Para de procurar
		if (_folga >= _dist) break;
	}
	
	//Se não, desiste da vida
	return { x: _melhor_x, y: _melhor_y };
}