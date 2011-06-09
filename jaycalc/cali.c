/*********************** cali.c *********************/
#include <stdio.h>
#include "cal.h"
#include "cal.tab.h"
int debug;
int sym[128];
int ex(struct nodeTag *p)
{
  int index;

  if (p==NULL) return 0;
  switch(p->type)
  {
    case enumNUM: return p->num.num;
    case enumVAR: 
      index=getid(p->var.name);       /*變數名稱節點*/
      return idnode[index]->value;      /*傳回變數值*/
      //return sym[p->var.var];
    case enumOPR:
      switch(p->opr.oper)
      {
        case PRINT:
          printf("%d\n", ex(p->opr.op[0]));
          return 0;
        case ';':
          ex(p->opr.op[0]);
          return ex(p->opr.op[1]);
        case '=':
          index=getid(p->opr.op[0]->var.name); /*變數節點*/
          return idnode[index]->value=ex(p->opr.op[1]);

          //return sym[p->opr.op[0]->var.var] =
            //     ex(p->opr.op[1]);
        case UMINUS:
          return -ex(p->opr.op[0]);
        case '+':
          return ex(p->opr.op[0]) + ex(p->opr.op[1]);
        case '-':
          return ex(p->opr.op[0]) - ex(p->opr.op[1]);
        case '*':
          return ex(p->opr.op[0]) * ex(p->opr.op[1]);
        case '/':
          return ex(p->opr.op[0]) / ex(p->opr.op[1]);
      }
  }
  return 0;
}
int main(int argc, char *argv[])
{
  extern FILE *yyin;
#ifdef LINUXUSE
  char cmd[80]="cat ";
#else
  char cmd[80]="TYPE ";
#endif
  idnodeTop=0;
  printf("  file \"%s\" contents :\n", argv[1]);
  strcat(cmd, argv[1]);
  system(cmd);
  if (argc==3) debug=1;
  yyin=fopen(argv[1], "r");
  printf("  after yyparse(), print as followings:\n");
  yyparse();
  return 0;
}
