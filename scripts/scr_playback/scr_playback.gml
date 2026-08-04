/// @desc Finaliza a gravação do loop
function loop_end() {
	if (global.player == noone || !global.gravando) exit;
	
	global.gravando = false;
	
	var _loop = {
		loop_index: global.loop_atual,
		buffer: global.player.recording_buffer,
		spawn_x: global.player.loop_start_x,
		spawn_y: global.player.loop_start_y,
		max_hp: global.player.max_hp
	};
	
	array_push(loops, _loop);
	
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
	
	var _min_dist = _dist;	//Distância minima para spawn de outras entidades
	var _try = 50;			//Quantidade de tentativas de spawn
	
	//Loopa pelas tentativas
	for (var t = 0; t < _try; t++) {
		
		//Pega um lugar random
		var _try_x = irandom(room_width);
		var _try_y = irandom(room_height);
		
		//Checa se está fora da parede
		if (place_meeting(_try_x, _try_y, obj_wall)) continue;
		
		//Checa se está muito perto de alguma entidade
		var _valido = true;
		var _clones = instance_number(obj_clone);
		for (var i = 0; i < _clones; i++) {
			var _clone_atual = instance_find(obj_clone, i);
			if (point_distance(_try_x, _try_y, _clone_atual.x, _clone_atual.y) < _min_dist) {
				_valido = false;
				break;
			}
		}
		
		//Se encontrou um spawn válido, envia
		if (_valido) {
			return { x: _try_x, y: _try_y };
		}
	}
	
	//Se não, desiste da vida
	return { x: x, y: y };
}