

"""

quick-sort algorithm implement

"""

import time

def busy_wait(duration):
    deadline = time.monotonic() + duration
    while time.monotonic() < deadline:
        pass



def Swap(list_copied,i,j):
    temp = list_copied[i]
    list_copied[i]=list_copied[j]
    list_copied[j]=temp


def Partition(list_copied,p,r):
    x=list_copied[r]
    i=p-1

    for j in range(p,r):
        if list_copied[j]<=x:
            i+=1
            Swap(list_copied,i,j)

    Swap(list_copied,i+1,r)

    return i+1

def QuickSort(list_copied,p,r):
    if p<r:
        q=Partition(list_copied,p,r)
        QuickSort(list_copied,p,q-1)
        QuickSort(list_copied,q+1,r)
"""
    else:
        raise ValueError(p,r)
"""


source='../input/input_integer.txt'
with open(source,'r') as f:
    list_k= [ int(line.strip('\n')) for line in f.readlines()]




for n in [2,5,8,11,14,17]:
    print('this is 2^' + str(n) + ' test\n')
    k=pow(2,n)
    list_copied=list_k[:k]

    start= time.process_time()

    QuickSort(list_copied,0,k-1)
    busy_wait(0.1000)
    end=time.process_time()




    path='../output/quicksort/result_'+str(n)+'.txt'

    path_time='../../test_quicksort.txt'

    with open(path,'w') as wf:
        for i in range(k):
            wf.write(str(list_copied[i]))
            wf.write('\n')


    with open(path_time, 'a') as time_wf:
        time_wf.write('this is 2^' + str(n) + ' test\n')
        time_wf.write('\nthe time cost is '+str(end-start-0.1000)+'s \n')
        print('\nthe time cost is ' + str(end - start-0.1000) + 's \n')
