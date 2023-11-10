# Changeful-cellular-patterns

## Introduction
- EN: Based on simple rules, cellular automata can continuously iterate out beautiful patterns. This time, I use a two-dimensional matrix to store the states of cells and define a rule: if the sum of the state values of neighboring cells is a multiple of n, then the state value of the central cell in the next generation is n. By changing the initial matrix and evolution rules (i.e. changing the number of layers in the neighborhood and the number of colors), different patterns can be obtained. But if you want to obtain a symmetrical pattern, you need to maintain the symmetry of the initial matrix.I used Python for programming and collected many exquisite patterns. After that, I also used Processing programming to make each generation's patterns fill the entire canvas, and the attached code can be run directly on Python and Processing.


- CN: 基于简单的规则，元胞自动机就可以不断迭代出美丽的图案。这次我用二维矩阵存储元胞的状态，并定义规则：如果邻域元胞的状态值之和是n的倍数，那么中心元胞在下一代的状态值就是n。通过改变初始矩阵，以及演化规则（即改变邻域的层数与颜色的总数），就可以得到不同的图案。通过改变初始矩阵，以及演化规则（即改变邻域的层数），就可以得到不同的图案。但是如果想得到对称的图案，就需要保持初始矩阵的对称性。。我用Python进行编程，收集了许多精美的图案。在那之后，我还用Processing编程，使每一代的图案都能够充斥整个画布，附件的代码可以直接在Python和Processing上面运行。


![img1](CA1.gif)

## Design ideas
### Python code
- EN: The 'update' function has 5 parameters. The first parameter is reserved for the Frames parameter in FuncAnimation, the second parameter is the canvas, the third parameter is the iterative matrix, the fourth parameter is the number of layers in the neighborhood, and the fifth parameter is the total number of colors. This function internally calls a function called 'neighbor' to return the neighborhood matrix of the specified number of layers.

- CN: "update"函数有5个参数，第一个参数预留给FuncAnimation里的Frames参数，第二个参数是画布，第三个参数是迭代的矩阵，第四个参数是邻域的层数，第五个参数是颜色的总数。该函数内部调用一个名为“neighbor”的函数，用于返回指定层数的邻域矩阵。

```python
def update(frames, myImg, matrix, layer, cnum):
    new_matrix = matrix.copy()
    rows = np.shape(matrix)[0]
    cols = np.shape(matrix)[1]
    for i in range(rows):
        for j in range(cols):
            neighborhood = neighbor(matrix, i, j, layer)
            for m in range(0, cnum):
                if (neighborhood.sum() - matrix[i, j]) % cnum == m:
                    new_matrix[i, j] = m
    myImg.set_data(new_matrix)
    matrix[:] = new_matrix[:]
    return myImg,
```

- EN: The dynamic graph generation of gif mainly relies on the following code. Before that, you need to import matplotlib. animation.

- CN: gif的动图生成主要依赖于以下代码。在此之前，需要导入matplotlib.animation。
```python
ani = animation.FuncAnimation(fig, update, fargs=(img, m1, n, 5),
                                  interval=updateInterval, save_count=20)
```
