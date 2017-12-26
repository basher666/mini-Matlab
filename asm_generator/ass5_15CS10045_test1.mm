int printStr(char * a);
int printInt(int a);
int readInt(int * a);
int printFlt(double a);
int readFlt(double *a);

double aa=2.41;
int g_i = 5202;
void main()
{

    Matrix m[2][3]={1.3,2.3,3.3;4.3,5.3,6.3};

    double d=22.22;
    char * str = "\n an indirect string printing example \n";
    printStr(str);
    printStr("\n printing local double d = ");
    printFlt(d);
    printStr("\n printing global double aa = ");
    printFlt(aa);
    printStr("\n");
    printStr("\n printing global int g_i = ");
    printInt(g_i);
    printStr("\n printing local int ->");
    printInt(23);
    printStr("\n");


    int i=0,j=0;
    for(i=0;i<2;i++)
    {
        for(j=0;j<3;j++)
        {
            // if(i==1 && j==1 )
            // {
            //     printStr("\n lel \n ");
            // }
            printFlt(m[i][j]);
            printStr("\t");
        }
        printStr("\n");
    }
    printStr("i=");
    printInt(i);
    printStr("j=");
    printInt(j);


}