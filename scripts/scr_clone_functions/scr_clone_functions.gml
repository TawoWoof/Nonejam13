///@desc Spawna clones baseado na gravação dos loops
function spawn_clones() {
	//Loopa entre todos loops existentes
	for (var i = 0; i < array_length(loops); i++) {
		var _loop = loops[i];
		
		//Para cada loop, cria um clone e define seus atributos	
		var _clone = instance_create_layer(_loop.spawn_x, _loop.spawn_y, global.player.layer, obj_clone);
		_clone.buffer = _loop.buffer;
		_clone.loop_index = _loop.loop_index;
		_clone.cartas = _loop.cartas;
		
		stats_escrever(_clone, stats_montar(_loop.cartas, true));
		_clone.hp = _clone.max_hp;
		
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
	//Marca a pontuação do clone
	var _bonus = instance_exists(global.player) ? global.player.pontos_bonus : 0;
	var _pontos = clone_valor(_alvo.loop_index, _bonus)
	global.pontos += _pontos;
	global.pontos_abates += _pontos
	
	//Destrói o clone e a arma
	instance_destroy(_alvo.gun);
	instance_destroy(_alvo);
	
	global.kills_loop += 1;
	
	//Se for o último clone do loop, avisa ao controlador que o player terminou
	if (instance_number(obj_clone) == 0) {
		with (global.loop_master) { loop_end(); }
	}
}

///@desc Reseta o playback
function playback_reiniciar() {
	if (array_length(buffer) == 0) exit;
	
	playback_step = 0;
	
	//A arma gira suave da mira atual até a do primeiro frame gravado
	mira_inicial = mira_atual;
	mira_alvo = buffer[0].mira;
	

	delay = global.delay;	
	cooldown = 0;
	dash_timer = 0;
	dash_cooldown = 0;
}

///@desc Retorna o valor de um clone baseado no loop de origem
///@arg {REAL} _loop Loop de orgiem
///@arg {REAL} _upgrade Bônus somado a base
function clone_valor(_loop, _upgrade = 0)
{
	//Tutorial NÃO pontua
	if (_loop <= global.loops_tutorial) return 0;
	
	return (global.clone_pontos + _upgrade) * (_loop * global.loop_factor);
}