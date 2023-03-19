import time
import re
from ex.source.bmh import delete_file
import os

nm_list = [(i, pow(2, 5 + 3 * i), 2 + i) for i in range(5)]

ch_list = ['A', 'B', 'C', 'D', "E", "F"]


# t作为滚动数组
def rabin_karp_matcher(T: str, P: str, d: int, q: int):
    n = len(T) - 1
    m = len(P) - 1
    h = pow(d, m - 1) % q
    p = 0
    t = 0
    first_match = -1
    flag = False
    for i in range(1, m + 1):
        p = (d * p + ord(P[i])) % q
        t = (d * t + ord(T[i])) % q
    for s in range(n - m + 1):
        if p == t:
            if P[1:m] == T[s + 1:s + m]:
                print("Pattern occurs with shift")
                if not flag:
                    flag = True
                    first_match = s + 1
        if s < n - m:
            t = (d * (t - ord(T[s + 1]) * h) + ord(T[s + m + 1])) % q
    return first_match


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

    path = "../output/rk/"
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
            first = rabin_karp_matcher(P=P, T=T, d=10, q=13)
            end_time = time.process_time()
            f.write("首次成功匹配的起始位置:" + str(first) + " ")
            f.write("匹配结束所需运行时间:" + str(end_time - begin_time) + " \n")

    # delete_file(path + "output.txt")
