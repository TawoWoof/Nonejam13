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
			carta_criar(
			{
				id: "arma_inicial",
				nome: "Pistola",
				desc: "Faz o básico, como sempre.",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.COMUM,
				max_copias:	1,
				aplicar: function(_s)
				{
					_s.bullet_count  = 1;
					_s.bullet_spread = 18;
					_s.fire_rate	 = 20;
					_s.bullet_speed  = 8;
					_s.bullet_dmg	 = 1;
				}
			}),
		#endregion
	
		#region INCOMUM
			carta_criar(
			{
				id: "arma_shotgun",
				nome: "Escopeta",
				desc: "De perto, a conversa é outra",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.INCOMUM,
				max_copias:	1,
				aplicar: function(_s) {
					_s.bullet_count = 5;
					_s.bullet_spread = 40;
					_s.fire_rate = 45;
					_s.bullet_speed = 7;
					_s.bullet_dmg = 1;
				}
			}),
			
			carta_criar(
			{
				id: "arma_metralhadora",
				nome: "Metralhadora",
				desc: "Senta o dedo nessa porra!",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.INCOMUM,
				max_copias:	1,
				aplicar: function(_s) {
					_s.bullet_count = 1;
					_s.bullet_spread = 25;
					_s.fire_rate = 6;
					_s.bullet_speed = 10;
					_s.bullet_dmg = 1;
				}
			}),
			
			carta_criar(
			{
				id: "arma_fuzil",
				nome: "Fuzil",
				desc: "Um tiro, um problema a menos",
				categoria:	CARTA_CAT.ARMA,
				raridade: CARTA_RAR.INCOMUM,
				max_copias:	1,
				aplicar: function(_s) {
					_s.bullet_count = 1;
					_s.bullet_spread = 2;
					_s.fire_rate = 40;
					_s.bullet_speed = 16;
					_s.bullet_dmg = 3;
				}
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
				max_copias:	1,
				aplicar: function(_s) {
					_s.bullet_count = 3;
					_s.bullet_spread = 8;
					_s.fire_rate = 35;
					_s.bullet_speed = 12;
					_s.bullet_dmg = 1;
				}
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
				max_copias:	1,
				aplicar: function(_s) {
					_s.bullet_count = 7;
					_s.bullet_spread = 90;
					_s.fire_rate = 60;
					_s.bullet_speed = 6;
					_s.bullet_dmg = 1;
				}
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
				//requisito: function() { /* NÃO ter o teleport */ }
			}),
		#endregion
		
		#region RARA
		
			//carta_criar(
			//{
			//	id: "skill_teleport",
			//	nome: "Transposição",
			//	desc: "Teleportar-se em uma distância curta",
			//	categoria:	CARTA_CAT.SKILL,
			//	raridade: CARTA_RAR.RARA,
			//	max_copias:	1,
			//	requisito: function() { /* NÃO ter o dash */ }
			//}),
		#endregion
	
		#region LENDÁRIA
			//carta_criar(
			//{
			//	id: "skill_stop",
			//	nome: "Suspenção",
			//	desc: "Paralisa todos projéteis inimigos por 2 segundos",
			//	categoria:	CARTA_CAT.SKILL,
			//	raridade: CARTA_RAR.LENDARIA,
			//	max_copias:	1
			//}),
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
				raridade: CARTA_RAR.COMUM,
				aplicar: function(_s){ _s.ricochete += 1 }
			}),
			
			carta_criar(
			{
				id: "passive_aim",
				nome: "Mira Estável",
				desc: "Reduz o Spread dos tiros",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.COMUM,
				aplicar: function(_s){ _s.bullet_spread = max(4, _s.bullet_spread - 6) }
			}),
		#endregion
	
		#region INCOMUM
			carta_criar(
			{
				id: "passive_perfuration",
				nome: "Perfuração",
				desc: "Sua bala atravessa +1 clone",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM,
				aplicar: function(_s){ _s.perfuracao += 1 }
			}),
			
			carta_criar(
			{
				id: "passive_sanguessuga",
				nome: "Sanguessuga",
				desc: "Cura 1 após 5 kills",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM,
				heranca: HERANCA.NENHUMA,
				max_copias:	5,
				aplicar: function(_s){ _s.sanguessuga += 1 }
			}),
			
			carta_criar(
			{
				id: "passive_sugatempo",
				nome: "Viajante do Tempo",
				desc: "Cada abate devolve tempo ao relógio",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM,
				heranca: HERANCA.NENHUMA,
				aplicar: function(_s){ _s.tempo_por_kill += 60 }
			}),
			
			carta_criar(
			{
				id: "passive_adrenalina",
				nome: "Adrenalina",
				desc: "Quanto menor o tempo restante, maior a cadência de fogo",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM,
				aplicar: function(_s){ _s.adrenalina += 1 }
			}),
			
			carta_criar(
			{
				id: "passive_berserk",
				nome: "Berserk",
				desc: "Quanto menor sua vida, mais dano você causa",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.INCOMUM,
				requisito: function() { return (instance_exists(global.player) && global.player.max_hp >= 5 )},
				aplicar: function(_s){ _s.berserk += 1 }
			}),
		#endregion
	
		#region RARA
			carta_criar(
			{
				id: "passive_boom",
				nome: "Tiro Explosivo",
				desc: "Quando os tiros acertam algo, geram uma explosão",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.RARA,
				heranca: HERANCA.PARCIAL,
				aplicar: function(_s){ _s.explosao += 24 },
				aplicar_clone: function(_s){ _s.explosao += 12 }
			}),
			
			carta_criar(
			{
				id: "passive_shards_1",
				nome: "Estilhaço",
				desc: "Clones mortos explodem em tiros",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.RARA,
				heranca: HERANCA.NENHUMA,
				max_copias:	4,
				aplicar: function(_s){ _s.estilhacos += 1 }
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
				requisito: function() { return (carta_copias("passive_shards_1") > 3 )},
				aplicar: function(_s){ _s.estilhacos = max(_s.estilhacos, 8) }
			}),
			
			carta_criar(
			{
				id: "passive_sleep",
				nome: "Sonolento",
				desc: "Clones levam mais tempo para acordar",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.LENDARIA,
				heranca: HERANCA.NENHUMA,
				aplicar: function(_s){ _s.sono += 60 }
			}),
			
			carta_criar(
			{
				id: "passive_target",
				nome: "Ataque Teleguiado",
				desc: "Seus tiros curvam-se levemente em dirção ao alvo mais próximo",
				categoria:	CARTA_CAT.PASSIVO,
				raridade: CARTA_RAR.LENDARIA,
				aplicar: function(_s){ _s.mira_curva += 2 }
			}),
			
			//carta_criar(
			//{
			//	id: "passive_bullet_sleep",
			//	nome: "Soninho",
			//	desc: "Aumenta o tempo que os projéteis ficam em repouso",
			//	categoria:	CARTA_CAT.PASSIVO,
			//	raridade: CARTA_RAR.LENDARIA,
			//	heranca: HERANCA.NENHUMA,
			//	requisito: function() { /* requer carta skill_stop*/ }
			//}),
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
				raridade: CARTA_RAR.COMUM,
				aplicar: function(_s){ _s.move_speed += 1; }
			}),
			
			carta_criar(
			{
				id: "stat_fire_rate",
				nome: "Smokin' Joe Rudeboy",
				desc: "Sua cadência de tiro é reduzida",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.COMUM,
				aplicar: function(_s){ _s.fire_rate = max(4, _s.fire_rate - 3); }
			}),
			
			carta_criar(
			{
				id: "stat_dmg",
				nome: "Chumbo Grosso",
				desc: "Suas Balas dão mais dano",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.COMUM,
				aplicar: function(_s){ _s.bullet_dmg += 1; }
			}),
			
			carta_criar(
			{
				id: "stat_bullet_speed",
				nome: "Cano Longo",
				desc: "Seus tiros são mais rápidos",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.COMUM,
				aplicar: function(_s){ _s.bullet_speed += 1; }
			}),
		#endregion
	
		#region INCOMUM
			carta_criar(
			{
				id: "stat_hp",
				nome: "Cardio",
				desc: "Vida máxima +1",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.INCOMUM,
				aplicar: function(_s){ _s.max_hp += 1; },
				ao_obter: function() { global.player.hp += 1 }
			}),
			
			carta_criar(
			{
				id: "stat_dash_distance",
				nome: "Peso Pena",
				desc: "Dash maior",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.INCOMUM,
				aplicar: function(_s){ _s.dash_speed += 2; },
				requisito: function() { return (carta_copias("skill_dash") > 0) }
			}),
			
			//carta_criar(
			//{
			//	id: "stat_teleport_distance",
			//	nome: "Visualização",
			//	desc: "Distância de Teleporte melhorada",
			//	categoria:	CARTA_CAT.STAT,
			//	raridade: CARTA_RAR.INCOMUM,
			//	aplicar: function(_s){ _s.teleport_dist += 32; },
			//	requisito: function() { /* Ter o Teleporte*/ }
			//}),
			
			carta_criar(
			{
				id: "stat_recarga",
				nome: "Apressado",
				desc: "Reduz o cooldown do dash",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.INCOMUM,
				aplicar: function(_s){ _s.dash_cd = max(10, _s.dash_cd - 8); },
				requisito: function() { return (carta_copias("skill_dash") > 0); }
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
				heranca: HERANCA.PARCIAL,
				max_cartas: 8,
				aplicar: function(_s){ _s.bullet_scale += 0.5; },
				aplicar_clone: function(_s){ _s.bullet_scale += 0.25; }
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
				heranca: HERANCA.NENHUMA,
				aplicar: function(_s){ _s.tempo_bonus += 300; },
			}),
			
			carta_criar(
			{
				id: "stat_clone_points",
				nome: "Avareza",
				desc: "Clones dão mais pontos!",
				categoria:	CARTA_CAT.STAT,
				raridade: CARTA_RAR.LENDARIA,
				heranca: HERANCA.NENHUMA,
				aplicar: function(_s){ _s.pontos_bonus += 50; },
			}),
		#endregion
		
	#endregion
		
	#region TYPE - ITEM
		/*
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
				heranca: HERANCA.NENHUMA,
			}),
		#endregion
		*/
	#endregion
	]
}