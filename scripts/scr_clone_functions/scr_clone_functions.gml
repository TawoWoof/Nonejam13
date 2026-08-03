function spawn_clones() {
	for (var i = 0; i < array_length(loops); i++) {
		var _loop = loops[i];
		
		var _clone = instance_create_layer(_loop.spawn_x, _loop.spawn_y, global.player.layer, obj_clone);
		_clone.buffer = _loop.buffer;
		_clone.max_hp = _loop.max_hp;
		_clone.hp = _loop.max_hp;
	}
}

function die(_alvo)
{
	instance_destroy(_alvo.gun);
	instance_destroy(_alvo);
}