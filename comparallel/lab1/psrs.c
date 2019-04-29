#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<omp.h>

#define num_threads 4



void Merge(int *arr, int p, int q, int r)
{
    int i,j,k;
    int len1 = q - p + 1;
    int len2 = r - q;
    int* Left = (int*)malloc((len1+1)*sizeof(int));
    int* Right = (int*)malloc((len2+1)*sizeof(int));
    for(i=0; i<len1; i++)
        Left[i] = arr[p+i];
    Left[i] = 65536;
    for(j=0; j<len2; j++)
        Right[j] = arr[q+j+1];
    Right[j] = 65536;
    i=0,j=0;
    for(k=p; k<=r; k++){
        if(Left[i]<=Right[j]){
            arr[k] = Left[i];
            i++;
        }
        else{
            arr[k] = Right[j];
            j++;
        }
    }
} 

void MergeSort(int *arr, int p, int r)
{
    if(p<r){
        int q = (p+r)/2;
        MergeSort(arr,p,q);
        MergeSort(arr,q+1,r);
        Merge(arr,p,q,r);
    }
} 

void psrs_alg(int *array, int n)
{
    int id;
    int i=0;
    int count[num_threads][num_threads] = { 0 };   
    int base = n / num_threads;  
    int processer[num_threads*num_threads];
    int pivot[num_threads-1];    
    int pivot_array[num_threads][num_threads][100]={0}; 

    omp_set_num_threads(num_threads);
#pragma omp parallel shared(base,array,n,i,processer ,pivot,count) private(id)
    {
        id = omp_get_thread_num();
        MergeSort(array,id*base,(id+1)*base-1);
#pragma omp critical
        for(int k=0; k<num_threads; k++)
            processer[i++] = array[(id-1)*base+(k+1)*base/(num_threads+1)];
#pragma omp barrier
#pragma omp master
        {
            MergeSort(processer,0,i-1);
            for(int m=0; m<num_threads-1; m++)
                pivot[m] = processer[(m+1)*num_threads];
        }
#pragma omp barrier
        for(int k=0; k<base; k++)
        {
            for(int m=0; m<num_threads; m++)
            {
                if(array[id*base+k] < pivot[m])
                {
                    pivot_array[id][m][count[id][m]++] = array[id*base+k];
                    break;
                }
                else if(m == num_threads-1) 
                {
                    pivot_array[id][m][count[id][m]++] = array[id*base+k];
                }
            }
        }
    }
#pragma omp parallel shared(pivot_array,count)
    {
        int id=omp_get_thread_num();
        for(int k=0; k<num_threads; k++)
        {
            if(k!=id)
            {
                memcpy(pivot_array[id][id]+count[id][id],pivot_array[k][id],sizeof(int)*count[k][id]);
                count[id][id] += count[k][id];
            }
        }
        MergeSort(pivot_array[id][id],0,count[id][id]-1);
    }
    i = 0;
    printf("result:\n");
    for(int k=0; k<num_threads; k++)
    {
        for(int m=0; m<count[k][k]; m++)
        {
            printf("%d ",pivot_array[k][k][m]);
        }
        printf("\n");
    }
}

int main()
{
  int array[27] = { 15,46,48,93,39,6,72,91,14, 36,69,40,89,61,97,12,21,54,
                    53,97,84,58,32,27,33,72,20};
  psrs_alg(array,27);
    return 0;
}
