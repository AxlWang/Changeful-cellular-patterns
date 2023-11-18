# Changeful cellular patterns

## Introduction
- EN: Based on simple rules, cellular automata can continuously iterate out beautiful patterns. This time, I use a two-dimensional matrix to store the states of cells and define a rule: if the sum of the state values of neighboring cells is a multiple of n, then the state value of the central cell in the next generation is n. By changing the initial matrix and evolution rules (i.e. changing the number of layers in the neighborhood and the number of colors), different patterns can be obtained. But if you want to obtain a symmetrical pattern, you need to maintain the symmetry of the initial matrix.I used Python for programming and collected many exquisite patterns. After that, I also used Processing programming to make each generation's patterns fill the entire canvas, and the attached code can be run directly on Python and Processing.


- CN: 基于简单的规则，元胞自动机就可以不断迭代出美丽的图案。这次我用二维矩阵存储元胞的状态，并定义规则：如果邻域元胞的状态值之和是n的倍数，那么中心元胞在下一代的状态值就是n。通过改变初始矩阵，以及演化规则（即改变邻域的层数与颜色的总数），就可以得到不同的图案。通过改变初始矩阵，以及演化规则（即改变邻域的层数），就可以得到不同的图案。但是如果想得到对称的图案，就需要保持初始矩阵的对称性。。我用Python进行编程，收集了许多精美的图案。在那之后，我还用Processing编程，使每一代的图案都能够充斥整个画布，附件的代码可以直接在Python和Processing上面运行。

## Design ideas
### Python code

![img1](CA1.gif)

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

### Processing code



- EN: When I was writing Processing code, I tried to make every iteration of the pattern fill the entire canvas. For this reason, I defined a function called "copy_by_center" in the "cell" class, which requires passing in two parameters: one is the number of rows occupied by the pattern, and the other is a two-dimensional array for iteration. In the "copy_by_center" function, I also defined a function called "count_row2", which can obtain the number of rows occupied by elements with numbers in a two-dimensional array. Finally, the 'copy_by_center' function returns a two-dimensional array to the 'show' function for visualization.

- CN: 我在编写Processing代码的时候，尝试使每一次迭代出的图案都能充斥整个画布。为此，我在“cell”这个类中，定义了一个名为“copy_by_center”的函数，这个函数需要传入两个参数，一个是图案占据的行数，另一个是用于迭代的二维数组。在"copy_by_center"函数中，我还定义了一个函数名为“count_row2”，它可以获得二维数组中有数字的元素占据的行数。最后，"copy_by_center"函数返回一个二维数组给“show”函数进行可视化。

```Processing
 int count_row2(int[][] grid) {
    int result = 0;
    for (int i = 0; i < grid.length; i++){
      int mycount = 0;
      for (int j = 0; j < grid[0].length; j++){
        mycount += grid[i][j];
      }
      if(mycount > 0){
         result = (grid.length - 2*i);
         return result;
      }
    }
    return result;
  }
  
  int[][] copy_by_center(int rows, int[][] grid){
    int startrow = floor(grid.length/2) - (rows - 1)/2;
    int startcol = floor(grid[0].length/2) - (rows - 1)/2;
    int x = 0;
    int[][] center_grid = new int [rows][rows];
    for (int i = startrow; i < (startrow + rows); i++){
      int y = 0;
      for (int j = startcol; j < (startcol + rows); j++){
        center_grid[x][y] = grid[i][j];
        y++;
      }
      x++;
    }
    return center_grid;
  }
```

- EN: In the "View" module, I used an external library called "gifAnimation" to obtain gif images. Please refer to the code for details.

- CN: 在"View"这个模块中，我使用了一个名为“gifAnimation”的外部库来获取gif图片。具体可查看代码。

## Areas for improvement

- EN: The above two methods of generating patterns are both based on the same rule, and in fact, there are more rules waiting for me to experiment with.
- CN: 以上两种生成图案的方式都是基于同一种规则，事实上还有更多规则等待着我去实验。
