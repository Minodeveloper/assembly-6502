	processor 6502

	seg code
	org $F000	;Define the code origin at $F000

Start:
	sei		;Disable interrupts
	cld		;Disable the BCD decimal math mode
	ldx #$FF	;Loads the X register with #$FF
	txs		;Transfer the X register to the stack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;clear the Page Zero region ($00 to $FF)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	lda #0		;A = 0
	ldx #$FF	;X = #$FF

MemLoop:
	sta $0,X	;Store the value of A unside memory address $0 + X
	dex		;x--
	bne MemLoop	;Loop until x != 0 or z-flag is not set


	org $FFFC
	.word Start	;Reset vector at $FFFC wherethe program sarts
	.word Start	;Interrupt vector at $FFFE (unused in the VCS)
