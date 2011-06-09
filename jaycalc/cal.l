/************************** cal.l ***********************/
%{
   #include <stdlib.h>
   #include "cal.h"
   #include "cal.tab.h"
   void yyerror(char *);
%}
%%
[0-9]+ {
         yylval.numValue = atoi(yytext);          /*常數*/
         return NUM;
       }
[-+()=/*;]      { return *yytext; }             /*單字元*/
"print"         return PRINT;
[A-Za-z]([A-Za-z]|[0-9])*  {
	  putid(yytext, VAR);
         strcpy(yylval.varName, yytext);     /*變數*/
         return VAR;
}
[ \t\n]+        ;                                 /*空白*/
.               yyerror("Unknown character");     /*錯誤*/
%%
int yywrap(void)
{
  return 1;                                 /*檔尾時結束*/
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
