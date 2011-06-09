;************** degree.5-3.asm ****************
;
	ORG	100H
	JMP	_start
_intstr	DB	'     ','$'
_buf	TIMES 256 DB ' '
	DB 13,10,'$'
%include	"dispstr.mac"
%include	"itostr.mac"
%include	"newline.mac"
_result	DW	0
_start:
	PUSH	30
	POP	WORD [Cdeg]
	PUSH	WORD [Cdeg]
	PUSH	9
	POP	BX
	POP	AX
	MUL	BX
	PUSH	AX
	PUSH	5
	POP	BX
	POP	AX
	MOV	DX, 0
	DIV	BX
	PUSH	AX
	PUSH	32
	POP	BX
	POP	AX
	ADD	AX, BX
	PUSH	AX
	POP	WORD [Fdeg]
	PUSH	WORD [Fdeg]
	POP	WORD [_result]
	itostr	_result,_intstr,'$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
;
;********* variables *********
;
Cdeg	DW	0
Fdeg	DW	0
