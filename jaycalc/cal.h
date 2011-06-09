/************************ cal.h **********************/
#define IDMAX 1024

enum enumTag  { enumNUM, enumVAR, enumOPR };
struct numTag { int num; };                    /*�`��*/
//struct varTag { int var; };                    /*�ܼ�*/
struct varTag { char name[36]; };                    /*�ܼ�*/
struct oprTag                            /*�B��l�`�I*/
{
  int oper;                              /*�B��l�s��*/
  struct nodeTag *op[2];          /*�B�⤸�`�I(�̦h2)*/
};
struct nodeTag                                 /*�`�I*/
{
  enum enumTag type;               /*�`�I���A��ƽs��*/
  union
  {
    struct numTag num;                         /*�`��*/
    struct varTag var;                         /*�ܼ�*/
    struct oprTag opr;                       /*�B��l*/
  };
};

#define IDMAX 1024
struct idnodeTag                           /*�ܼƸ`�I*/
{
	int  sym;                                /*��ƽs��*/
	char name[36];                           /*�ܼƦW��*/
	int  value;                                /*�ܼƭ�*/
} *idnode[IDMAX];

int idnodeTop;                         /*�ܼư��|����*/
int putid(char const name[], int sym);         /*�[�J*/
int getid(char const name[]);                  /*���o*/
