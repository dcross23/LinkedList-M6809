	.module main


;================================================================================|
;				CONSTANTES					 |  <------------------------	
;================================================================================|
fin         .equ 0xFF01			;parar el programa			 ;
pantalla    .equ 0xFF00			;salida por pantalla			 ;
inicio_pila .equ 0x8000			;inicio de la pila U para la lista	 ;
;================================================================================|




;================================================================================|    
;				VARIABLES					 |  <------------------------	
;================================================================================|    
numero_nodos: 	   .byte 0		;numero total de nodos de la lista    	 ;					
temp:              .word 0		;variable auxiliar			 ;
codigo_eliminar:   .byte 0 		;codigo devuelto por eliminar nodo	 ;
semilla:           .word 0		;semilla para generar numeros aleatorios ;
										 ;
;------------------------------  CADENAS  ---------------------------------------;									
cadena_final: 		.asciz "\n\t    FIN DEL PROGRAMA"			 ;
linea: 			.asciz "\n|======================================|"	 ;	
;================================================================================|
	



;================================================================================|
;			   FUNCIONES GLOBALES					 |  <------------------------	
;================================================================================|												
	.globl programa								 ;		
	.globl imprime_cadena							 ;				
 	.globl leer_decimal							 ;					
  	.globl ver_decimal							 ;																		
 	.globl srand			 					 ;
	.globl rand								 ;
	.globl Menu_principal							 ;
	.globl Imprimir_lista							 ;
	.globl Crear_lista							 ;
	.globl Eliminar_nodo							 ;
	.globl Insertar_nodo							 ;
;================================================================================|




;================================================================================|   /
;			   PROGRAMA PRINCIPAL					 |  <---------------------------------
;================================================================================|   \ 
programa:									 ;
	ldu #inicio_pila							 ;
;--------------------------------  MENU  ----------------------------------------;
	jsr Menu_principal							 ;
										 ;								
;-------------------------- CREAR Y ORDENAR LISTA -------------------------------;	
	jsr Crear_lista								 ;		
 	stb numero_nodos							 ;
	sty semilla								 ;
										 ;
;---------------------------- IMPRIMIR LA LISTA ---------------------------------;								
imprimir_la_lista:								 ;
	stx temp			; guardo la cabeza en una var temporal	 ;
	jsr Imprimir_lista							 ;
										 ;													
;------------------------------ ELIMINAR NODO -----------------------------------;	
	ldx temp			;preparamos en X la cabeza y en B	 ;
	ldb numero_nodos		;  el numero de nodos para llamar a la	 ;
	jsr Eliminar_nodo		;  "funcion" eliminar nodo		 ;
										 ;
	sta codigo_eliminar							 ;
	stx temp		  	;guardo la posible nueva cabeza y el     ;
	stb numero_nodos 		; nuevo numero de nodos tras eliminar 	 ;
								 		 ;
	jsr Imprimir_lista							 ;
	cmpd #-1								 ;
	lbeq Final_programa							 ;
										 ;				
;------------------------------ INSERTAR NODO -----------------------------------;
	ldx temp			;Cargo en x la cabeza y en b el numero   ;
	ldb numero_nodos		; de nodos (aunque no haría falta)       ;
	lda codigo_eliminar							 ;
	ldy semilla								 ;
	jsr Insertar_nodo		; "funcion" insertar nodo		 ;	
										 ;		
	stx temp		  	;guardo la posible nueva cabeza y el     ;
	stb numero_nodos 		; nuevo numero de nodos tras insertar 	 ;		
										 ;
	cmpa #-3								 ;
	bne imprimir_la_lista							 ;
;================================================================================|



											
;================================================================================|
;			      FIN DEL PROGRAMA					 |  	
;================================================================================|	
Final_programa:									 ;
		lda #'\n							 
		sta pantalla							 ;
	ldx #linea								 ;
	jsr imprime_cadena							 ;			
	ldx #cadena_final							 ;									
	jsr imprime_cadena							 ;	
	ldx #linea								 ;
	jsr imprime_cadena							 ;
		lda #'\n							 
		sta pantalla							 ;	 
		sta pantalla							 ;
	clra									 ;		
	sta fin									 ;	
;================================================================================|	
	.area FIJA (ABS)
	.org 0xFFFE
	.word programa

