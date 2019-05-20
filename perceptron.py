import matplotlib.pyplot as plt
import numpy as np
def g(xz:np.ndarray,Omega:np.ndarray):
    return int(np.dot(Omega,xz))

row = 1
w1 = np.array([[0,0,1],[0,1,1]])
w2 = np.array([[1,0,1],[1,1,1]])
w2 = w2.__neg__()
omega = []
omega.append(np.ones((1,3),dtype=int))   # omega[1]

i =0
x = [0 for i in range(3)]
x[0:2] = w1
x[2:4] = w2
print(2*" "+"训练样本" + 6*" "+"(w[k].T)*x"+8*" "+"修正式"+8*" "+"修正后的权值w[k+1]"+8*" "+"迭代次数")
while True:
    ok = True
    for j in range(4):
        str_pnt = ""
        str_pnt += ("x[%d] " % int(j+1))+x[j].__str__()
        ome = omega[-1]
        sum = g(x[j],ome)
        str_space = " " * 4
        sum_flag = True
        if sum<= 0:
            if(j<2):
                str_pnt += 3*" "
            if(sum == 0):
                str_pnt +=str_space+ "0"+str_space*3
            else:
                str_pnt +=str_space+ "-"+str_space*3
            str_pnt += "w[%d]+x[%d]" % (len(omega),int(j+1))
            ome = ome + row*x[j]
            omega.append(ome)
            ok = False
            sum_flag =False
        else:
            if(j<2):
                str_pnt += 3*" "
            str_pnt +=str_space+ "+"+str_space*3 +("w[%d]" % len(omega))
            pass
        if sum_flag :
            str_pnt += 10*" "+ome[0].__str__()+17*" "
        else:
            str_pnt += 5*" "+ome[0].__str__()+14*" "
        if(j==0):
            str_pnt += str(int(i+1))

        print(str_pnt)




    i+= 1

    if ok :
        print(i)
        break

ret_str = ""
for arr in omega[-1]:
    for index,val in enumerate(arr):
        index +=1
        if val == 0:
            pass
        elif index == len(arr):
            ret_str += "+%d\n"%(val)
        elif abs(val) ==1:
            if(val == -1):
                ret_str += "-"
            else:
                ret_str += "+"
            ret_str +=  "x[%d]"% (index)
        else:
            ret_str += "+%dx[%d]"%(val,index)
    ret_str = ret_str[1:]

print("the function : g(x) = "+ret_str)


