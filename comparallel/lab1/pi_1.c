
#include <stdio.h>
static long num_step = 100000;
double step ;
int main()
{
  int i;
  double x , pi,sum = 0.0;
  step = 1.0/(double)num_step;
  for(i = 1 ;i<= num_step;i++)
    {
      x= (i-0.5)*step;
   //   if(i<10)
     //   printf("x:%f\n",x);
      sum += 4.0/(1.0+x*x);
    }
  pi = step * sum;
  printf("%f\n",pi);
  return 0;
}
