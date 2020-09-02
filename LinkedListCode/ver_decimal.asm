	.module ver_decimal

;================================================================================|
;				CONSTANTES					 |  <------------------------	
;================================================================================|
pantalla    .equ 0xFF00			;salida por pantalla			 ;
;================================================================================|




;================================================================================|    
;				VARIABLES					 |  <------------------------	
;================================================================================| 
tempB: .byte 0				;variable temporal para B		 ;
tempD: .word 0				;variable temporal para D		 ;
tempnum: .word 0			;variable temporal para el numero	 ;
;================================================================================|



;================================================================================|
;			   FUNCIONES GLOBALES					 |  <------------------------	
;================================================================================|
	.globl ver_decimal							 ;
;================================================================================|



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ver_decimal                                                      ;
;     saca por pantalla el numero decimal de 16 bits	           ;
;                                                                  ;
;   Entrada: numero decimal de 16 bits (0-65535)                   ;
;   Salida:  ninguna                                               ;
;   Registros afectados: D,CC.                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ver_decimal:
;---------------------- VER DECIMAL -------------------------------;
  std tempnum							   ;
	;pongo a 0 las variables				   ;
	ldd #0							   ;
	std tempB						   ;
	std tempD						   ;
	clra							   ;
	clrb							   ;
;------------------------ 1a CIFRA --------------------------------;
		ldd tempnum					   ;
		cmpd #40000					   ;
		blo Menor40000					   ;
		subd #40000					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb					   	   ;
		stb tempB					   ;
								   ;
	Menor40000:						   ;
		ldb tempB					   ;
		lslb						   ;
		stb tempB					   ;
		ldd tempnum					   ;
		cmpd #20000					   ;
		blo Menor20000					   ;
		subd #20000					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb						   ;
		stb tempB					   ;	
			 					   ;
	Menor20000:						   ;
		ldb tempB					   ;
		lslb						   ;
		stb tempB					   ;
		ldd tempnum					   ;
		cmpd #10000					   ;
		blo Menor10000					   ;
		subd #10000					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb						   ;
		stb tempB					   ;
								   ;
	Menor10000:						   ;
		ldb tempB					   ;
		addb #'0	
		stb pantalla					   ;
		clrb						   ;
		stb tempB					   ;
								   ;
;------------------------ 2a CIFRA --------------------------------;
		ldd tempnum					   ;
		cmpd #8000					   ;
		blo Menor8000					   ;
		subd #8000					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb						   ;
		stb tempB					   ;
								   ;
	Menor8000:						   ;
		ldb tempB					   ;
		lslb						   ;
		stb tempB					   ;
		ldd tempnum					   ;
		cmpd #4000					   ;
		blo Menor4000					   ;
		subd #4000					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb						   ;
		stb tempB					   ;
								   ;
	Menor4000:						   ;
		ldb tempB					   ;
		lslb						   ;
		stb tempB					   ;
		ldd tempnum					   ;
		cmpd #2000					   ;
		blo Menor2000					   ;
		subd #2000					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb						   ;
		stb tempB					   ;	
								   ;
	Menor2000:						   ;
		ldb tempB					   ;
		lslb						   ;
		stb tempB					   ;
		ldd tempnum					   ;
		cmpd #1000					   ;
		blo Menor1000					   ;
		subd #1000					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb	   					   ;
		stb tempB					   ;
								   ;
	Menor1000:						   ;
		ldb tempB					   ;
		addb #'0
		stb pantalla					   ;
		clrb						   ;
		stb tempB					   ;
								   ;				
;------------------------ 3a CIFRA --------------------------------;
		ldd tempnum					   ;
		cmpd #800					   ;
		blo Menor800					   ;
		subd #800					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb 						   ;
		stb tempB					   ;
								   ;
	Menor800:						   ;
		ldb tempB					   ;
		lslb						   ;
		stb tempB					   ;
		ldd tempnum					   ;
		cmpd #400					   ;
		blo Menor400					   ;
		subd #400					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb						   ;
		stb tempB					   ;
								   ;
	Menor400:						   ;
		ldb tempB					   ;
		lslb						   ;
		stb tempB					   ;
		ldd tempnum					   ;
		cmpd #200					   ;
		blo Menor200					   ;
		subd #200					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb						   ;
		stb tempB					   ;	
								   ;
	Menor200:						   ;
		ldb tempB					   ;	
		lslb						   ;
		stb tempB					   ;
		ldd tempnum					   ;
		cmpd #100					   ;
		blo Menor100					   ;
		subd #100					   ;
		std tempnum					   ;
		ldb tempB					   ;
		incb						   ;
		stb tempB					   ;	
								   ;
	Menor100:						   ;
		ldb tempB					   ;
		addb #'0
		stb pantalla					   ;
								   ;
;------------------------ 4a CIFRA --------------------------------;
		ldd tempnum					   ;
		std tempD					   ;
		clra						   ;
		clrb						   ;
		lda tempD+1					   ;
								   ;
		cmpa #80					   ;
		blo Menor80					   ;
		incb						   ;
		suba #80					   ;
								   ;
	Menor80:lslb						   ;
		cmpa #40					   ;
		blo Menor40					   ;
		incb						   ;
		suba #40					   ;
								   ;
	Menor40:lslb						   ;
		cmpa #20					   ;
		blo Menor20					   ;
		incb						   ;
		suba #20					   ;
								   ;
	Menor20:lslb						   ;
		cmpa #10					   ;
		blo Menor10					   ;
		incb						   ;
		suba #10					   ;
								   ;
	Menor10:addb #'0
		stb pantalla					   ;
	       							   ;
;------------------------ 5a CIFRA --------------------------------;
		adda #'0	
		sta pantalla					   ;

	rts
