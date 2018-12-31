

"""
    heap-sort algorithm implement
"""

import  time



def busy_wait(duration):
    deadline = time.monotonic() + duration
    while time.monotonic() < deadline:
        pass


#the root index is 0.
#So Parent,Left,Right function need to be changed.
def Parent(i):
    return int((i-1)/2)

def Left(i):
    return i*2+1

def Right(i):
    return i*2+2




class Heap:
    def __init__(self,list_k):
        self.heap_size=0
        self.heap=list(list_k)

    def swap(self,i,j):
        temp=self.heap[i]
        self.heap[i]=self.heap[j]
        self.heap[j]=temp

    def Keep_Min_Heap(self,index):
        lnode = Left(index)
        rnode = Right(index)
        if lnode <self.heap_size and self.heap[lnode]<self.heap[index]:
            smallest= lnode
        else:
            smallest=index
        if rnode<self.heap_size and self.heap[rnode]<self.heap[smallest]:
            smallest=rnode

        if index != smallest:
            self.swap(index,smallest)
            self.Keep_Min_Heap(smallest)


    def Build_Min_Heap(self):
        self.heap_size=len(self.heap)

        for i in range(int((self.heap_size-1)/2),-1,-1):
            self.Keep_Min_Heap(i)


    def HeapSort(self,list_new):
        self.Build_Min_Heap()
        k=len(self.heap)
        j=0
        for i in range(k-1,-1,-1):
            list_new[j]=self.heap[0]
            j+=1
            self.swap(0,self.heap_size-1)
            self.heap_size-=1
            self.Keep_Min_Heap(0)
        return list_new


source='../input/input_integer.txt'

with open(source, 'r') as f:
    list_k = [int(line.strip('\n')) for line in f.readlines()]
    print(list_k)
    print('\n')





for n in [2,5,8,11,14,17]:
    print('this is 2^' + str(n) + ' test\n')
    k=pow(2,n)
    list_copied=list_k[:k]

    start= time.process_time()
    heap = Heap(list_copied)
    heap.HeapSort(list_copied)
    busy_wait(0.1000)
    end=time.process_time()

 #   print('\nthe time cost is '+str(end-start)+'s \n')

    print(list_copied)
    print('\n')

    path='../output/heapsort/result_'+str(n)+'.txt'

    path_time='../../test_heapsort.txt'

    with open(path,'w') as wf:
        for i in range(k):
            wf.write(str(list_copied[i]))
            wf.write('\n')

    with open(path_time,'a') as time_wf:
        time_wf.write('this is 2^' + str(n) + ' test\n')
        time_wf.write('\nthe time cost is '+str(end-start-0.1000)+'s \n')
        print('\nthe time cost is ' + str(end - start-0.1000) + 's \n')
