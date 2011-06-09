/************************* calc.c **********************/
#include <stdio.h>
#include "cal.h"
#include "cal.tab.h"
static int label;
FILE *out;
int debug;
char buf[1024];
int sym[128];
int ex(struct nodeTag *p)
{
  int label1, label2;
  if (p == NULL) return 0;
  switch(p->type)
  {
    case enumNUM:
      fprintf(out, "\tPUSH\t%d\n", p->num.num);
      break;
    case enumVAR:
      fprintf(out, "\tPUSH\tWORD [%s]\n",
                   p->var.name);
      //sym[p->var.var] = 1;
      break;
    case enumOPR:
      switch(p->opr.oper)
      {
        case PRINT:
          ex(p->opr.op[0]);
          sprintf(buf, "\tPOP\tWORD [_result]\n"
                       "\titostr\t_result,_intstr,'$'\n"
                       "\tMOV\tDX, _intstr\n"
                       "\tMOV\tAH, 09H\n"
                       "\tINT\t21H\n"
                       "\tnewline\n");
          fprintf(out, buf);
          break;
        case '=':
          ex(p->opr.op[1]);
          fprintf(out, "\tPOP\tWORD [%s]\n",
            p->opr.op[0]->var.name);
          break;
        case UMINUS:
          ex(p->opr.op[0]);
          fprintf(out, "\tPOP\tAX\n"
                       "\tNEG\tAX\n"
                       "\tPUSH\tAX\n");
          break;
        default:
          ex(p->opr.op[0]);
          ex(p->opr.op[1]);
          switch(p->opr.oper)
          {
            case '+':
              {
              fprintf(out, "\tPOP\tBX\n"
                           "\tPOP\tAX\n"
                           "\tADD\tAX, BX\n"
                           "\tPUSH\tAX\n");
              break;
              }
            case '-':
              {
              fprintf(out, "\tPOP\tBX\n"
                           "\tPOP\tAX\n"
                           "\tSUB\tAX, BX\n"
                           "\tPUSH\tAX\n");
              break;
              }
            case '*':
              {
              fprintf(out, "\tPOP\tBX\n"
                           "\tPOP\tAX\n"
                           "\tMUL\tBX\n"
                           "\tPUSH\tAX\n");
              break;
              }
            case '/':
              {
              fprintf(out, "\tPOP\tBX\n"
                           "\tPOP\tAX\n"
                           "\tMOV\tDX, 0\n"
                           "\tDIV\tBX\n"
                           "\tPUSH\tAX\n");
              break;
              }
          }
      }
  }
  return 0;
}
int main(int argc, char *argv[])
{
  int i;
  extern FILE *yyin;
#ifdef LINUXUSE
  char cmd[80]="cat ", filename[36];
#else
  char cmd[80]="TYPE ", filename[36];
#endif
  idnodeTop=0;
  yyin = fopen(argv[1], "r");
  printf("  file \"%s\" contents :\n", argv[1]);
  strcat(cmd, argv[1]);
  system(cmd);
  if (argc==3) debug=1;
  strcpy(filename, argv[1]);
  strcat(filename, ".asm");
  out = fopen(filename, "w");
  sprintf(buf, ";************** %s ****************\n"
    ";\n"
    "\tORG\t100H\n"
    "\tJMP\t_start\n"
    "_intstr\tDB\t'     ','$'\n"
    "_buf\tTIMES 256 DB ' '\n"
    "\tDB 13,10,'$'\n", filename);
  fprintf(out, buf);
  strcpy(buf, "%include\t\"dispstr.mac\"\n");
  strcat(buf, "%include\t\"itostr.mac\"\n");
  strcat(buf, "%include\t\"newline.mac\"\n");
  fputs(buf, out);
  fprintf(out, "_result\tDW\t0\n");
  fprintf(out, "_start:\n");
  yyparse();
  fprintf(out, "\tMOV\tAX, 4C00H\n"
               "\tINT\t21H\n");
  fprintf(out, ";\n;********* variables *********\n;\n");
  for (i=0; i<idnodeTop; i++)
  {
      fprintf(out, "%s\tDW\t0\n", idnode[i]->name);
  }
  fclose(out);
  return 0;
}
