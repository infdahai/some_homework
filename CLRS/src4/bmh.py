"""

boyer-moore-horspool algorithm implement

"""
import os
import re
import time

ch_list = ['A', 'B', 'C', 'D', "E", "F"]
nm_list = [(i, pow(2, 5 + 3 * i), 2 + i) for i in range(5)]


# delete file

def delete_file(path: str):
    if os.path.exists(path):
        os.remove(path)

# don't consider the zero index


def horspool(P: str, T: str):
    m = len(P) - 1
    n = len(T) - 1
    Bc = Pre_bc(P, m)
    flag = False
    first_match = -1
    j = 1
    while j <= n - m + 1:
        c = T[j + m - 1]
        if P[m] == c:
            t_str = T[j:j + m ]
            p_str = P[1:]
            if t_str.__eq__(p_str):
                print(j - 1)
                if not flag:
                    flag = True
                    first_match = j
        j += Bc[c]

    return first_match


def Pre_bc(P: str, m: int):
    Bc = {}
    for elem in ch_list:
        Bc.update({elem: m})
    for i in range(1, m):
        Bc[P[i]] = m - i

    return Bc


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

    path = "../output/bmh/"
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
            first = horspool(P, T)
            end_time = time.process_time()
            f.write("首次成功匹配的起始位置:" + str(first) + " ")
            f.write("匹配结束所需运行时间:" + str(end_time - begin_time) + " \n")

# delete_file(path+"output.txt")
