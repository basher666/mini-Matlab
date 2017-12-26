int die(int x)
{
//some gotos are redundant and/or buggy
  for( ; x == 0 ; ) 
  {
    int v = 2 + 3;
    v=x>32?32:12;

  }
  while(x!=3)
  {
    if(x>3)
    {
      x--;
    }
    else
    {
      x++;
    }
    x++;
  }
  do x--; while(x!=0);

  return x*x;
}