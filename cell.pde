class Cell {
  
  
  void seed(int[][] grid, int n){
    grid[floor(grid.length/2)][floor(grid[0].length/2)] = n;
  }
  
  int sum_neighbor(int[][] grid, int x, int y, int grid_width, int grid_height) {
     int mySum = grid[Math.floorMod(x-1,grid_width)][Math.floorMod(y-1,grid_height)] + grid[x][Math.floorMod(y-1, grid_height)] + grid[Math.floorMod(x+1, grid_width)][Math.floorMod(y-1, grid_height)] +
                 grid[Math.floorMod(x-1, grid_width)][y] + grid[Math.floorMod(x+1, grid_width)][y] + grid[Math.floorMod(x-1, grid_width)][Math.floorMod(y+1, grid_height)] + 
                 grid[x][Math.floorMod(y+1, grid_height)] + grid[Math.floorMod(x+1, grid_width)][Math.floorMod(y+1, grid_height)];
     return mySum;
  }
  
  int[][] next_gen(int[][] grid){
    int[][] new_grid = new int[grid.length][grid[0].length];
    int row = grid.length;
    int col = grid[0].length;
    for (int i = 0; i < row; i++){
      for (int j = 0; j < col; j++){
        int sum_n = sum_neighbor(grid, i, j, col, row);
        if (sum_n % 4 == 0){
          new_grid[i][j] = 0;
        } else if (sum_n % 4 == 1){
          new_grid[i][j] = 1;
        }else if (sum_n % 4 == 2) {
          new_grid[i][j] = 2;
        }else if (sum_n % 4 == 3) {
          new_grid[i][j] = 3;
        }
      }
    }
    count += 1;
    return new_grid;
  }
  
  int count_row(int[][] grid) {
    int result = 0;
    for (int i = 0; i < grid.length; i++) {
      int mycount = 0;
      for (int j = 0; j < grid[0].length; j++){
        mycount += grid[i][j];
      }
      if(mycount > 0){
         result += 1;
      }
    }
    return result;
  }
  
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
  
  void show(int[][] grid, float angle){
    int counts = count_row2(grid);
    int[][] small_grid = copy_by_center(counts, grid);

    background(#7cd6cf);
    for (int i = 0; i < small_grid.length; i++){
      for (int j = 0; j < small_grid[0].length; j++){
        if (small_grid[i][j] > 0) {
         //fill(255, 0, 181);
         fill(99,map(small_grid[i][j],0,3,0,178),238);
         noStroke();
         push();
         translate((j+0.5)*width/counts,(i+0.5)*height/counts);
         rotate(radians(angle));
         rectMode(CENTER);
         rect(0,0,width/counts,height/counts);
         //rect((j+0.5)*width/counts,(i+0.5)*height/counts,width/counts,height/counts);
         pop();
        }
      }
    }
  }
}
