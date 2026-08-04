//DEBUG PRA FINALIZAR A RUN ----- NÃO ESQUECE DE APAGAR
//(Eu sei que vou esquece ,_,
//Vou passar duas horas procurando porque isso tá acontecendo e não vou achar

if (keyboard_check_pressed(ord("E"))) { loop_end(); }
if (keyboard_check_pressed(ord("C"))) { estado_trocar(GAME.LOOP); }
if (keyboard_check_pressed(ord("R"))) { estado_trocar(GAME.MENU); }