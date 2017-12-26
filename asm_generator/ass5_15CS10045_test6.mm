int printStr(char * a);
int printInt(int a);
int readInt(int * a);
int readFlt(float * a);
int printFlt(float a);
int main()
{
  Matrix a[3][6];
  int i=1;

  
  if(i<9)
    {
      a[0][3]=42.0;
    }
  else
    {
      a[0][5]=2.9;
    }


  printFlt(a[0][3]);
  return 0;
}
