;************** degree.5-3.asm.asm ****************
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
	MOV	AX, 4C00H
	INT	21H
;
;********* variables *********
;
