import numpy as np
import matplotlib.pyplot as plt
import math
import matplotlib.animation as animation


def neighbor(matrix, i, j, n):
    # 适用于边界互相连通的拓扑结构
    row = list()
    colume = list()
    if i+n > matrix.shape[0]-1:
        for x in range(i-n, matrix.shape[0]):
            row.append(x)
        for x in range(0, i+n-matrix.shape[0]+1):
            row.append(x)
    if j+n > matrix.shape[1]-1:
        for x in range(j-n, matrix.shape[0]):
            colume.append(x)
        for x in range(0, j+n-matrix.shape[0]+1):
            colume.append(x)
    if len(row) == 0:
        for x in range(i-n, i+n+1):
            row.append(x)
    if len(colume) == 0:
        for x in range(j-n, j+n+1):
            colume.append(x)
    row1=list()
    for x in range(0, len(row)):
        row2=list()
        for y in range(0, len(colume)):
            row2.append(row[x])
        row1.append(row2)
    return matrix[row1, colume]

# 普通二维元胞自动机演变
# Q:此种演变规则下，是不是元胞数量 or 领域层数越多，演变出的图形种类就越多?


def update(frames, myImg, matrix, layer, cnum):
    # 定义函数的时候，形参多留一个位置给FuncAnimation里的Frames参数
    new_matrix = matrix.copy()
    rows = np.shape(matrix)[0]
    cols = np.shape(matrix)[1]
    for i in range(rows):
        for j in range(cols):
            neighborhood = neighbor(matrix, i, j, layer)
            # if (neighborhood.sum() - matrix[i, j])%4 == 0:
            #     new_matrix[i, j] = 0
            # if (neighborhood.sum() - matrix[i, j])%4 == 1:
            #     new_matrix[i, j] = 1
            # if (neighborhood.sum() - matrix[i, j])%4 == 2:
            #     new_matrix[i, j] = 2
            # if (neighborhood.sum() - matrix[i, j])%4 == 3:
            #     new_matrix[i, j] = 3
            for m in range(0, cnum):
                if (neighborhood.sum() - matrix[i, j]) % cnum == m:
                    new_matrix[i, j] = m
    myImg.set_data(new_matrix)
    matrix[:] = new_matrix[:]
    return myImg,


if __name__ == '__main__':
    N = 151
    n = 2
    updateInterval = 800
    m1 = np.zeros((N, N))
    r, c = np.shape(m1)
    m1[math.floor(r/2), math.floor(c/2)] = 3
    # painter(m1, "Reds")
    # for i in range(1, 40):
    #     m1 = update(m1, 2)
    # painter(m1, "Reds")

    # plt.subplots()返回两个值，一个是Figure（画布)，另一个就是Axes对象（子图）
    fig, ax = plt.subplots()
    img = ax.imshow(m1, interpolation='nearest')
    plt.xticks([])
    plt.yticks([])
    # save_count=50，意味着保留50帧的内容
    # fargs，给update填入的后三个参数
    ani = animation.FuncAnimation(fig, update, fargs=(img, m1, n, 5),
                                  interval=updateInterval, save_count=50)

    ani.save(filename="CA1.gif")
    plt.show()
