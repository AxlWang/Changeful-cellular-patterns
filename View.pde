int count = 0;
float angle = 45;
int cnum = 5;
import gifAnimation.*;
GifMaker gif;
// String dir = "U";
Cell myCell = new Cell();

int[][] grid = new int[101][101];

void setup(){
  size(901,901, P3D);
  myCell.seed(grid, 3);
  gif = new GifMaker(this,"gif.gif");
  gif.setRepeat(0); //设置gif重复播放的次数，0为循环播放
  gif.setDelay(500); //设置帧与帧之间的延迟时间，单位为毫秒，数值为40 帧率为25
}

void draw(){
  if (count <= 3000) {
    //frameRate(5);
    myCell.show(grid, angle);
    if (count%60==1){
      grid = myCell.next_gen(grid, cnum);
      gif.addFrame();
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

void mousePressed(){
  gif.finish();//点击鼠标导出gif
}
