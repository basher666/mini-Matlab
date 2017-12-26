int printStr(char * a);
int printInt(int a);
int readInt(int * a);
int readFlt(float * a);
int printFlt(float a);

int fib(int a)
{
  printStr("Entered the fib function\n");
  int f=1,f_1=0;
  int i=1,temp;
  while(i<a) 
  {
    temp=f;
    f=f+f_1;
    f_1=temp;
    i=i+1;
  }
  printStr("\nThe fibonacci number is : ");
  printInt(f);
  return f;
}

int main () 
{
  printStr("enter the i for finding its fibonacci number : ");
  int i;
  readInt(&i);
  printStr("\nYou Entered : ");
  printInt(i);

  printStr("\nNow, entering the function to calculate fibonacci numbers for i entered\n");
  int j;
  j=fib(i);
  printStr("\n\nReturned from the fib function\n\n");
  printStr("value returned is = ");
  printInt(j);
  return 1;
}