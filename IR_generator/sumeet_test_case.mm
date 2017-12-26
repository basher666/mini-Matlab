// Each brace introduces a new scope
void scope_ex0() 
{
  
  int i=1;
  i=i<<1;
}

// Scopes : same identifier in different scopes do not collide
int scope_ex1(int x){
  for( ; x == 0 ; ) {
    int v = 2 + 3;

    if( v == 5 ) {
      int alpha = 1;
      x = 1;
    } else {
      int alpha = 2;
      x = 1;
    }
  }
  return x*x;
}

// Temporaries are only generated when absolutely necessary.
void gen_temp(){
  int u = (2*3+4*5)/(2*3+7);
  int v = 4;
  int w = u * v;
  v=scope_ex1(w);
  // TODO : insert matrix temporary example here.  
}

void static_matrix_decl() {
  int u = 4; // initialized
  Matrix m[u][u]; // non-static
  Matrix n[3][3]; // static
  int v = u; // not initialized
} // A clear distinction is made between constant expressions and initialized declarators.

void reason_for_above() {
  int u = 4;
  int *p = &u; //--(*p);
  Matrix m[u][u]; // observe initial value of u.
  Matrix n[3][3];
  double *ptr = &(n[u-1][u-1]);
  ptr = &(m[2][2]);
} // Initial values of user defined names do not change after declaration, not even statically.

// Only increment / decrement operators change the value of pointers.
void pointer_arithmetic(){
  int *p;
  p+2;
  p-3;
  // 3-p; // try this in gcc as well
  int i;
  p = &i;
  //p++;
  int j = *(--p);
  int r = 0;
  if( i == j ) {
    r = 1;
  }
  int **p2;
  *p2 = &r;
  p2 = &p;
  if ( (**p2) == j ) {
    r = 2;
  }
  r + p; r + *p2; r+**p2;
  *p2 = &j;
}
