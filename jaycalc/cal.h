/************************ cal.h **********************/
#define IDMAX 1024

enum enumTag  { enumNUM, enumVAR, enumOPR };
struct numTag { int num; };                    /*常數*/
//struct varTag { int var; };                    /*變數*/
struct varTag { char name[36]; };                    /*變數*/
struct oprTag                            /*運算子節點*/
{
  int oper;                              /*運算子編號*/
  struct nodeTag *op[2];          /*運算元節點(最多2)*/
};
struct nodeTag                                 /*節點*/
{
  enum enumTag type;               /*節點型態整數編號*/
  union
  {
    struct numTag num;                         /*常數*/
    struct varTag var;                         /*變數*/
    struct oprTag opr;                       /*運算子*/
  };
};

#define IDMAX 1024
struct idnodeTag                           /*變數節點*/
{
	int  sym;                                /*整數編號*/
	char name[36];                           /*變數名稱*/
	int  value;                                /*變數值*/
} *idnode[IDMAX];

int idnodeTop;                         /*變數堆疊頂端*/
int putid(char const name[], int sym);         /*加入*/
int getid(char const name[]);                  /*取得*/
