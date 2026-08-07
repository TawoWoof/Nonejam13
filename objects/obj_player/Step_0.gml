//Animação de morte roda com a gameplay já parada
if (anim_morte)
{
	if (global.frame_ativo) { sprite_atualizar(0, 0); }
	exit;
}

if (!jogo_rodando()) exit;

if(flash_timer > 0){ flash_timer -= 1 }

//Gravação do input
var _input = {}; //Inicializa o input como Struct

//Pra cada ação das inputs iniciados no create
for (var i = 0; i < array_length(input_actions); i++) {
	
	//Lê a ação
	var _acao = input_actions[i];
	_input[$ _acao.name] = _acao.read();
}


if(_input.dash) { dashear(_input.move_x, _input.move_y, _input.mira) }

//Move baseado no input
mover(_input.move_x, _input.move_y);
empurrar();

//setta a mira
mira_atual = _input.mira

//lê o nome da função krlh
sprite_atualizar(_input.move_x, _input.move_y);

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