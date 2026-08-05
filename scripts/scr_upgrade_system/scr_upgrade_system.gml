#macro ILIMITADO -1

enum CARTA_CAT {
	ARMA,
	SKILL,
	PASSIVO,
	STAT,
	ITEM
}

enum CARTA_RAR {
	COMUM,
	INCOMUM,
	RARA,
	LENDARIA
}

enum HERANCA {
	TOTAL,
	PARCIAL,
	NENHUMA
}

/// @desc Peso padrão de cada raridade - Caso eu esqueça de declarar
/// @arg {REAL} _raridade
function raridade_peso(_raridade) {
	switch(_raridade){
		case CARTA_RAR.COMUM:		return 100;
		case CARTA_RAR.INCOMUM:		return 50;
		case CARTA_RAR.RARA:		return 20;
		case CARTA_RAR.LENDARIA:	return 5;
	}
	
	return 0;
}

/// @desc Peso efetivo
/// @arg {Struct} _carta
function carta_peso(_carta) {
	return (_carta.peso < 0) ? raridade_peso(_carta.raridade) : _carta.peso;
}

/// @desc Monta uma carta preenchedo campos vazios
/// @arg {Struct} _dados Sò os campos que diferem do padrão
function carta_criar(_dados)
{
	var _carta = {
		id:				"",
		nome:			"",
		desc:			"",
		sprite:			-1,
		categoria:		CARTA_CAT.STAT,
		raridade:		CARTA_RAR.COMUM,
		peso:			-1,
		tags:			[],
		requisito:		function() { return true; },
		max_copias:		ILIMITADO,
		heranca:		HERANCA.TOTAL,
		aplicar:		function(_stats) {},
		aplicar_clone:	undefined,
		ao_obter:		function() {},
	}
	
	//Sobrescreve informações declaradas
	var _chaves = struct_get_names(_dados);
	for (var i = 0; i < array_length(_chaves); i++)
	{
		_carta[$ _chaves[i]] = _dados[$ _chaves[i]]
	}
	
	return _carta
}

/// @desc Catalogo em cache
function cartas_catalogo()
{
	if(!variable_global_exists("cartas") || is_undefined(global.cartas))
	{
		global.cartas = cartas_definir()
	}
	
	return global.cartas;
}

/// @desc Achar carta por id
/// @arg {String} _id
function carta_por_id(_id)
{
	var _todas = cartas_catalogo();
	
	for (var i = 0; i < array_length(_todas); i++)
	{
		if (_todas[i].id == _id){ return _todas[i] }
	}
	
	return undefined
}

/// @desc Aplica uma carta com stats
/// @arg {Struct} _carta
/// @arg {Struct} _stats Struct que recebe as modificações
/// @arg {BOOL}	_eh_clone True se for stats para um clone
function carta_aplicar(_carta, _stats, _eh_clone = false)
{
	//Player sempre roda normal
	if (!_eh_clone)
	{
		_carta.aplicar(_stats);
		exit;
	}
	
	switch (_carta.heranca)
	{
		case HERANCA.TOTAL:
			_carta.aplicar(_stats);
			break;
			
		case HERANCA.PARCIAL:
			if (is_undefined(_carta.aplicar_clone))
			{
				show_debug_message("Carta PARCIAL sem informação de clonagem. Carta ID: " + _carta.id)
				break;
			}
			
			_carta.aplicar_clone(_stats);
			break
		case HERANCA.NENHUMA:
			//Aplica a presença do meu pai na minha vida
			//Sim, eu vou tentar fazer alguma piadinhas pelo código todo
			//Essa foi a primeira escrita. Por que? Pq eu perco a concentração fácil e isso ajuda
		break;
	}
}

/// @desc Quantas cópias existe no baralho do jogador
/// @arg {String} _id
function carta_copias(_id)
{
	var _n = 0;
	
	for (var i = 0; i < array_length(global.inventario); i++)
	{
		if (global.inventario[i] == _id){ _n += 1; }
	}
	
	return _n
}

/// @desc Pode sortear?
/// @arg {Struct} _carta
function carta_disponivel(_carta)
{
	//estourou o limite de cópias
	if (_carta.max_copias != ILIMITADO && carta_copias(_carta.id) >= _carta.max_copias){ return false }
	
	//Checa os requisitos da carta
	if (!_carta.requisito()){ return false }

	return true
}

/// @desc Sorteia uma carta disponível (Undefined se não tiver nenhum)
function carta_sortear()
{
	var _todas = cartas_catalogo();
	var _pool = []
	
	for (var i = 0; i < array_length(_todas); i++)
	{
		if (carta_disponivel(_todas[i]))
		{
			array_push(_pool, _todas[i])
		}
	}
	
	if (array_length(_pool) == 0){ return undefined }
	
	return _pool[irandom(array_length(_pool) - 1)]
}

/// @desc Entrega carta ao player
/// @arg {Struct} _carta
function carta_obter(_carta)
{
	if (is_undefined(_carta)){ exit }
	
	if (_carta.categoria == CARTA_CAT.ARMA){ arma_remover() }
	
	array_push(global.inventario, _carta.id);
	
	stats_recalcular();
	
	_carta.ao_obter();
	
	
	
	show_debug_message("Obteve Carta: " + string(_carta.nome) + " (" + string(carta_copias(_carta.id)) + "x)");
}

/// @desc Monta um struct de stats a partir das cartas
/// @arg {Array} _ids ID das cartas
/// @arg {BOOL} _eh_clone True se for status de clone
function stats_montar(_ids, _eh_clone = false)
{
	//Puxa os stats iniciais
	var _stats = start_stats();
	
	//Loopa duas vezes pra corrigir a arma
	for(var _passada = 0; _passada < 2; _passada++)
	{
		for(var i = 0; i < array_length(_ids); i++)
		{
			var _carta = carta_por_id(_ids[i])
		
			if (is_undefined(_carta)) { continue }
			
			var _eh_arma = (_carta.categoria == CARTA_CAT.ARMA);
			
			//Começa com um loop de armas e depois aplica os stats
			if(_passada == 0 && !_eh_arma){ continue }
			if(_passada == 1 && _eh_arma){ continue }
			
			carta_aplicar(_carta, _stats, _eh_clone);
		}
	}
	
	if (_eh_clone){ _stats.bullet_speed *= _stats.clone_bullet_multiplier; }
	
	return _stats
}

/// @desc Escreve uma struct de stats nas variáveis de instância
/// @arg {Id.Instance} _inst
/// @arg {Struct} _stats
function stats_escrever(_inst, _stats)
{
	var _chaves = struct_get_names(_stats)
	
	for(var i = 0; i < array_length(_chaves); i++)
	{
		variable_instance_set(_inst, _chaves[i], _stats[$ _chaves[i]])
	}
}

/// @desc Reconstrói os stats do player pelo inventário
function stats_recalcular()
{
	if (global.player == noone || !instance_exists(global.player)){ exit }
	
	stats_escrever(global.player, stats_montar(global.inventario))
	
	//Vida atual não pode passar do teto novo
	global.player.hp = min(global.player.hp, global.player.max_hp)
}

/// @desc Lista de cartas do clone (Loop atual)
function heranca_calcular()
{
	var _lista = [];
	array_copy(_lista, 0, global.inventario, 0, array_length(global.inventario))

	return _lista;
}

/// @desc Tira carta de armas do inventário
function arma_remover()
{
	for (var i = array_length(global.inventario) -1; i >= 0; i--)
	{
		var _c = carta_por_id(global.inventario[i]);
		
		if (!is_undefined(_c) && _c.categoria == CARTA_CAT.ARMA)
		{
			array_delete(global.inventario, i, 1)
		}
	}
}

/// @desc Sorteia um indice para pool proporcional ao peso
/// @arg {Array} _pool
function pool_sortear(_pool)
{
	var _total = 0;
	for (var i = 0; i < array_length(_pool); i++)
	{
		_total += carta_peso(_pool[i]);
	}
	
	if (_total <= 0){ return 0 };
	
	var _sorteio = random(_total);
	var _acumulado = 0;
	
	for (var i = 0; i < array_length(_pool); i++)
	{
		_acumulado += carta_peso(_pool[i]);
		
		if (_sorteio < _acumulado){ return i }
	}
	
	return array_length(_pool) - 1;
}

/// @desc Sorteia N cartas DISTINTAS entre as disponiveis
/// @arg {REAL} _n Quantidade desejada
function cartas_sortear_varias(_n)
{
	//cartas elegiveis
	var _pool = [];
	var _todas = cartas_catalogo();
	
	for(var i = 0; i < array_length(_todas); i++)
	{
		if(carta_disponivel(_todas[i])){ array_push(_pool, _todas[i]) }
	}
	
	var _resultado = []
	for(var i = 0; i < _n; i++)
	{
		if (array_length(_pool) == 0){ break }
		
		var _idx = pool_sortear(_pool)
		
		array_push(_resultado, _pool[_idx])
		array_delete(_pool, _idx, 1);
	}
	
	return _resultado;
}