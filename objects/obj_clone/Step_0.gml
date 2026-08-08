if (!jogo_rodando()) exit;

if (flash_timer > 0){ flash_timer -= 1 }

windup = 0;

//buffer vazio = congelar
if (array_length(buffer) == 0) { frozen = true }
if(frozen) 
{
	sprite_atualizar(0, 0);	
	exit
}

//Se tiver delay, reduz o timer e sai do step
if (delay > 0)
{
	delay--
	
	//Ajusta a arma para o angulo inicial enquanto espera o delay terminar
	var _t = 1 - (delay / max(1, delay_max));
	mira_atual = mira_inicial + angle_difference(mira_alvo, mira_inicial) * _t;
	
	//O fade de nascimento acontece uma vez só, no spawn
	if (!acordou) { alpha_atual = lerp(global.clone_spawn_alpha, 1, _t); }
	
	exit
}
acordou = true;
alpha_atual = 1;

//Se já terminou de executar o playback, congela
if (playback_step >= array_length(buffer)) {
	playback_reiniciar();
	exit
}

//Setta o frame atual
var _frame = buffer[playback_step];

if(_frame.dash) { dashear(_frame.move_x, _frame.move_y, _frame.mira) }

//Chama o movimento
mover(_frame.move_x, _frame.move_y);

//Chama a colisão com entidades
empurrar();

//Atualiza a mira
mira_atual = _frame.mira;
windup = windup_calcular();

//Não vou nem falar pra que serve, tenta dar um chute :D
sprite_atualizar(_frame.move_x, _frame.move_y);

//Atira
if (cooldown > 0) { cooldown -= 1; }
if (_frame.atirando) { atirar(_frame.mira); }


//Aumenta o step do playback
playback_step += 1;