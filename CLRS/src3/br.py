""""
generate black and red tree and finish the first task.
"""

import time
import os


class br_tree_node:
    def __init__(self, x):
        self.key = x
        self.left = None
        self.right = None
        self.p = None
        self.color = 'b'
        self.size = 0


class br_tree:
    def __init__(self):
        self.nil = br_tree_node(0)
        self.root = self.nil

    def left_rotate(self, x):
        y = x.right  # y 是x的右孩子
        x.right = y.left  # y的左孩子给x当右孩子
        if y.left != self.nil:  # 如果y有左孩子，新父亲是x
            y.left.p = x
        y.p = x.p
        if x.p == self.nil:
            self.root = y  # 如果x是根，则y变成根
        elif x == x.p.left:  # 如果x是左孩子，y也变成左孩子
            x.p.left = y
        else:
            x.p.right = y
        y.left = x
        x.p = y

    def right_rotate(self, y):
        x = y.left
        y.left = x.right
        if x.right != self.nil:
            x.right.p = y
        x.p = y.p
        if y.p == self.nil:
            self.root = x
        elif y == y.p.right:
            y.p.right = x
        else:
            y.p.left = x
        x.right = y
        y.p = x

    # 插入node
    def rb_insert(self, z):
        y = self.nil
        x = self.root
        while x != self.nil:
            y = x
            if z.key < x.key:
                x = x.left
            else:
                x = x.right
        z.p = y
        if y == self.nil:
            # if y is root
            self.root = z
            # 之后，y不是根的时候
        elif z.key < y.key:
            y.left = z
        else:
            y.right = z
        z.left = self.nil
        z.right = self.nil
        z.color = 'r'
        self.rb_insert_fixup(z)
        print(z.key, ' color: ', z.color)

    def rb_insert_fixup(self, z):
        while z.p.color == 'r':  # 父节点为红色
            if z.p == z.p.p.left:  # 父节点为左孩子
                y = z.p.p.right  # uncle为红色
                if y != self.nil and y.color == 'r':
                    z.p.color = 'b'  # case1
                    y.color = 'b'  # case1
                    z.p.p.color = 'r'  # case1
                    z = z.p.p  # case1
                else:  # uncle 为黑色
                    if z == z.p.right:  # node为右孩子
                        z = z.p  # case2
                        self.left_rotate(z)  # case2
                    # uncle 黑色，node是左孩子,enter case3
                    z.p.color = 'b'  # case3
                    z.p.p.color = 'r'  # case3
                    self.right_rotate(z.p.p)  # case3
            else:  # 父节点是右孩子
                y = z.p.p.left
                if y != self.nil and y.color == 'r':
                    # uncle 是红色，enter case1
                    z.p.color = 'b'  # case1
                    z.color = 'b'  # case1
                    z.p.p.color = 'r'  # case1
                    z = z.p.p
                else:  # unclde是黑色
                    if z == z.p.left:  # node是左孩子
                        z = z.p  # case 2
                        self.right_rotate(z)  # case2
                    # unclde是黑色,node是右孩子
                    z.p.color = 'b'  # case3
                    z.p.p.color = 'r'  # case3
                    self.left_rotate(z.p.p)  # case3
        self.root.color = 'b'

    def rb_transplant(self, u, v):
        if u.p == self.nil:
            self.root = v
        elif u == u.p.left:
            u.p.left = v
        else:
            u.p.right = v

        v.p = u.p

    def rb_delete(self, z):
        y = z
        y_origin_color = y.color
        if z != T.nil and z.left == self.nil:
            # node 最多有一个右孩子
            x = z.right
            self.rb_transplant(z, z.right)
        elif z != T.nil and z.right == self.nil:
            # node最多有一个左孩子
            x = z.left
            self.rb_transplant(z, z.left)
        else:
            # node有两个孩子
            y = self.tree_minimum(z.right)
            # y是node的后继，会被换上来
            y_origin_color = y.color
            x = y.right
            if y.p == z:
                x.p = y
            else:
                self.rb_transplant(y, y.right)
                y.right = z.right
                y.right.p = y

            self.rb_transplant(z, y)
            y.left = z.left
            y.left.p = y
            y.color = z.color
        # 如果原节点颜色为黑色，需修补。满足红黑树各路径黑色数相同
        if y_origin_color == 'b':
            self.rb_delete_fixup(x)

        # 调整颜色

    def rb_delete_fixup(self, x):
        while x != self.root and x.color == 'b':
            if x == x.p.left:  # node 是左孩子
                w = x.p.right  # case1
                if w.color == 'r':
                    # 兄弟是红色,enter case1
                    w.color = 'b'  # case1
                    x.p.color = 'r'  # case1
                    self.left_rotate(x.p)  # case1
                    w = x.p.right  # case1
                if w.left.color == 'b' and w.right.color == 'b':
                    # 兄弟黑色， enter case2
                    w.color = 'r'  # case2
                    x = x.p  # case2
                else:
                    if w.right.color == 'b':
                        # 兄弟黑色，兄弟右孩子黑色，enter case3
                        w.left.color = 'b'  # case3
                        w.color = 'r'  # case3
                        self.right_rotate(w)  # case3
                        w = x.p.right  # case3
                    # 兄弟红色，兄弟右孩子红色,enter case4
                    w.color = x.p.color  # case4
                    x.p.color = 'b'  # case4
                    w.right.color = 'b'  # case4
                    self.left_rotate(x.p)  # case4
                    x = self.root  # case4
            else:  # node 是右孩子
                w = x.p.left
                if w.color == 'r':
                    # 兄弟红色, enter case1
                    w.color = 'b'  # case1
                    x.p.color = 'r'  # case1
                    self.right_rotate(x.p)  # case1
                    w = x.p.left  # case1

                if (w.right.color == 'b' and w.left.color == 'b'):
                    # 兄弟黑色， 兄弟孩子都是黑色，enter case2
                    w.color = 'r'  # case2
                    x = x.p  # case2
                else:
                    if w.left.color == 'b':
                        # 兄弟黑色，兄弟左孩子黑色，enter case3
                        w.right.color = 'b'  # case3
                        w.color = 'r'  # case3
                        self.left_rotate(w)  # case3
                        w = x.p.left  # case3
                    # 兄弟红色，兄弟左孩子红色，进入case4
                    w.color = x.p.color  # case4
                    x.p.color = 'b'  # case4
                    w.left.color = 'b'  # case4
                    self.right_rotate(x.p)  # case4
                    x = self.root  # case4
        x.color = 'b'

    def tree_minimum(self, x):
        while x.left != self.nil:
            x = x.left
        return x

    def mid_sort(self, x, f):
        if x != None:
            self.mid_sort(x.left, f)
            if x.key != 0:
                if (x == self.root):
                    print('key: ', x.key, ' x.color: ', x.color, ' x.parent: root is root', file=f)
                else:
                    print('key: ', x.key, ' x.color: ', x.color, ' .parent: ', x.p.key, file=f)
            self.mid_sort(x.right, f)

    def pre_sort(self, x, f):
        if x != None:
            if x.key != 0:
                if (x == self.root):
                    print('key: ', x.key, ' x.color: ', x.color, ' x.parent: root is root', file=f)
                else:
                    print('key: ', x.key, ' x.color: ', x.color, ' .parent: ', x.p.key, file=f)
            self.pre_sort(x.left, f)
            self.pre_sort(x.right, f)

    def post_sort(self, x, f):
        if x != None:
            self.pre_sort(x.left, f)
            self.pre_sort(x.right, f)
            if x.key != 0:
                if (x == self.root):
                    print('key: ', x.key, ' x.color: ', x.color, ' x.parent: root is root', file=f)
                else:
                    print('key: ', x.key, ' x.color: ', x.color, ' .parent: ', x.p.key, file=f)


source = '../inputA/input.txt'
n_list = [20, 40, 60, 80, 100]
with open(source, 'r') as f:
    node_lists = [int(line.strip('\n')) for line in f.readlines()]

for n in n_list:

    #    node = [br_tree_node(val) for val in node_lists]
    path = '../outputA/size' + str(n) + '/'
    T = br_tree()
    times = 0
    time1_begin = time.process_time()
    time1_measure = []

    for node in node_lists[:n]:
        T.rb_insert(br_tree_node(node))
        times += 1
        if not (times % 10):
            time1_measure.append(time.process_time())
        elif times == n:
            time1_measure.append(time.process_time())

    k = len(time1_measure)
    if not os.path.exists(path):
        os.makedirs(path)

    with open(path + 'time1.txt', 'w') as f:
        f.write(str(time1_begin) + '\n')
        for i in range(k):
            f.write(str(time1_measure[i]))
            f.write('\n')
        time1_total = time1_measure[k - 1] - time1_begin
        f.write('the total time cost is ' + str(time1_total))
        f.write('\n')

    with open(path + 'preorder.txt', 'w') as f:
        T.pre_sort(T.root, f)
    with open(path + 'inorder.txt', 'w') as f:
        T.mid_sort(T.root, f)
    with open(path + 'postorder.txt', 'w') as f:
        T.post_sort(T.root, f)
    with open(path + 'delete_data.txt', 'w') as f:
        time_delete = []
        f.write('delete: \n')
        time_delete.append(time.process_time())
        f.write('key: ' + str(T.root.key) + ' color:'+T.root.color+' x.parent: root is root\n')
        T.rb_delete(T.root)
        time_delete.append(time.process_time())
        f.write('key: ' + str(T.root.key) + ' color:'+T.root.color+' x.parent: root is root\n')
        T.rb_delete(T.root)
        time_delete.append(time.process_time())
        f.write('\n')
        T.mid_sort(T.root, f)
    with open(path + 'time2.txt', 'w') as f:
        f.write('time begin:\n'+'delete[1]:\n'+'delete[2]:\n')
        for i in range(3):
            f.write(str(time_delete[i]) + 's\n')
        f.write('\n1: ' + str(time_delete[1] - time_delete[0]) + 's\n')
        f.write('2: ' + str(time_delete[2] - time_delete[1]) + 's\n')
