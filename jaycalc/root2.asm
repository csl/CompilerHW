;************** root2.asm ****************
;
	ORG	100H
	JMP	_start
_intstr	DB	'     ','$'
_buf	TIMES 256 DB ' '
	DB 13,10,'$'
%include	"dispstr.mac"
%include	"itostr.mac"
%include	"newline.mac"
a	DW	0
b	DW	0
c	DW	0
d	DW	0
e	DW	0
f	DW	0
g	DW	0
h	DW	0
i	DW	0
j	DW	0
k	DW	0
l	DW	0
m	DW	0
n	DW	0
o	DW	0
p	DW	0
q	DW	0
r	DW	0
s	DW	0
t	DW	0
u	DW	0
v	DW	0
w	DW	0
x	DW	0
y	DW	0
z	DW	0
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
	SUB	AX, BX
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
