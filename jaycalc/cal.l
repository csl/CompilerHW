/************************** cal.l ***********************/
%{
   #include <stdlib.h>
   #include "cal.h"
   #include "cal.tab.h"
   void yyerror(char *);
%}
%%
[0-9]+ {
         yylval.numValue = atoi(yytext);          /*�`��*/
         return NUM;
       }
[-+()=/*;]      { return *yytext; }             /*��r��*/
"print"         return PRINT;
[A-Za-z]([A-Za-z]|[0-9])*  {
	  putid(yytext, VAR);
         strcpy(yylval.varName, yytext);     /*�ܼ�*/
         return VAR;
}
[ \t\n]+        ;                                 /*�ť�*/
.               yyerror("Unknown character");     /*���~*/
%%
int yywrap(void)
{
  return 1;                                 /*�ɧ��ɵ���*/
}

//record
int putid(char const name[], int sym)
{
   int i;
   struct idnodeTag *p;

   for (i=0; i<idnodeTop; i++)
   {                                                                         
       if (strcmp(idnode[i]->name, name) == 0)
         {
              idnode[i]->sym = sym;
              return i;
         }
    }

   //allocate memory
   p = malloc(sizeof(struct idnodeTag));
   strcpy(p->name, name);
   p->sym = sym;
   p->value = 0;
   idnode[idnodeTop++] = p;
   return idnodeTop-1;
}

//Query: name mapping to id
int getid(char const name[])
{
   int i;
   for (i=0; i<idnodeTop; i++)
    {
   	if (strcmp(idnode[i]->name,name) == 0)
         {
              return i;
          }
     }
    return -1;
 }