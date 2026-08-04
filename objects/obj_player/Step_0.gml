if (!jogo_rodando()) exit;

//Gravação do input
var _input = {}; //Inicializa o input como Struct

//Pra cada ação das inputs iniciados no create
for (var i = 0; i < array_length(input_actions); i++) {
	
	//Lê a ação
	var _acao = input_actions[i];
	_input[$ _acao.name] = _acao.read();
}


//Move baseado no input
mover(_input.move_x, _input.move_y);
empurrar();

//setta a mira
mira_atual = _input.mira

//Reduz o cooldown de tiros
if (cooldown > 0) { cooldown -= 1; }

//Atira
if (_input.atirando) { atirar(_input.mira); }

//Salva o frame
if(global.gravando)
{
	_input.step = record_step;
	array_push(recording_buffer, _input);
	record_step += 1;
}

//Último input pra debug
last_input = _input;