#include <stdio.h>
#include <math.h>
#include <mpi.h>

long n,i;
double sum,pi,mypi,x,h;
int main(int argc, char *argv[])
{
  int group_size,my_rank;
  MPI_Status status;
  MPI_Init(&argc,&argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &group_size);
  n  = 2000;
  MPI_Bcast(&n, 1, MPI_LONG, 0, MPI_COMM_WORLD);
  h = 1.0/(double)n;
  sum = 0.0;
  for(i=my_rank+1;i<=n;i+=group_size)
    {
      x = h*(i-0.5);
      sum += 4.0/(1+x*x);
    }
  mypi = h*sum;
  MPI_Reduce(&mypi, &pi,1,MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
  if(my_rank==0){
    printf("pi is %.16f\n",pi );
  }
  MPI_Finalize();
  return 0;
}
