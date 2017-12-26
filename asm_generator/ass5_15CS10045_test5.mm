int printStr(char *a);
int printInt(int a);
int readInt(int * a);
int readFlt(float * a);
int printFlt(float a);

int main() 
{
  Matrix m1[2][3]={1.3,2.3,3.3;4.3,5.3,6.3};
  Matrix m2[2][3]={42.3,22.3,5.3;2221.3,5.3,0.3};
  Matrix m_add[2][3];
  Matrix m_sub[2][3];
  
  Matrix m_trans[3][2];

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
  for(i=0;i<2;i++)
  {
    for(j=0;j<3;j++)
    {
      printFlt(m2[i][j]);
      printStr("\t");
    }
    printStr("\n");
  }

  m_add=m1+m2;

  printStr("matrix m_add = m1+m2 \n");

  for(i=0;i<2;i++)
  {
    for(j=0;j<3;j++)
    {
      printFlt(m_add[i][j]);
      printStr("\t");
    }
    printStr("\n");
  }

  m_sub=m1-m2;

  printStr("matrix m_sub = m1-m2 \n");

  for(i=0;i<2;i++)
  {
    for(j=0;j<3;j++)
    {
      printFlt(m_sub[i][j]);
      printStr("\t");
    }
    printStr("\n");
  }

  m_trans=m1.';

  printStr("matrix m_trans = m1 .' \n");

  for(i=0;i<3;i++)
  {
    for(j=0;j<2;j++)
    {
      printFlt(m_trans[i][j]);
      printStr("\t");
    }
    printStr("\n");
  }

  return 0;
}