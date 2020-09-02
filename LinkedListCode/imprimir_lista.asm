	.module Imprimir_lista

;================================================================================|
;				CONSTANTES					 |  <------------------------	
;================================================================================|
pantalla    .equ 0xFF00			;salida por pantalla			 ;
;================================================================================|




;================================================================================|    
;				VARIABLES					 |  <------------------------	
;================================================================================| 
										 ;
;------------------------------  CADENAS  ---------------------------------------;	
lista_ordenada: 	.asciz "\n|----------- LISTA ORDENADA -----------|\n\t\t";							
lista_vacia   : 	.asciz "La lista esta vacia\n\n\n"			 ; 
;================================================================================|




;================================================================================|
;			   FUNCIONES GLOBALES					 |  <------------------------	
;================================================================================|												
	.globl Imprimir_lista							 ;
	.globl imprime_cadena							 ;
	.globl ver_decimal							 ;
										 ;
;================================================================================|




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Imprimir_lista                                                   ;
;     imprime la lista enlazada 				   ;
;                                                                  ;
;   Entrada: X -> cabeza de la lista		                   ;
;   Salida: D -> 0: indica que se ha acabado de imprimir la lista  ;
;	   	-1: indica que la lista esta vacia		   ;
;   Registros afectados: D,X,Y,CC.                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Imprimir_lista:
;-------------------------- IMPRIMIR LA LISTA -----------------------------------;							
		lda #'\n							 									
		sta pantalla							 ;									
	    leay ,x			;Y(indice) = X(cabeza)			 ;																
    	    ldx #lista_ordenada							 ;						
	    jsr imprime_cadena							 ;							
	    cmpy #0			;¿Y(actual) == 0(NULL)? -> si lo es, no	 ;							
	    beq Lista_Vacia		;  hay cabeza, la lista esta vacia	 ;										
										 ;								
										 ;							
	Imprimir_Nodo:								 ;						
	    ldd ,y			;imprimo el contenido de y (numero)	 ;										
	    jsr ver_decimal							 ;						
	    leay 2,y  			;indice = indice->sig			 ;	
	    ldy ,y								 ;						
										 ;						
		lda #'\n							 				
		sta pantalla							 ;				
		lda #'\t     														
		sta pantalla							 ;					
		sta pantalla							 ;					
										 ;				
	    cmpy #0  	     		;¿indice == NULL?			 ;						
	    bne Imprimir_Nodo       	;SI -> ya acabamos de imprimir todo	 ;
	    ldd #0			; se ha imprimido la lista correctamente ;
	    bra acabar			;    por lo que devuelve 0		 ;				
										 ;					
      Lista_Vacia:								 ;					
	    ldx #lista_vacia							 ;						
	    jsr imprime_cadena							 ;
	    ldd #-1			;la lista esta vacia, devuelve -1	 ;					
;--------------------------------------------------------------------------------;
acabar:
	rts




