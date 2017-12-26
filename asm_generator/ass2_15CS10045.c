#include "myl.h"
#include <stdio.h>
int printStr(char *str)
{
  int i=0,len;
  for (i=0;;i++)
    {
      if(str[i]=='\0')
	{
	  break;
	}
    }
  len = i+1;
  int ret;

  asm volatile (
		       "syscall;"
		       :"=a"(ret)
		       :"a"(1),"D"(1),"S"(str),"d"(len)
		);
  return ret;
}
int printInt(int n)
{
  int i=0,j=0,num_digs,ret=-1;
  int minus;
  char tmp,zero='0';
  char digs[20];

  for(int pp=0;pp<20;pp++)
    digs[pp]='0';
  
  if(n==0)
    {
      digs[0]='0';
      i=1;
    }
  
  if(n<0)
    {
      minus=1;
      n=-n;
      digs[0]='-';
      i=1;
      j=1;
    }
  
  for(; n>0 ;i++)
    {
      digs[i]=(char)(n%10+zero);
      n/=10;
    }
  i--;
  num_digs=i+1;

  if(num_digs>11)
    {
      return ERR;
    }

  for(; j<i && i!=0 ;j++,i--)
    {
      tmp=digs[i];
      digs[i]=digs[j];
      digs[j]=tmp;
      
    }
  
  asm volatile ("syscall;"
		:"=a"(ret)
		:"a"(1),"D"(1),"S"(digs),"d"(num_digs));

  if(ret>=0)
    return (int) ret ;
  
  return ERR;

}
int readInt(int *n)
{
  //printf("hahah\n");
  char a[13],zero='0';
  int ret,i=0,tmp,len;
  //printf("afha");
  for(int i=0;i<13;i++)
    a[i]='0';
  
  asm volatile("syscall;"
	       :"=a"(ret)
	       :"a"(0),"d"(10),"S"(a),"D"(0));

  for(i=0;;i++)
    {
      if(a[i]=='\0'||a[i]=='\n')
	break;
    }
  len=i;
  i=0;
  if(a[0]=='-')
    {
      i=1;
    }
  //printf("ss1\n");
  *n=0;
  //printf("ss2\n");
  if(len-i>10)
    {
      return ERR;
    }
  
  for(;i<len;i++)
    {
      *n=10*(*n);
      tmp=(a[i]-zero);
      (*n)+=tmp;
    }
  
  if(a[0]=='-')
    (*n)=-(*n);

  //printf("end\n");

  return (*n);
  
}

int printFlt(float f)
{

  char digs[20],zero='0';
  int i=0,digit ,j=0,k=0, ret=0,end;
  
  int num_frac_dig=6;
  int int_part=(int) f/1;

  int int_abs,tmp;

  float f_abs,tmp_frac;
  for(int blah =0;blah <20;blah++)
    digs[blah]='\0';
  if(f<0)
    {
      int_abs = -int_part;
      f_abs = -f;
    }
  
  else
    {
      f_abs=f;
      int_abs=int_part;
      
    }
  
  
  
  
  float dec_part=f_abs-(float)(int_abs);


  if(f_abs==0.0)
    {
      digs[i++]='0';
      digs[i++]='.';
    }
  else
    {
      
      if(f<0)
	{
	  digs[0]='-';
	  i=1;
	  int_part=int_part*(-1);
	}
      
      
      if(int_part==0)
	{
	  digs[i++]='0';
	}

      while(int_part!=0)
	{
	  digit=int_part%10;
	  digs[i]=(char)(digit+zero);
	  int_part/=10;
	  i++;
	}

      end=i-1;
      
      
      if(digs[0]=='-')
	{
	  j=1;
	}

      
      for(;j<end;j++,end--)
	{
	  tmp=digs[j];
	  digs[j]=digs[end];
	  digs[end]=tmp;
	}

      digs[i]='.';
      i++;
    }
  
  if(dec_part==0)
    {
      int tt;
      for(tt=0;tt<6;tt++,i++)
	digs[i]='0';
      //i+=6;

    }
  else
    {
      tmp_frac=dec_part;
      
      for(k=0;k<num_frac_dig;k++)
	{
	  tmp_frac=tmp_frac*10;
	  tmp=((int) tmp_frac)%10;
	  digs[i]=(char)(zero+tmp);
	  i++;
	}
      
    }

  digs[i]='\n'; //adding a newline at last for decorational purposes
    
  asm volatile(
	       "syscall;"
	       :"=a"(ret)
	       :"a"(1) ,"S"(digs),"d"(i),"D"(1)
	       );

  if(ret>=0)
    return ret;
  return ERR;

}

int readFlt(double* f)
{

  char int_part[12];
  char num[20],zero='0';

  int i=0,j=0,k=0,ret,ll,tmp=0,abs;
  int digit =0,f_length=0;
  int power = 1;
  int i_part = 0;
  float f_part,f_final;
  
  __asm__ volatile    (
	       "syscall;"
	       :"=a" (ret)
	       :"a"(0), "D"(0), "S"(num), "d"(20)
	       );
  for(i=0;i<20;i++)
    {
      int_part[i]=num[i];

      if(num[i]=='.')
	{
	  break;
	}
      else if(num[i]=='\0' || num[i]=='\n')
	{
	  break;
	}
    }
  
  if (i>9 && num[i]!='-')
    return ERR;
  else if(i>10 && num[i]=='-')
    return ERR;


  j=0;
  ll=0;
  
  if(num[0]=='-')
    {
      ll=1;
    }

  j=i-1;
  power=1;
  
  for(;ll<=j;j--)
    {
      digit=(int)(int_part[j]-zero);
      tmp = tmp+(power*digit);
      power*=10;
    }


  i_part=tmp;

  
  tmp=0;
  
  if(int_part[0]=='-')
    i_part = i_part*(-1);

  abs=(i_part>0)?i_part:((-1)*i_part);
  if (abs>2147483647)
    return ERR;


  f_length=0;
  
  for(k=i+1; f_length<6 ;k++,f_length++)
    {
      if(num[k]<'0' || num[k] > '9')
	{
	  break ;
	}
    }
  
  k--;
  i++;
  
  for(ll=i,power=1;k>=ll && k<20 ; k-- )
    {
      digit=(int)(num[k]-zero);
      tmp=tmp+(power*digit);
      power=power*10;
    }

  
  f_part = tmp;
  f_part=((float)f_part/(float) power);
  f_final=f_part+((float)abs);

  if(int_part[0]=='-')
    f_final=-1*f_final;
  
  *f=(double)f_final;
  
  return OK;
}

