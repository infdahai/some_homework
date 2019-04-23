#include <stdio.h>
#include <omp.h>

static long num_step = 100000;
double step ;
#define NUM_HEADS 2
int main(int argc, char *argv[])
{
  int i;
  double x , pi ,sum[NUM_HEADS];
  step = 1/(double)num_step;
  omp_set_num_threads(NUM_HEADS);
#pragma omp parallel private(i)
  {
    double x ;
    int id;
    id = omp_get_thread_num();
    for(i=id,sum[id]=0.0;i<num_step;i=i+NUM_HEADS)
      {
        x = (i+0.5)*step;
        sum[id] += 4.0/(1+x*x);
      }
  }
  for(i=0,pi = 0.0 ;i<NUM_HEADS;i++)
    pi +=sum[i]*step;
  printf("%f\n", pi);
  return 0;
}
