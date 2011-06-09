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
void yyerror(char const *s)       /*錯誤時呼叫此函式*/
{
  fprintf(stderr, "%s\n", s);
}
int yylex (void)
{
  int ch;
  while ((ch=getchar())==' ' || ch=='\t' || ch=='\n')
    ;                                     /*忽略空白*/
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
  printf("  輸入資料檔\"ex1401.txt\"內容如下：\n");
#ifdef LINUXUSE
  system("cat ex1401.txt");
#else
  system("TYPE ex1401.txt");
#endif

  printf("  透過bison的yyparse()逐一剖析如下：\n");
  yyparse();
  return 0;
}
