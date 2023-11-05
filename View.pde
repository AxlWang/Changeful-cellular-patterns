int count = 0;
float angle = 45;
String dir = "U";
Cell myCell = new Cell();

int[][] grid = new int[101][101];

void setup(){
  size(901,901, P3D);
  myCell.seed(grid, 3);
}

void draw(){
  if (count <= 3000) {
    //frameRate(5);
    myCell.show(grid, angle);
    if (count%60==1){
      grid = myCell.next_gen(grid);
    }
    angle += 0.5;
  }
  //else if (count > 2094){
  //  myAnt.show(grid);
  //  dir = myAnt.next_step(grid, dir);
  //}
  count += 1;
  
  //System.out.println("count: " + count);
}
