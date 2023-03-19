
from br import   br_tree_node,br_tree
import  os
import  random
class interval_node(br_tree_node):
    def __init__(self,low,high):
        br_tree_node.__init__(self,low)
        self.low = low
        self.high = high
        self.maxx = high

class interval_tree(br_tree):
    def __init__(self):
        self.nil = interval_node(0,0)
        self.root = self.nil


    def interval_insert(self,z):
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
            self.root = z
        elif z.key < y.key:
            y.left = z
        else:
            y.right = z
        z.left = self.nil
        z.right = self.nil
        z.color = 'r'
        z.maxx = max(z.high,z.left.maxx,z.right.maxx)
        super().rb_insert_fixup(z)

        # update the maxx scope of this tree
        while z.p!=self.nil:
            z.p.maxx = max(z.p.maxx,z.maxx)
            z= z.p

    def int_left_rotate(self,x):
        super().left_rotate(x)
        y = x.p
        y.maxx = x.maxx
        x.maxx = max(x.left.maxx,x.right.maxx,x.high)

    def int_right_rotate(self,y):
        super().right_rotate(y)
        x= y.p
        x.maxx = y.maxx
        y.maxx = max(y.left.maxx,y.right.maxx,y.high)

    def inorder_walk(self,x,f):
        if x!=self.nil:
            self.inorder_walk(x.left,f)
            print('low: ',x.low,'high: ',x.high,'max: ',x.maxx,'color: ',x.color,file=f)
            self.inorder_walk(x.right,f)
    def tree_search(self,low,high):
        x= self.root
        while x!=self.nil and(high<x.low or x.high< low):
            if x.left!=self.nil and x.left.maxx >=low:
                x=x.left
            else:
                x=x.right
        return x.low,x.high


source ='../inputB/input.txt'

interval_lists=[]
with open(source,'r') as f:
     for line in f.readlines():
        str_ = line.strip('\n').split()
        i,j = int(str_[0]),int(str_[1])
        interval_lists.append((i,j))


T =interval_tree()
for node in  interval_lists:
    T.interval_insert(interval_node(node[0],node[1]))

path = '../outputB/'
if not os.path.exists(path):
    os.makedirs(path)

with open(path+'inorder.txt','w') as f:
    T.inorder_walk(T.root,f)

with open(path+'delete_data.txt','w') as f:
    T.rb_delete(T.root)
    T.inorder_walk(T.root,f)

with open(path+'search.txt','w') as f:
    def generate_1():
        while 1:
            i = random.randint(0,51)
            j = random.randint(0,51)
            if i ==j:
                continue
            if i>j:
                t = i
                i = j
                j = t
            if not (j<=25 or i>=30):
                continue

            return i,j
    f.write('1:\n')
    low,high = generate_1()
    f.write('search int:\n '+str(low)+' '+str(high)+'\n')
    if T.tree_search(low,high)!=T.nil:
        low_1,high_1 = T.tree_search(low,high)
        f.write('find_result:\n '+str(low_1)+' '+str(high_1)+'\n')
    else:
        f.write('find result:\n  NULL\n')

    def generate_2():
        while 1:
            i = random.randint(26,30)
            j = random.randint(26,30)
            if i == j:
                continue
            if i > j:
                t = i
                i = j
                j = t
            return i, j

    low,high = generate_2()
    f.write('2:\n')
    f.write('search int:\n '+str(low)+' '+str(high)+'\n')
    if T.tree_search(low, high) != (0,0):
        low_2, high_2 = T.tree_search(low, high)
        f.write('find_result:\n '+str(low_2)+' '+str(high_2)+'\n')
    else:
        f.write('find result:\n  NULL\n')

