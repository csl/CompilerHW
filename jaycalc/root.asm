;************** root.asm ****************
;
	ORG	100H
	JMP	_start
_intstr	DB	'     ','$'
_buf	TIMES 256 DB ' '
	DB 13,10,'$'
%include	"dispstr.mac"
%include	"itostr.mac"
%include	"newline.mac"
result	DW	0
_start:
	PUSH	1
	POP	WORD [a]
	PUSH	7
	POP	AX
	NEG	AX
	PUSH	AX
	POP	WORD [b]
	PUSH	10
	POP	WORD [c]
	PUSH	WORD [b]
	PUSH	WORD [b]
	POP	BX
	POP	AX
	MUL	BX
	PUSH	AX
	PUSH	4
	PUSH	WORD [a]
	POP	BX
	POP	AX
	MUL	BX
	PUSH	AX
	PUSH	WORD [c]
	POP	BX
	POP	AX
	MUL	BX
	PUSH	AX
	POP	BX
	POP	AX
	SUB	AX, BX
	PUSH	AX
	POP	WORD [d]
	PUSH	WORD [d]
	POP	WORD [result]
	itostr	result, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	PUSH	WORD [b]
	POP	AX
	NEG	AX
	PUSH	AX
	PUSH	3
	POP	BX
	POP	AX
	ADD	AX, BX
	PUSH	AX
	PUSH	2
	POP	BX
	POP	AX
	MOV	DX, 0
	DIV	BX
	PUSH	AX
	POP	WORD [x]
	PUSH	WORD [x]
	POP	WORD [result]
	itostr	result, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
;
;********* variables *********
;
a	DW	0
b	DW	0
c	DW	0
d	DW	0
x	DW	0
