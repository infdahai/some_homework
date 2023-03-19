"""

insert-sort algorithm implement


"""



import time

def busy_wait(duration):
    deadline = time.monotonic() + duration
    while time.monotonic() < deadline:
        pass



source = '../input/input_integer.txt'
with open(source, 'r') as f:
    list_k = [int(line.strip('\n')) for line in f.readlines()]
    print(list_k)

for n in [2, 5, 8, 11, 14, 17]:

    print('this is 2^' + str(n) + ' test\n')
    k = pow(2, n)
    list_copied = list_k[:k]

    ##time.process_time() only inculdes the CPU time cost
    #start = time.process_time_ns()
    start = time.process_time()

    for j in range(1, k):
        # the list index begins  from 0.
        # j from 1 to k-1.
        # So we use 'i>=0' not 'i>0'.
        key = list_copied[j]
        i = j - 1

        while i >= 0 and key < list_copied[i]:
            list_copied[i + 1] = list_copied[i]
            i -= 1

        list_copied[i + 1] = key
    busy_wait(0.10000)
    #end=time.process_time_ns()
    end = time.process_time()
  #  print('\nthe time cost is ' + str(end - start) + 's \n')

    print(list_copied)
    print('\n')
    path = '../output/insertsort/result_' + str(n) + '.txt'
    path_time = '../../test_insewrtsort.txt'

    with open(path, 'w') as wf:
        for i in range(k):
            wf.write(str(list_copied[i]))
            wf.write('\n')

    with open(path_time, 'a') as time_wf:
        time_wf.write('this is 2^' + str(n) + ' test\n')
        time_wf.write('\nthe time cost is ' + str(end - start-0.1000) + 's \n')
        print('\nthe time cost is ' + str(end - start-0.1000) + 's \n')

