	.module crear_lista

;================================================================================|
;				CONSTANTES					 |  <------------------------	
;================================================================================|
pantalla    .equ 0xFF00			;salida por pantalla			 ;
;================================================================================|




;================================================================================|    
;				VARIABLES					 |  <------------------------	
;================================================================================| 
numero_nodos: 	   .byte 0		;numero total de nodos de la lista    	 ;				 		
contador:          .byte 0		;contador para recorrer la lista	 ;		
semilla:           .word 0		;semilla para generar numeros aleatorios ;
										 ;
numero_generado:   .word 0		;numero generado en cada interaccion	 ;				
temp:              .word 0		;variable auxiliar			 ;
										 ;
cabeza_lista: 	   .word 0		;valor de la cabeza de la lista		 ;																	
puntero_anterior:  .word 0		;puntero al nodo anterior		 ;
										 ;
										 ;
;------------------------------  CADENAS  ---------------------------------------;
lista_generada: 	.asciz "\n|----------- LISTA GENERADA -----------|\n\t\t";	
pedir_num_nodos: 	.asciz "\n\n\nIntroduzca el num de nodos [0-255]:"	 ;												
error: 		  	.asciz "\n\tOpcion incorrecta\n"			 ;	
;================================================================================|



;================================================================================|
;			   FUNCIONES GLOBALES					 |  <------------------------	
;================================================================================|
	.globl Crear_lista							 ;
	.globl imprime_cadena							 ;
	.globl leer_decimal							 ;
	.globl ver_decimal							 ;
	.globl rand								 ;
	.globl srand								 ;
										 ;
;================================================================================|



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Crear_lista                                                      ;
;     Crea una lista de numeros y la ordena de mayor a menor	   ;
;                                                                  ;
;   Entrada: ninguna	  			                   ;
;   Salida: X -> puntero a la cabeza de la lista	   	   ;
;  	    B -> numero de nodos de la lista (0-255)		   ;
;	    Y -> semilla utilizada				   ;
;   Registros afectados: U,D,X,Y,CC.                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Crear_lista:
;-------------------- PEDIR NODOS Y GENERAR SEMILLA -----------------------------;
   pedir_numero_nodos:								 ;				
	    ldx #pedir_num_nodos	;pedimos el numero de nodos		 ;								
	    jsr imprime_cadena							 ;								
	    jsr leer_decimal							 ;										
	    cmpd #255								 ;								
	    bhi numero_erroneo  	;mayor que 255, error			 ;												
	    cmpd #0								 ;										
	    bhi generar_semilla 	;menor que 0, error
					; 1-255 -> generamos la semilla		 ;														
	    									 ;																		
	numero_erroneo:			;si >255 o <=0, vuelve a pedirlo 	 ;																	
	   ldx #error								 ;							
	   jsr imprime_cadena 							 ;											
	   bra pedir_numero_nodos    						 ;										
 										 ;
										 ;																							
   generar_semilla: 								 ;								
		lda #'\n     							 											
		sta pantalla							 ;
		clra								 ;												
										 ;						
	   stb numero_nodos		;el num introducido sirve como num nodos,;		
	   stb contador			;   contador y para generar la semilla	 ;			
	   jsr srand								 ;									
	   std semilla								 ;								
	   		 							 ;
										 ;
;----------------------- GENERAR Y MOSTRAR LISTA --------------------------------;																
	   ldx #lista_generada	  						 ;																		
	   jsr imprime_cadena					 		 ;														
										 ;														
   asignar_cabeza_lista:							 ;	
	   ldd #0			;meto el siguiente (0=NULL) en la pila 	 ;
	   pshu d								 ;								
	   ldd semilla			;cargo la semilla y genero el 1er numero ;							
	   jsr rand								 ;							
	   std numero_generado		;lo guardo como num actual y lo meto	 ;							
	   pshu d			;    en la pila				 ;						
	   jsr ver_decimal							 ;						
		lda #'\n     							 								
		sta pantalla							 ;							
		lda #'\t     																	
		sta pantalla							 ;							
		sta pantalla							 ;										
 										 ;
	 ;asigno el 1er numero como 1a cabeza de la lista			 ;
	   leax ,u 	     		;apunto a la cabeza con x (cabeza)	 ;							
	   ldd ,u								 ;						
 	   std cabeza_lista 		 ;guardo la cabeza en cabeza_lista	 ;								
										 ;						
										 ;				
   crear_siguiente_nodo:							 ;			
	     ldb contador 		;decremento contador de nodos  		 ;
	     decb								 ;							
	     stb contador							 ;							
	   cmpb #0	  		;si el contador es 0, hay que imprimir   ;			
	   beq acabar	   		;   al lista				 ;
										 ;				
	 ;si el contador de nodos no es 0, creamos el siguiente nodo	         ;
	   ldd #0			;meto el siguiente (0=NULL) en la pila 	 ;
	   pshu d								 ;
	   ldd semilla			;cargo la semilla y genero el sig numero ;
	   jsr rand								 ;
	   std numero_generado		;lo guardo como num actual y lo meto	 ;							
	   pshu d			;    en la pila				 ;
	   jsr ver_decimal							 ;						
		lda #'\n     							 								
		sta pantalla							 ;							
		lda #'\t     																	
		sta pantalla							 ;							
		sta pantalla							 ;

;-------------------------- ORDENAR LOS NODOS -----------------------------------;
	   ldd numero_generado 		;cargo el numero generado		 ;				
  	   cmpd cabeza_lista     	;comparo el numero con la cabeza 	 ; 								
       	   bhi Insertar_al_principio	;si es mayor, lo asigno como cabeza	 ;								
										 ;								
										 ;									
	   ;si es menor, recorro la lista buscando su posicion			 ;						
	   leay ,x 			; y (actual)  =  x(cabeza)		 ;					
    buscar_posicion:							 	 ;					
					;avanzo una posicion en la lista	 ;   						
	  sty puntero_anterior 		;anterior = actual			 ;		
	  leay 2,y	     		;actual = actual->sig			 ;			
	  ldy ,y								 ;			
	 								 	 ;				
	  cmpy #0 			;¿y (actual) == 0(NULL)?		 ;		
	  lbeq Insertar_al_final	;si es NULL, insertamos por el final	 ;			
	  				;si no es NULL, seguimos recorriendo 	 ;			
										 ;								
	  ldd ,y			 	          			 ;								
	  cmpd numero_generado 		; ¿y(actual) > numero_generado(nuevo)?	 ;						
	  bhi buscar_posicion		; SI -> seguimos recorriendo		 ;		
 					; NO -> habra que insertar en medio	 ;			
					;         porque no es ni 1o ni ultimo	 ;			
										 ;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     Insertar_en_medio:								 ;
	    sty temp								 ;
	    ldy puntero_anterior	;anterior->sig = nuevo			 ;
	    stu 2,y 								 ;	
										 ;
	    ldy temp								 ;
	    sty 2,u 			;nuevo->sig = actual			 ;
	    bra crear_siguiente_nodo						 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	   
     Insertar_al_principio:							 ;
	    std cabeza_lista 		;cabeza_lista = numero actual		 ; 
	    stx 2,u			;nuevo->sig = x (cabeza)		 ; 
	    leax ,u 			;x (cabeza) = nuevo			 ;
	    bra crear_siguiente_nodo						 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     Insertar_al_final:								 ;
    	    ldy puntero_anterior	;anterior->sig = nuevo			 ;
	    stu 2,y								 ; 
	    bra crear_siguiente_nodo						 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					

acabar:
	ldb numero_nodos
	ldy semilla
	rts




