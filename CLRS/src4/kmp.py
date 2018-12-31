"""
kmp algorithm implement
"""

import time
import re
from ex.source.bmh import delete_file
import os
from chrono import Timer

ch_list = ['A', 'B', 'C', 'D', "E", "F"]
nm_list = [(i, pow(2, 5 + 3 * i), 2 + i) for i in range(5)]


def kmp_matcher(P: str, T: str):
    n = len(T) - 1
    m = len(P) - 1
    pi = compute_prefix_function(P, m)
    q = 0
    flag = False
    first_match = -1
    for i in range(1, n + 1):
        while q > 0 and P[q + 1] != T[i]:
            q = pi[q]
        if P[q + 1] == T[i]:
            q = q + 1
        if q == m:
            print("Pattern occurs with shift " + str(i - m + 1))
            if not flag:
                flag = True
                first_match = i - m + 1
            q = pi[q]
    return first_match


def compute_prefix_function(P: str, m: int):
    pi = [0 for i in range(m + 1)]
    k = 0
    for q in range(2, m + 1):
        while k > 0 and P[k + 1] != P[q]:
            k = pi[k]
        if P[k + 1] == P[q]:
            k += 1
        pi[q] = k
    return pi


if __name__ == "__main__":
    T_list = []
    P_list = []
    source = "../input.txt"
    with open(source, 'r') as rf:
        a = re.split('[,;]', rf.read().rstrip())
        for i in range(len(a)):
            if i % 2 == 0:
                T_list.append(a[i])
            else:
                P_list.append(a[i])

    path = "../output/kmp/"
    if not os.path.exists(path):
        os.mkdir(path)
    with open(path + "output.txt", 'w') as f:
        for k in nm_list:
            i = k[0]
            T = 'X'
            P = 'X'
            T += T_list[i]
            P += P_list[i]
            f.write("文本串长度:" + str(k[1]) + " ")
            f.write("模式串长度:" + str(k[2]) + " ")
            begin_time = time.process_time()
            first = kmp_matcher(P, T)
            end_time = time.process_time()
            f.write("首次成功匹配的起始位置:" + str(first) + " ")
            f.write("匹配结束所需运行时间:" + str(end_time - begin_time) + " \n")

    # delete_file(path+"output.txt")
