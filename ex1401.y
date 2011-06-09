/********************* ex1401.y *******************/
%{
    #include <stdio.h>
    #include <ctype.h>
    #include <math.h>
    int yylex(void);
    void yyerror(char const *);
%}
%token CONSONANT
%token VOWEL
%token SEMI
//%type pattern
//%type pattern_part
//%type pattern_list
%%
pattern_list
  : pattern_list pattern_part
  | pattern_part
  ;
pattern_part
  : pattern SEMI  { printf ("syntax OK\n"); }
  ;
pattern
  : CONSONANT VOWEL CONSONANT
  ;
%%
void yyerror(char const *s)       /*���~�ɩI�s���禡*/
{
  fprintf(stderr, "%s\n", s);
}
int yylex (void)
{
  int ch;
  while ((ch=getchar())==' ' || ch=='\t' || ch=='\n')
    ;                                     /*�����ť�*/
  if (ch=='a' || ch=='e' || ch=='i' || ch=='o' || ch=='u' ||
      ch=='A' || ch=='E' || ch=='I' || ch=='O' || ch=='U')
  {
    return VOWEL;
  }
  else if (ch=='b' || ch=='c' || ch=='d' ||
           ch=='B' || ch=='C' || ch=='D')
  {
    return CONSONANT;
  }
  else if (ch==';')
  {
    return SEMI;
  }
  if (ch==EOF) return 0;
  return ch;
}
int main (int argc, char *argv[])
{
  printf("  ��J�����\"ex1401.txt\"���e�p�U�G\n");
#ifdef LINUXUSE
  system("cat ex1401.txt");
#else
  system("TYPE ex1401.txt");
#endif

  printf("  �z�Lbison��yyparse()�v�@��R�p�U�G\n");
  yyparse();
  return 0;
}
