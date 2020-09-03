	.module menu_principal

;================================================================================|
;				CONSTANTES					 |  <------------------------	
;================================================================================|
;================================================================================|




;================================================================================|    
;				VARIABLES					 |  <------------------------	
;================================================================================| 
										 ; 				
;--------------------------------  MENU  ----------------------------------------;	
menu0: 			.asciz "\n|======================================|"	 ;
menu1:			.asciz "\n|    		    LINKED LIST    		 	 |"	 ;
menu2:			.asciz "\n|          David Cruz Garcia           |"	 ;
menu3: 			.asciz "\n| 1)Genera un lista de num aleatorios  |"	 ;
menu4: 			.asciz "\n| 2)Ordena la lista                    |"	 ;
menu5: 			.asciz "\n| 3)Borra un nodo de la lista          |"	 ;
menu6: 			.asciz "\n| 4)Insertar un nodo en la lista       |"	 ;
										 ;
;================================================================================|



;================================================================================|
;			   FUNCIONES GLOBALES					 |  <------------------------	
;================================================================================|												
	.globl Menu_principal							 ;
	.globl imprime_cadena							 ;
										 ;
;================================================================================|



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; menu_principal                                                   ;
;     presenta por pantalla el menu principal del programa	   ;
;                                                                  ;
;   Entrada: ninguna				                   ;
;   Salida: ninguna			                           ;
;   Registros afectados: X,CC.                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu_principal:
;--------------------------------  MENU  ----------------------------------------;
	ldx #menu0								 ;
	jsr imprime_cadena							 ;	
	ldx #menu1								 ;			
	jsr imprime_cadena							 ;								
	ldx #menu0								 ;																		
	jsr imprime_cadena							 ;						
										 ;			
	ldx #menu2								 ;								
	jsr imprime_cadena							 ;		
	ldx #menu0								 ;					
	jsr imprime_cadena							 ;					
										 ;			
	ldx #menu3								 ;						
	jsr imprime_cadena							 ;					
	ldx #menu4								 ;						
	jsr imprime_cadena							 ;							
	ldx #menu5								 ;								
	jsr imprime_cadena							 ;
	ldx #menu6								 ;								
	jsr imprime_cadena							 ;								
	ldx #menu0								 ;															
	jsr imprime_cadena							 ;							
;--------------------------------------------------------------------------------;
	rts
