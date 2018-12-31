import  random


list_generate =[random.randint(1,65535) for i in (range(pow(2,17)+10))]
k=len(list_generate)
source= '../input/input_integer.txt'
with open(source,'w') as f:
    for i  in range(k):
        f.write(str(list_generate[i]))
        f.write('\n')
