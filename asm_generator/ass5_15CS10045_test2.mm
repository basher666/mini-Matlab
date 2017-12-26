
int printStr(char * a);
int printInt(int a);
int readInt(int * a);
int readFlt(float * a);
int printFlt(float a);

int a;
int b = 1;
char c;
char d = 'a';

int main () 
{
  Matrix mat[2][2];
  int i,j;
  printStr("enter the 2*2 matrix elements \n");
  double d;
  for(i=0;i<2;i++)
  {
    for(j=0;j<2;j++)
    {
      readFlt(&d);
      mat[i][j]=d;
    }
  }
  printStr("\n printing the entered matrix \n");
  for(i=0;i<2;i++)
  {
    for(j=0;j<2;j++)
    {
      printFlt(mat[i][j]);
      printStr("\t");
    }
    printStr("\n");
  }
  
  return 0;
}