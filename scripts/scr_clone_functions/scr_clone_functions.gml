///@desc Spawna clones baseado na gravação dos loops
function spawn_clones() {
	//Loopa entre todos loops existentes
	for (var i = 0; i < array_length(loops); i++) {
		var _loop = loops[i];
		
		//Para cada loop, cria um clone e define seus atributos	
		var _clone = instance_create_layer(_loop.spawn_x, _loop.spawn_y, global.player.layer, obj_clone);
		_clone.buffer = _loop.buffer;
		_clone.max_hp = _loop.max_hp;
		_clone.hp = _loop.max_hp;
		
		//Se existe um buffer no clone, cria um target para a mira
		if (array_length(_loop.buffer) > 0) {
			_clone.mira_alvo = _loop.buffer[0].mira;
		}
	}
}

///@desc Mata o clone atingido
///@arg {Asset.GMObject}  _alvo  Alvo atingido
function die(_alvo)
{
	//Destrói o clone e a arma
	instance_destroy(_alvo.gun);
	instance_destroy(_alvo);
	
	//Se for o último clone do loop, avisa ao controlador que o player terminou
	if (instance_number(obj_clone) == 0) {
		with (global.loop_master) { loop_end(); }
	}
}