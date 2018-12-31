


import random
import os

k=0

def generate():
    lists= []
    for t in range(50):
        i = random.randint(0,51)
        j = random.randint(0,51)
        if i == j :
            continue
        if i>j:         # let i < j
            t= i
            i = j
            j = t
        if not (j<=25 or i>=30):
            continue
        if not ((i,j)  in lists):
            lists.append((i,j))
    k=len(lists)
    return k,lists

path='../inputB/'
while k<30:
    k,lists = generate()
if not os.path.exists(path):
    os.makedirs(path)

with open(path+'input.txt','w') as f:
    for i in range(k):
        f.write(str(lists[i][0])+' '+str(lists[i][1]))
        f.write('\n')