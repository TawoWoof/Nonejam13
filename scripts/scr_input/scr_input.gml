function criar_input() {
	var _self = self;
	return [
		{ name: "move_x",   read: method(self, function() { return keyboard_check(global.move_right) - keyboard_check(global.move_left); }) },
		{ name: "move_y",   read: method(self, function() { return keyboard_check(global.move_down) - keyboard_check(global.move_up); }) },
		{ name: "mira",     read: method(self, function() { return point_direction(x, y, mouse_x, mouse_y); }) },
		{ name: "atirando", read: method(self, function() { return mouse_check_button(global.shoot); }) },
	];
}

function loop_end() {
	if (global.player == noone || instance_number(obj_clone) > 0) exit;
	
	var _loop = {
		loop_index: loop_atual,
		buffer: global.player.recording_buffer,
		spawn_x: global.player.loop_start_x,
		spawn_y: global.player.loop_start_y,
		max_hp: global.player.max_hp
	};
	
	array_push(loops, _loop);
	
	//Reseta a gravação do player pro próximo loop
	global.player.recording_buffer = [];
	global.player.record_step = 0;
	global.player.loop_start_x = global.player.x;
	global.player.loop_start_y = global.player.y;
	
	loop_atual += 1;
	
	//SPAWN CLONES PODE VIR AQUI EVENTUALMENTE. POR HORA NÃO.
}