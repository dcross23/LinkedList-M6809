	.module eliminar_nodo

;================================================================================|
;				CONSTANTES					 |  <------------------------	
;================================================================================|
pantalla    .equ 0xFF00			;salida por pantalla			 ;
teclado     .equ 0xFF02			;entrada de teclado			 ;
;================================================================================|




;================================================================================|    
;				VARIABLES					 |  <------------------------	
;================================================================================| 
numero_nodos: 	   .byte 0		;numero total de nodos de la lista    	 ;			
temp:              .word 0		;variable auxiliar			 ;
									  	 ;																
puntero_anterior:  .word 0		;puntero al nodo anterior		 ;
posicion_eliminar: .byte 0		;indice del nodo a eliminar		 ;
										 ;
										 ;
;------------------------------  CADENAS  ---------------------------------------;
peticion_eliminar:	.asciz "\n\n\nQuieres eliminar un nodo? [s/n]:"		 ;	
pedir_nodo_a_eliminar:  .asciz "\n\nIntroduzca pos del nodo a eliminar:" 	 ;												
error: 		  	.asciz "\n\tOpcion incorrecta\n"			 ;	
;================================================================================|



;================================================================================|
;			   FUNCIONES GLOBALES					 |  <------------------------	
;================================================================================|
	.globl Eliminar_nodo							 ;
	.globl imprime_cadena							 ;
	.globl leer_decimal							 ;
										 ;
;================================================================================|



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Eliminar_nodo                                                    ;
;     Elimina uno o varios nodos de la lista enlazada		   ;
;                                                                  ;
;   Entrada: B -> numero de nodos		                   ;
;	     X -> cabeza de la lista				   ;
;   Salida: A -> 0 si se ha eliminado el nodo			   ;
; 		-1 si no se quiere eliminar más nodos	   	   ;
;  	    B -> nuevo numero de nodos				   ;
;   Registros afectados: D,X,Y,CC.                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Eliminar_nodo:
	stb numero_nodos
	stx temp
;--------------------------- ELIMINAR EL NODO -----------------------------------;
pedir_si_eliminar:								 ;
	ldx #peticion_eliminar		;preguntamos si queremos eliminar nodo	 ;
	jsr imprime_cadena							 ;											
	ldb teclado								 ;							
	cmpb #'s																
	beq nodo_a_eliminar		;Si -> vamos a eliminarlo		 ;						
	cmpb #'S														
	beq nodo_a_eliminar							 ;						
										 ;									
	cmpb #'n								 						
	lbeq acabar_programa		;No -> devolvemos un -1			 ;						
	cmpb #'N								 		 					
	lbeq acabar_programa							 ;						
										 ;							
	ldx #error								 ;									
	jsr imprime_cadena							 ;						
	bra pedir_si_eliminar							 ;					
										 ;				
										 ;		
nodo_a_eliminar:								 ;
	ldx #pedir_nodo_a_eliminar	;preguntamos que nodo queremos eliminar	 ;		
	jsr imprime_cadena							 ;					
	jsr leer_decimal		;  	1 - numero_nodos	 	 ;							
	stb posicion_eliminar							 ;								
										 ;						
	cmpd #1									 ;					
	beq Eliminar_primero 		;pos==1 ->  eliminar el primero		 ;								
	blo error_posicion		;pos<1  -> no existe la posicion, error	 ;				
					;pos>1...				 ;		
	cmpb numero_nodos							 ;			
	bls Eliminar_medio_o_ultimo	;pos==num_nodos -> eliminar el ultimo	 ;		
					;pos<num_nodos  -> eliminar en el medio	 ;				
					;pos>num_nodos  -> no existe, error	 ;						
    error_posicion:								 ;			
	ldx #error								 ;			
	jsr imprime_cadena							 ;			
	bra nodo_a_eliminar							 ;		
										 ;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Eliminar_primero:								 ;					
	ldx temp			;cargo en X otra vez la cabeza (primero) ;					
	leax 2,x								 ;						
	ldx ,x				;primero = primero->sig			 ;							
										 ;							
	ldb numero_nodos 							 ;						
	decb				;Decremento en 1 el numero de nodos	 ;				
	stb numero_nodos							 ;	
										 ;
	lda #0									 ;
	bra acabar								 ;
										 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Eliminar_medio_o_ultimo:							 ;			
	ldx temp			;cargo en X otra vez la cabeza (primero) ;
	leay ,x				; Y(indice) = X(cabeza)			 ;				
	ldb #1				;uso B como "contador"			 ;										
										 ;								
    buscar_posicion_2:								 ;						
	cmpb posicion_eliminar  	;recorremos hasta llegar a la posicion	 ;						
	beq eliminar_nodo_pos		;  B==posicion, lo eliminamos		 ;			
										 ;						
	sty puntero_anterior		; anterior = indice			 ;				
	leay 2,y			; indice = indice->sig			 ;			
	ldy ,y									 ;							
										 ;							
	incb				;incremento el contador(1 posicion +)	 ;							
	bra buscar_posicion_2							 ;									
										 ;					
    eliminar_nodo_pos:								 ;						
	leay 2,y								 ;						
	ldd ,y				; uso D como temporal de indice->sig	 ;						
										 ;			
	ldy puntero_anterior 							 ;					
	leay 2,y			;Y = anterior->sig			 ;				
										 ;					
	std ,y    			;Y = D : anterior->sig = indice->sig	 ;					
					;Si indice es el ultimo, el siguiente 	 ;			
					;es NULL (vale para el medio y ultimo)	 ;			
										 ;	
	ldb numero_nodos 	 						 ;			
	decb				;Decremento en 1 el numero de nodos	 ;				
	stb numero_nodos							 ;	
										 ;	
	lda #0									 ;
	bra acabar								 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

acabar_programa:
	lda #-1			

acabar:
	rts




