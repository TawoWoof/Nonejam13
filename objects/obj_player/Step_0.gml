//Captura Ações
var _input = {};
for (var i = 0; i < array_length(input_actions); i++) {
	var _acao = input_actions[i];
	_input[$ _acao.name] = _acao.read();
}


//Move baseado no input
mover(_input.move_x, _input.move_y);

//setta a mira
mira_atual = _input.mira

//Redu o cooldown se ele existe
if (cooldown > 0) { cooldown -= 1; }

//Atira
if (_input.atirando) { atirar(_input.mira); }

//Salva o frame
_input.step = record_step;
array_push(recording_buffer, _input);
record_step += 1;

last_input = _input;