/* EXEMPLO DE CARTA

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
		aplicar_clone:	function(_stats) {},
		ao_obter:		function() {},

*/


/// @desc ADICIONA CARTAS AQUI!!!!!
function cartas_definir()
{
	return [
	
	#region TYPE - ARMA
	
		#region COMUM
		#endregion
	
		#region INCOMUM
			carta_criar(
			{
				id: "arma_shotgun",
				nome: "Escopeta",
				desc: "De perto, a conversa é outra",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.INCOMUM,
				max_copias:	1
			}),
			
			carta_criar(
			{
				id: "arma_metralhadora",
				nome: "Metralhadora",
				desc: "Senta o dedo nessa porra!",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.INCOMUM,
				max_copias:	1
			}),
			
			carta_criar(
			{
				id: "arma_fuzil",
				nome: "Fuzil",
				desc: "Um tiro, um problema a menos",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.INCOMUM,
				max_copias:	1
			}),
			
		#endregion
	
		#region RARA
			carta_criar(
			{
				id: "arma_rajada",
				nome: "Rajada",
				desc: "É TREIX!!!",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.RARA,
				max_copias:	1
			}),
		#endregion
	
		#region LENDÁRIA
			carta_criar(
			{
				id: "arma_leque",
				nome: "Leque",
				desc: "Corredor congestionado? Deixa que eu limpo!",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.LENDARIA,
				max_copias:	1
			}),
		#endregion
		
	#endregion
		
	#region TYPE - SKILL
		
		#region COMUM
		#endregion
	
		#region INCOMUM
			carta_criar(
			{
				id: "skill_dash",
				nome: "Overclock",
				desc: "Utilize um dash",
				categoria:	CARTA_CAT.SKILL,
				raridade: CARTA_RAR.INCOMUM,
				max_copias:	1,
				requisito: function() { /* NÃO ter o teleport */ }
			}),
		#endregion
	
		#region RARA
			carta_criar(
			{
				id: "skill_teleport",
				nome: "Transposição",
				desc: "Teleportar-se em uma distância curta",
				categoria:	CARTA_CAT.SKILL,
				raridade: CARTA_RAR.RARA,
				max_copias:	1,
				requisito: function() { /* NÃO ter o dash */ }
			}),
		#endregion
	
		#region LENDÁRIA
			carta_criar(
			{
				id: "skill_stop",
				nome: "Suspenção",
				desc: "Paralisa todos projéteis inimigos por 2 segundos",
				categoria:	CARTA_CAT.SKILL,
				raridade: CARTA_RAR.LENDARIA,
				max_copias:	1
			}),
		#endregion
		
	#endregion
		
	#region TYPE - PASSIVO
		
		#region COMUM
			carta_criar(
			{
				id: "passive_ricochete",
				nome: "Ricochete",
				desc: "Suas balas ricocheteam nas paredes +1",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.COMUM
			}),
			
			carta_criar(
			{
				id: "passive_aim",
				nome: "Mira Estável",
				desc: "Reduz o Spread dos tiros",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.COMUM
			}),
		#endregion
	
		#region INCOMUM
			carta_criar(
			{
				id: "passive_perfuration",
				nome: "Perfuração",
				desc: "Sua bala atravessa +1 clone",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM
			}),
			
			carta_criar(
			{
				id: "passive_sanguessuga",
				nome: "Sanguessuga",
				desc: "Cura 1 após 5 kills",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM,
				heranca: HERANCA.NENHUMA,
				max_copias:	5
			}),
			
			carta_criar(
			{
				id: "passive_sugatempo",
				nome: "Viajante do Tempo",
				desc: "Cada abate devolve tempo ao relógio",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM,
				heranca: HERANCA.NENHUMA
			}),
			
			carta_criar(
			{
				id: "passive_adrenalina",
				nome: "Adrenalina",
				desc: "Quanto menor o tempo restante, maior a cadência de fogo",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM
			}),
			
			carta_criar(
			{
				id: "passive_berserk",
				nome: "Berserk",
				desc: "Quanto menor sua vida, mais dano você causa",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM,
				requisito: function() { /* Ter pelo menos 3 de vida máxima */ }
			}),
		#endregion
	
		#region RARA
			carta_criar(
			{
				id: "passive_boom",
				nome: "Tiro Explosivo",
				desc: "Quando os tiros acertam algo, geram uma explosão",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.RARA
			}),
			
			carta_criar(
			{
				id: "passive_shards_1",
				nome: "Estilhaço",
				desc: "Clones mortos explodem em 4 tiros",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.RARA,
				heranca: HERANCA.NENHUMA,
				max_copias:	1
			}),
		#endregion
	
		#region LENDÁRIA
			carta_criar(
			{
				id: "passive_shards_2",
				nome: "Estilhaços 2",
				desc: "Clones mortos explodem em 8 tiros",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.LENDARIA,
				heranca: HERANCA.NENHUMA,
				max_copias:	1,
				requisito: function() { /* Ter a carta passive_shards_1 */ }
			}),
			
			carta_criar(
			{
				id: "passive_sleep",
				nome: "Sonolento",
				desc: "Clones levam mais tempo para acordar",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.LENDARIA,
				heranca: HERANCA.NENHUMA
			}),
			
			carta_criar(
			{
				id: "passive_target",
				nome: "Ataque Teleguiado",
				desc: "Seus tiros curvam-se levemente em dirção ao alvo mais próximo",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.LENDARIA
			}),
			
			carta_criar(
			{
				id: "passive_bullet_sleep",
				nome: "Soninho",
				desc: "Aumenta o tempo que os projéteis ficam em repouso",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.LENDARIA,
				heranca: HERANCA.NENHUMA,
				requisito: function() { /* requer carta skill_stop */ }
			}),
		#endregion
		
	#endregion
		
	#region TYPE - STAT
		
		#region COMUM
			carta_criar(
			{
				id: "stat_move",
				nome: "Pé Leve",
				desc: "Você anda mais rápido",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.COMUM
			}),
			
			carta_criar(
			{
				id: "stat_fire_rate",
				nome: "Smokin' Joe Rudeboy",
				desc: "Sua cadência de tiro é reduzida",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.COMUM
			}),
			
			carta_criar(
			{
				id: "stat_dmg",
				nome: "Chumbo Grosso",
				desc: "Suas Balas dão mais dano",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.COMUM
			}),
			
			carta_criar(
			{
				id: "stat_bullet_speed",
				nome: "Cano Longo",
				desc: "Seus tiros são mais rápidos",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.COMUM
			}),
		#endregion
	
		#region INCOMUM
			carta_criar(
			{
				id: "stat_hp",
				nome: "Cardio",
				desc: "Vida máxima +1",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.INCOMUM
			}),
			
			carta_criar(
			{
				id: "stat_dash_distance",
				nome: "Peso Pena",
				desc: "Dash maior",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.INCOMUM,
				requisito: function() { /* Ter o dash */ }
			}),
			
			carta_criar(
			{
				id: "stat_teleport_distance",
				nome: "Visualização",
				desc: "Distância de Teleporte melhorada",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.INCOMUM,
				requisito: function() { /* Ter o Teleporte */ }
			}),
			
			carta_criar(
			{
				id: "stat_recarga",
				nome: "Apressado",
				desc: "Reduz o cooldown do dash",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.INCOMUM,
				requisito: function() { /* Ter o dash */ }
			}),
			
			
		#endregion
	
		#region RARA
			carta_criar(
			{
				id: "stat_bullet_size",
				nome: "Bullet Bill",
				desc: "Seus projéteis ficam maiores",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.RARA,
				heranca: HERANCA.PARCIAL
			}),
		#endregion
	
		#region LENDÁRIA
			carta_criar(
			{
				id: "stat_timer",
				nome: "Rolex",
				desc: "Mais tempo para finalizar o round",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.LENDARIA,
				heranca: HERANCA.NENHUMA
			}),
			
			carta_criar(
			{
				id: "stat_clone_points",
				nome: "Avareza",
				desc: "Clones dão mais pontos!",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.LENDARIA,
				heranca: HERANCA.NENHUMA
			}),
		#endregion
		
	#endregion
		
	#region TYPE - ITEM
		
		#region COMUM
		#endregion
	
		#region INCOMUM
			carta_criar(
			{
				id: "item_bomb",
				nome: "Bomba",
				desc: "Kabooom!",
				categoria:	CARTA_CAT.ITEM,
				raridade: CARTA_RAR.INCOMUM
			}),
			
			carta_criar(
			{
				id: "item_timeturner",
				nome: "Despertador",
				desc: "Só mais alguns segundos!",
				categoria:	CARTA_CAT.ITEM,
				raridade: CARTA_RAR.INCOMUM,
				heranca: HERANCA.NENHUMA
			}),
			
			carta_criar(
			{
				id: "item_pulse",
				nome: "Apagão",
				desc: "Destrói todos projéteis da sala",
				categoria:	CARTA_CAT.ITEM,
				raridade: CARTA_RAR.INCOMUM
			}),
		#endregion
	
		#region RARA
			carta_criar(
			{
				id: "item_shield",
				nome: "Escudo",
				desc: "Bloqueia o próximo dano",
				categoria:	CARTA_CAT.ITEM,
				raridade: CARTA_RAR.RARA
			}),
			
			carta_criar(
			{
				id: "item_flashbang",
				nome: "Flashbang",
				desc: "Stunna clones por alguns segundos",
				categoria:	CARTA_CAT.ITEM,
				raridade: CARTA_RAR.RARA,
				heranca: HERANCA.PARCIAL
			}),
		#endregion
	
		#region LENDÁRIA
			carta_criar(
			{
				id: "item_mirror",
				nome: "Espelho",
				desc: "De volta ao remetente!",
				categoria:	CARTA_CAT.ITEM,
				raridade: CARTA_RAR.LENDARIA,
				heranca: HERANCA.NENHUMA
			}),
		#endregion
		
	#endregion
	]
}