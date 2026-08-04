if (!jogo_rodando()) exit;

//Se tiver delay, reduz o timer e sai do step
if (delay > 0)
{
	delay--
	
	//Ajusta a arma para o angulo inicial enquanto espera o delay terminar
	var _t = 1 - (delay / global.delay);
	mira_atual = mira_inicial + angle_difference(mira_alvo, mira_inicial) * _t;
	
	exit
}

//Se já terminou de executar o playback, congela
if (playback_step >= array_length(buffer)) {
	frozen = true;
}

//se já congelou, saia do step
if (frozen) exit;

//Setta o frame atual
var _frame = buffer[playback_step];

//Chama o movimento
mover(_frame.move_x, _frame.move_y);

//Chama a colisão com entidades
empurrar();

//Atualiza a mira
mira_atual = _frame.mira;

//Atira
if (cooldown > 0) { cooldown -= 1; }
if (_frame.atirando) { atirar(_frame.mira); }

//Aumenta o step do playback
playback_step += 1;