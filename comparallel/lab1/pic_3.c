#include <stdio.h>
#include <omp.h>
static long num_steps = 100000;
double step;
#define NUM_THREADS 2
void main ()
{ 
	int i;
	double pi=0.0;
	double sum=0.0;
	double x=0.0;
	step = 1.0/(double) num_steps;
	omp_set_num_threads(NUM_THREADS);  //设置2线程
#pragma omp parallel private(x,sum,i) //该子句表示x,sum变量对于每个线程是私有的
{
  int id;
  id = omp_get_thread_num();
  printf("id：%d\n",id);  
	for (i=id,sum= 0.0;i< num_steps; i=i+NUM_THREADS){
		x = (i+0.5)*step;
		sum += 4.0/(1.0+x*x);
	}
  printf("sum:%lf\n",sum);
#pragma omp critical  //指定代码段在同一时刻只能由一个线程进行执行
	pi += sum*step;
}
 printf("%lf\n",pi);
}
