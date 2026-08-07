///@desc Spawna clones baseado na gravação dos loops
function spawn_clones() {
	//Sonolento
	var _sono = instance_exists(global.player) ? global.player.sono : 0;
	
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
		_clone.delay = _clone.delay + _sono;
		_clone.delay_max = _clone.delay;
		
		//Identidade visual pelo loop de origem
		_clone.cor = loop_cor(_loop.loop_index);
		_clone.cor_viva = cor_clarear(cor_dessaturar(_clone.cor, global.clone_dessat), global.clone_clarear);
		
		//Se existe um buffer no clone, cria um target para a mira
		if (array_length(_loop.buffer) > 0) {
			_clone.mira_alvo = _loop.buffer[0].mira;
		}
		
		show_debug_message("clone loop " + string(_loop.loop_index)
			+ " | cartas: " + string(_loop.cartas)
			+ " | bullet_count: " + string(_clone.bullet_count));
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
	
	//guarda a posição antes de destruir
	var _mx = _alvo.x
	var _my = _alvo.y
	
	var _cor = _alvo.cor;
	var _dir = _alvo.ultimo_hit_dir;
	var _xs = _alvo.image_xscale;
	var _ys = _alvo.image_yscale;
	
	
	//Destrói o clone e a arma
	instance_destroy(_alvo.gun);
	instance_destroy(_alvo);
	
	tinta_splatter(_mx, _my, global.tinta_raio_morte, _cor,
		global.tinta_gotas_morte, _dir, global.tinta_forca_morte)
		
	tinta_corpo(global.tinta_spr_corpo, 0, _mx, _my, _xs, _ys, irandom(359), _cor);
	
	global.kills_loop += 1;
	
	//passivos de abate
	if (instance_exists(global.player))
	{
		with (global.player)
		{
			if (sanguessuga > 0)
			{
				kills_cura += 1;
				
				if (kills_cura >= max(1, 6 - sanguessuga))
				{
					kills_cura = 0;
					hp = min(hp + 1, max_hp)
				}
			}
			
			if (tempo_por_kill > 0 && global.loop_tempo != TIMELESS)
			{
				global.loop_tempo += tempo_por_kill;
			}
			
			if (estilhacos > 0)
			{
				estilhacar(_mx, _my, estilhacos)
			}
		}
	}
	
	//Se for o último clone do loop, avisa ao controlador que o player terminou
	if (instance_number(obj_clone) == 0) {
		with (global.loop_master) { loop_end(); }
	}
}

// @desc Dispara tiros em circulo a partir de um ponto
/// @arg {REAL} _x
/// @arg {REAL} _y
/// @arg {REAL} _n
function estilhacar(_x, _y, _n)
{
	if (_n <= 0) exit;
	
	var _passo = 360 / _n
	
	for (var i = 0; i < _n; i++)
	{
		var _b = instance_create_layer(_x, _y, layer, obj_bullet);
		
		_b.bullet_dir = _passo * i;
		_b.image_angle = _b.bullet_dir;
		_b.bullet_speed = bullet_speed;
		_b.dmg = bullet_dmg;
		_b.owner_type = BULLET_OWNER.PLAYER;
		_b.sprite_index = spr_bullet_player;
		_b.image_xscale = bullet_scale;
		_b.image_yscale = bullet_scale;
		_b.bounces_left = ricochete;
		_b.pierce_left = perfuracao;
		_b.curva = mira_curva;
		_b.cor = cor;
	}
}

///@desc Reseta o playback
function playback_reiniciar() {
	if (array_length(buffer) == 0) exit;
	
	playback_step = 0;
	
	//A arma gira suave da mira atual até a do primeiro frame gravado
	mira_inicial = mira_atual;
	mira_alvo = buffer[0].mira;
	
	var _sono = instance_exists(global.player) ? global.player.sono : 0;
	
	delay = global.delay + _sono;	
	delay_max = delay;	
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