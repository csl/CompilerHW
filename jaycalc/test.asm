;************** test.asm ****************
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
	PUSH	5
	PUSH	4
	POP	BX
	POP	AX
	ADD	AX, BX
	PUSH	AX
	POP	WORD [f]
	PUSH	WORD [f]
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
f	DW	0
