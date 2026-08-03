//DEBUG PRA FINALIZAR A RUN ----- NÃO ESQUECE DE APAGA
//(Eu sei que vou esquece ,_,
//Vou passar duas horas procurando porque isso tá acontecendo e não vou achar
if (keyboard_check_pressed(ord("E"))) {
	global.win = true;
}

if (keyboard_check_pressed(ord("C"))) {
	spawn_clones();
}

if (global.win) {
	loop_end();
	global.win = false;
}