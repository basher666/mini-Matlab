int printStr(char * a);
int printInt(int a);
int readInt(int * a);
int readFlt(float * a);
int printFlt(float a);

int main () 
{
  double d=55.21;

  Matrix m1[2][3]={1.3,2.3,3.3;4.3,5.3,6.3};
  Matrix m2[3][4]={1.4,52.2,25.25,235.234;1.4,52.2,25.25,235.234;1.4,52.2,25.25,235.234};
  Matrix m3[2][4];

  m3 = m1*m2;
  int i,j;
  printStr("matrix 1 \n");
  for(i=0;i<2;i++)
  {
    for(j=0;j<3;j++)
    {
      printFlt(m1[i][j]);
      printStr("\t");
    }
    printStr("\n");
  }

  printStr("matrix 2 \n");
  for(i=0;i<3;i++)
  {
    for(j=0;j<4;j++)
    {
      printFlt(m2[i][j]);
      printStr("\t");
    }
    printStr("\n");
  }

  printStr(" matrix m3 after multiplying m3= m1*m2 \n");
  
  for(i=0;i<2;i++)
  {
    for(j=0;j<4;j++)
    {
      printFlt(m3[i][j]);
      printStr("\t");
    }
    printStr("\n");
  }
}