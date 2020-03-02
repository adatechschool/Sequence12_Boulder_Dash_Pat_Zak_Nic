int sizeCell = 80;
int[][] playingField;
int fieldHeight = 800;
int fieldWidth = 800;
int x = 0;
int y = 0;


void setup() {
  size(800, 800);
  background(0);
  
  for(int i = 0; i < fieldHeight/sizeCell; i++) {
    for (int j = 0; j < fieldWidth/sizeCell; j++) {
      int x = i*sizeCell;
      int y = j*sizeCell;
      color(255); 
      stroke(255, 0, 0);
      rect(x, y, sizeCell, sizeCell);
    }
  }
}
