"""

    radix-sort algorithm implement

"""
import time



def busy_wait(duration):
    deadline = time.monotonic() + duration
    while time.monotonic() < deadline:
        pass



def Randixsort(list_copied, count=6, radix=10):
    # count is the sort times.
    # use the LSD method. LSD means Least Significant Digit first.
    # length = len(list_copied)
    for i in range(1, count + 1):
        buckets = [[] for j in range(radix)]
        for val in list_copied:
            buckets[int((val / (radix ** (i - 1))) % 10)].append(val)

        del list_copied[:]

        for element in buckets:
            list_copied.extend(element)


source = '../input/input_integer.txt'
with open(source, 'r') as f:
    list_k = [int(line.strip('\n')) for line in f.readlines()]

for n in [2, 5, 8, 11, 14, 17]:
    print('this is 2^' + str(n) + ' test\n')

    k = pow(2, n)
    list_copied = list_k[:k]

    start = time.process_time()

    Randixsort(list_copied)

    busy_wait(0.1000)
    end = time.process_time()

    path = '../output/radixsort/result_' + str(n) + '.txt'

    path_time = '../../test_radixsort.txt'

    with open(path, 'w') as wf:
        for i in range(0, k ):
            wf.write(str(list_copied[i]))
            wf.write('\n')

    with open(path_time, 'a') as time_wf:
        time_wf.write('this is 2^' + str(n) + ' test\n')
        time_wf.write('\nthe time cost is '+str(end-start-0.1000)+'s \n')
        print('\nthe time cost is ' + str(end - start-0.1000) + 's \n')
