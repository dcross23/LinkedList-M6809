as6809 $2 -o main.asm
as6809 $2 -o leer_decimal.asm
as6809 $2 -o ver_decimal.asm
as6809 $2 -o imprime_cadena.asm
as6809 $2 -o menu_principal.asm
as6809 $2 -o crear_lista.asm
as6809 $2 -o imprimir_lista.asm
as6809 $2 -o eliminar_nodo.asm
as6809 $2 -o insertar_nodo.asm

aslink -s -m -w ejecutable.s19 main.rel -l Funciones

clear

m6809-run $1 ejecutable.s19
