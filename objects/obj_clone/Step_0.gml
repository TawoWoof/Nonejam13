if (playback_step >= array_length(buffer)) {
	frozen = true;
}

if (frozen) exit;

var _frame = buffer[playback_step];

mover(_frame.move_x, _frame.move_y);
mira_atual = _frame.mira;

if (cooldown > 0) { cooldown -= 1; }
if (_frame.atirando) { atirar(_frame.mira); }

playback_step += 1;