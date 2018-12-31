"""

    count-sort algorithm implement

"""

import time


def busy_wait(duration):
    deadline = time.monotonic() + duration
    while time.monotonic() < deadline:
        pass



def CountSort(list_copied, list_new, k,maximum=65535):
    list_assist = [0 for i in range(maximum + 1)]  # 0,1,..,65535
    # map the index to the value. So we don't consider the zero index.
    # And we set the list length is 65535 to solve problems more easily.
    length = maximum

    for i in range(k):
        list_assist[list_copied[i]] += 1

    for j in range(1, length + 1):
        list_assist[j] += list_assist[j - 1]
    # because the C[] array index from 1 to 65535.
    # So we don't need to consider the 0.

    for t in range(k - 1, -1, -1):  # t from  k-1 to 0,step is 1

        list_new[list_assist[list_copied[t]]] = list_copied[t]
        list_assist[list_copied[t]] -= 1


# list_new index is from 1 to k.

if __name__=='__main__':

    source = '../input/input_integer.txt'
    with open(source, 'r') as f:
        list_k = [int(line.strip('\n')) for line in f.readlines()]

    for n in [2, 5, 8, 11, 14, 17]:
        print('this is 2^' + str(n) + ' test\n')

        k = pow(2, n)
        list_copied = list_k[:k]
        list_new = [0 for i in range(k + 1)]

        start = time.process_time()

        CountSort(list_copied, list_new, k)
        busy_wait(0.1000)
        end = time.process_time()

        path = '../output/countsort/result_' + str(n) + '.txt'

        path_time = '../../test_countsort.txt'

        with open(path, 'w') as wf:
            for i in range(1, k + 1):
                wf.write(str(list_new[i]))
                wf.write('\n')

        with open(path_time, 'a') as time_wf:
            time_wf.write('this is 2^' + str(n) + ' test\n')
            time_wf.write('\nthe time cost is ' + str(end - start - 0.1000) + 's \n')
            print('\nthe time cost is ' + str(end - start - 0.1000) + 's \n')

