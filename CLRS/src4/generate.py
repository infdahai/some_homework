"""
generate A-F characters(total 6 kinds of)
"""

import random


# n_list = [pow(2,5+3*i) for i in range(5)]

def generate_char(num):
    lists = []
    ch_list = ['A', 'B', 'C', 'D', "E", "F"]
    length = len(ch_list)
    for j in range(num):
        i = ch_list[random.randint(0, length - 1)]
        lists.append(i)

    return lists


nm_list = [(5 + 3 * i, 2 + i) for i in range(5)]
path = '../input.txt'

with open(path, 'w') as f:
    for (i, j) in nm_list:
        lists_1 = []
        lists_2 = []
        lists_1 = generate_char(pow(2, i))
        lists_2 = generate_char(j)
        for k in lists_1:
            f.write(k)
        f.write(',')
        for k in lists_2:
            f.write(k)
        f.write(';')