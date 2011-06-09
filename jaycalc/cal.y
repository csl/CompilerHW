/************************** cal.y ***********************/
%{
   #include <stdio.h>
   #include <stdlib.h>
   #include <stdarg.h>
   #include "cal.h"
   struct nodeTag *opr(int oper, struct nodeTag *opn1,
                       struct nodeTag *opn2);
   struct nodeTag *var(char *name);
   struct nodeTag *num(int num);
   void freeNode(struct nodeTag *p);
   int ex(struct nodeTag *p);
   int yylex(void);
   void yyerror(char *s);
   extern int debug;
%}
%union
{
  int  numValue;
  char varName[36];
  struct nodeTag *nodePtr;
};
%token <numValue> NUM
//%token <varIndex> VAR
%token <varName> VAR                /*­×§ï¬°¦r¦ê*/
%token PRINT
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS
%type <nodePtr> stmt expr stmt_list
%%
program
  : function
  ;
function
  : function stmt     { ex($2); }
  | /*NULL*/
  ;
stmt
  : ';'               { $$ = opr(';', NULL, NULL); }
  | expr ';'          { $$ = $1; }
  | PRINT expr ';'    { $$ = opr(PRINT, $2, NULL); }
  | VAR '=' expr ';'  { $$ = opr('=', var($1), $3); }
  | '{' stmt_list '}' { $$ = $2; }
  ;
stmt_list
  : stmt              { $$ = $1; }
  | stmt_list stmt    { $$ = opr(';', $1, $2); }
  ;
expr
  : NUM                   { $$ = num($1); }
  | VAR                   { $$ = var($1); }
  | '-' expr %prec UMINUS { $$ = opr(UMINUS, $2, NULL); }
  | expr '+' expr         { $$ = opr('+', $1, $3); }
  | expr '-' expr         { $$ = opr('-', $1, $3); }
  | expr '*' expr         { $$ = opr('*', $1, $3); }
  | expr '/' expr         { $$ = opr('/', $1, $3); }
  | '(' expr ')'          { $$ = $2; }
  ;
%%
struct nodeTag *num(int val)
{
  struct nodeTag *p=malloc(sizeof(struct nodeTag));
  p->type = enumNUM;
  p->num.num = val;
  if (debug)
  {
    printf("num() enumNUM %d\n", p->num.num);
  }
  return p;
}
struct nodeTag *var(char *name)
{
  struct nodeTag *p=malloc(sizeof(struct nodeTag));
  p->type = enumVAR;
  //p->var.var = val;
  strcpy(p->var.name, name);
  if (debug)
  {
//    printf("var() enumVAR '%c'\n",(char)(p->var.var+'a'));
      printf("var() enumVAR '%s'\n",(p->var.name));
  }
  return p;
}
struct nodeTag *opr(int oper, struct nodeTag *opn1,
                    struct nodeTag *opn2)
{
  struct nodeTag *t, *p=malloc(sizeof(struct nodeTag));
  p->type = enumOPR;
  p->opr.oper = oper;
  p->opr.op[0] = opn1;
  p->opr.op[1] = opn2;
  if (debug)
  {
    if (p->opr.oper <= 127)
      printf("opr() enumOPR '%c'\n",(char)(p->opr.oper));
    else
      printf("opr() enumOPR %d\n", p->opr.oper);
  }
  return p;
}
void yyerror(char *s)
{
  fprintf(stdout, "%s\n", s);
}
