

import random
import os
k=0

def generate():
    lists = []
    for j in range(1,150):
        i = random.randint(1,65536)
        if not (i in lists):
            lists.append(i)
    k = len(lists)
    return k,lists


path = '../inputA/'
while k < 100:
    k,lists = generate()
if not os.path.exists(path):
    os.makedirs(path)

with open(path+'input.txt','w') as f:
    for i in range(k):
        f.write(str(lists[i]))
        f.write('\n')