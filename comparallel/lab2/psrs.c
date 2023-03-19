

// PSRS sort implementation

// reference link1 : http://csweb.cs.wfu.edu/bigiron/LittleFE-PSRS/build/html/PSRSalgorithm.html
//           link2 : https://github.com/HenryLiu0/MPI-PSRS/blob/master/MPI_PSRS.cpp
#include <stdio.h>
#include <mpi.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#define LENGTH 50


const int size_int = sizeof(int);
// default:  we use number in unsigned int range.
int n=27, p=3;
int arr[LENGTH];
// just consider  1 to length
void swap(int*,int,int);
void quickSort(int*,int,int);
int partition(int*,int,int);
void printHelper(int [],int,char*);
void randomGenerator(int [],int,int,int);

//void copyData(int* , int*,int);
// replace with memcpy function

void quickSort(int array[],int low, int high)
{
  int pi;
  if(low<high)
    {
      pi = partition(array, low, high);
      quickSort(array, low, pi-1);
      quickSort(array, pi+1, high);
    }
  return ;
}

int partition(int array[],int low ,int high)
{
  int pivot = array[high];
  int i,j;
  i = low -1;
  for(j = low;j<high;j++)
    {
      if(array[j]<=pivot)
        {
          i++;
          swap(array, i, j);
        } 
    }
  swap(array, i+1, high);
  return (i+1);
}

void swap(int* array,int a , int b)
{
  // a1= a1^b1; b1= a1^b1;a1= a1^b1;
  int temp = array[a];
  array[a] =array[b];
  array[b] = temp;
    return;
}

void printHelper(int arr[],int len,char* str)
{
  printf("Array [%s] View: \n",str);
  for(int i = 1;i<=len;i++)
    {
      printf("%d ", arr[i]);    
    }
  printf("\n");
  return;
}

void randomGenerator(int arr[],int low,int high,int len){
  for(int i = 1;i<=len;i++)
    {
      arr[i] = rand()%(high-low+1)+low;
    }
  printHelper(arr, len,"arr");
  printf("Random number generated\n\n");
  return ;
}


// I don't use winner tree or loose tree.
// just a simple implementation.
void multi_merge(int*start[],int* length,int*SortedQueue, int size_size)
{

  return;
}

int main(int argc, char *argv[])
{
  srand(time(NULL));
  randomGenerator(arr, 0, 100, n);
  int* sortArr;
  sortArr = (int*)malloc(size_int*(n+1));
  memcpy(sortArr, arr, n);
  printHelper(sortArr, n, "SortArr1");

  // n%p = 0 , group_size = p  but we will use [0..p-1] thread process the sortArr .
  // And [0] thread process the communication .
  // p : 3 , n:27
  int group_size = p, my_rank ;
  double x;
  long epoch  = 2000;
  double h  = 1.0/(double)epoch;
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &group_size);
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

  int* regSams ;
  int my_low = my_rank*n/p+1;
  int my_high = (my_rank+1)*n/p;
  quickSort(sortArr, my_low,my_high);
  regSams = (int*)malloc(size_int*p);
  for(int index= 0 ; index<p;index++)
    regSams[index] = sortArr[1+my_rank*n/p+index*p];

  int* gatherRegSam = NULL;
  if(my_rank==0)
    {
      printHelper(sortArr, n, "SortArr_localSort");     
      gatherRegSam = (int*)malloc(size_int*p*p);
    }
  MPI_Gather(regSams, p, MPI_INT, gatherRegSam, p, MPI_INT, 0, MPI_COMM_WORLD);

  

  // multi merge-sort
  int* privots = (int*)malloc(size_int *p);
  if(my_rank==0)
    {
      int**starts = (int**)malloc(sizeof(int*)*p);
      for(int i = 0 ;i<p;i++)
        starts[i] = (int*)malloc(size_int *p);
      int * lengths = (int*)malloc(size_int *p);
      for(int j =0 ;j<p;j++)
        {
          starts[j]= &gatherRegSam[j*p];
          lengths[j] = p;
        }
      int* sortRegSam = (int*)malloc(size_int *p*p);
      multi_merge(starts, lengths, sortRegSam, p*p);
      for(int k = 0; k<p-1;k++)
        privots[k] = sortRegSam[(k+1)*p];  // such as  the 4th and 7th element.

      free(sortRegSam);
      free(starts);
      free(lengths);
    }

  MPI_Bcast(privots, p-1, MPI_INT, 0, MPI_COMM_WORLD);

  free(gatherRegSam);
  free(regSams);
  MPI_Finalize();
  free(sortArr);
  return 0;
}
