	.module insertar_nodo

;================================================================================|
;				CONSTANTES					 |  <------------------------	
;================================================================================|
pantalla    .equ 0xFF00			;salida por pantalla			 ;
teclado     .equ 0xFF02			;entrada de teclado			 ;
;================================================================================|




;================================================================================|    
;				VARIABLES					 |  <------------------------	
;================================================================================| 
cabeza_lista: 	   .word 0		;valor de la cabeza de la lista		 ;
numero_nodos: 	   .byte 0		;numero total de nodos de la lista    	 ;			
x_aux:             .word 0		;variable auxiliar			 ;
temp:              .word 0		;variable auxiliar			 ;
codigo_eliminar:   .byte 0 		;codigo devuelto por Eliminar_nodo	 ;
									  	 ;																
puntero_anterior:  .word 0		;puntero al nodo anterior		 ;
										 ;
semilla:           .word 0		;semilla para generar numeros aleatorios ;
numero_generado:   .word 0		;numero generado en cada interaccion	 ;
										 ;
;------------------------------  CADENAS  ---------------------------------------;
peticion_insertar:	.asciz "\n\n\nQuieres insertar un nodo? [s/n]:"		 ;	
error: 		  	.asciz "\n\tOpcion incorrecta\n"			 ;	
max_num_nodos_alcanz: 	.asciz "\n\tYa hay 255 nodos(no se pueden insertar mas)\n";
;================================================================================|



;================================================================================|
;			   FUNCIONES GLOBALES					 |  <------------------------	
;================================================================================|
	.globl Insertar_nodo							 ;
	.globl imprime_cadena							 ;
	.globl leer_decimal							 ;
	.globl rand								 ;
										 ;
;================================================================================|



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Insertar_nodo                                                        ;
;     Inserta un nodo en la lista enlazada		   	       ;
;                                                                      ;
;   Entrada: A ->codigo devuelto por Eliminar_nodo para saber si       ;
;		  acabar el programa o no			       ; 
;	     B -> numero de nodos		                       ;
;	     X -> cabeza de la lista				       ;
;   Salida: A -> 0 si se ha insertado el nodo			       ;
; 		-1 si no se quiere insertar otro nodo	   	       ;
;		-2 si no se pueden insertar mas nodos (lista llena)    ;
;		-3 si eliminar devolvió -1 y quiero acabar el programa ;
;  	    B -> nuevo numero de nodos				       ;
;   Registros afectados: D,X,Y,CC.                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Insertar_nodo:
	sta codigo_eliminar
	stb numero_nodos
	sty semilla	
	stx x_aux
	ldd ,x
	std cabeza_lista 
;--------------------------- INSERTAR EL NODO -----------------------------------;
pedir_si_insertar:								 ;
	ldx #peticion_insertar		;preguntamos si queremos insertar nodo	 ;
	jsr imprime_cadena							 ;											
	ldb teclado								 ;							
	cmpb #'s																
	lbeq nodo_a_insertar		;Si -> vamos a eliminarlo		 ;						
	cmpb #'S														
	lbeq nodo_a_insertar							 ;						
										 ;									
	cmpb #'n								 						
	lbeq devolver_codigo		;No -> devolvemos un -1 (o -3 para acabar);					
	cmpb #'N								 		 					
	lbeq devolver_codigo							 ;						
										 ;							
	ldx #error								 ;									
	jsr imprime_cadena							 ;						
	bra pedir_si_insertar							 ;					
										 ;				
										 ;		
nodo_a_insertar:								 ;
	ldb numero_nodos		;Si el numero de nodos ya es 255, no se  ;
	cmpb #255			; pueden insertar más nodos		 ;
	lbeq max_nodos_alcanzado							 ;

	ldd #0				;meto 0 (su siguiente) en la pila	 ;
	pshu d									 ;
	ldd semilla			;cargo la semilla y genero el sig numero ;
	jsr rand								 ;
	std numero_generado		;lo guardo como num actual y lo meto	 ;
	pshu d				;meto el numero en la pila		 ;
		
	ldd numero_generado 		;cargo el numero generado		 ;				
  	cmpd cabeza_lista     		;comparo el numero con la cabeza 	 ; 								
       	bhi Insertar_primero		;si es mayor, lo asigno como cabeza	 ;						
	
	;si es menor, recorro la lista buscando su posicion			 ;
	   ldx x_aux								 ;						
	   leay ,x 			; y (actual)  =  x(cabeza)		 ;					
    buscar_pos:							 	 ;					
					;avanzo una posicion en la lista	 ;   						
	  sty puntero_anterior 		;anterior = actual			 ;		
	  leay 2,y	     		;actual = actual->sig			 ;			
	  ldy ,y								 ;			
	 								 	 ;				
	  cmpy #0 			;¿y (actual) == 0(NULL)?		 ;		
	  lbeq Insertar_final	;si es NULL, insertamos por el final	 ;			
	  				;si no es NULL, seguimos recorriendo 	 ;			
										 ;								
	  ldd ,y			 	          			 ;								
	  cmpd numero_generado 		; ¿y(actual) > numero_generado(nuevo)?	 ;						
	  bhi buscar_pos		; SI -> seguimos recorriendo		 ;		
 					; NO -> habra que insertar en medio	 ;			
					;         porque no es ni 1o ni ultimo	 ;			
										 ;		
										 ;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     Insertar_medio:								 ;
	    sty temp								 ;
	    ldy puntero_anterior	;anterior->sig = nuevo			 ;
	    stu 2,y 								 ;	
										 ;
	    ldy temp								 ;
	    sty 2,u 			;nuevo->sig = actual			 ;
	    lda #0								 ;
 	     ldb numero_nodos							 ;							
	     incb 								 ;
	     stb numero_nodos 							 ;
	    bra acabar								 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	   
     Insertar_primero:							 	 ;
	    ldx x_aux
	    std cabeza_lista 		;cabeza_lista = numero actual		 ; 
	    stx 2,u			;nuevo->sig = x (cabeza)		 ; 
	    leax ,u 			;x (cabeza) = nuevo			 ;
	    stx x_aux
	    lda #0								 ;
 	     ldb numero_nodos							 ;							
	     incb 								 ;
	     stb numero_nodos 							 ;
	    bra acabar						 		 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     Insertar_final:								 ;
    	    ldy puntero_anterior	;anterior->sig = nuevo			 ;
	    stu 2,y								 ; 
	    lda #0								 ;
	     ldb numero_nodos							 ;							
	     incb 								 ;
	     stb numero_nodos 							 ;
	    bra acabar						 		 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

max_nodos_alcanzado:
	ldx #max_num_nodos_alcanz
	jsr imprime_cadena
	lda #-2
	bra acabar

acabar_programa:
	lda #-3
	bra acabar

devolver_codigo:
	lda #-1	
	ldb codigo_eliminar
	cmpb #-1
	beq acabar_programa		

acabar:
	ldx x_aux
	ldb numero_nodos
	rts


