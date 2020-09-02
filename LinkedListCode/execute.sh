as6809 -o main.asm
as6809 -o leer_decimal.asm
as6809 -o ver_decimal.asm
as6809 -o imprime_cadena.asm
as6809 -o menu_principal.asm
as6809 -o crear_lista.asm
as6809 -o imprimir_lista.asm
as6809 -o eliminar_nodo.asm

aslink -s -m -w ejecutable.s19 main.rel -l Funciones

m6809-run $1 ejecutable.s19
