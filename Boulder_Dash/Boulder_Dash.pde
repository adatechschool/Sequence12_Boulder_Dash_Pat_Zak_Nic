int sizeCell = 80;
int fieldHeight = 800;
int fieldWidth = 800;
int x = 0;
int y = 0;
PImage mur, terre, joueur, playerWalked;
int[][] playingField = new int[fieldHeight/sizeCell][fieldWidth/sizeCell];

void setup() {
  size(800, 800);
  background(0);
  mur = loadImage("mur.png");
  terre = loadImage("terre.png");
  playerWalked = loadImage("Player_walked.jpg");

  for (int i = 0; i < fieldHeight/sizeCell; i++) {
    for (int j = 0; j < fieldWidth/sizeCell; j++) {
      playingField[i][j] = round(random(1));
    }
  }
  playingField[0][0] = 2;
}

void draw() {
  for (int i = 0; i < fieldHeight/sizeCell; i++) {
    for (int j = 0; j < fieldWidth/sizeCell; j++) {
      int x = i*sizeCell;
      int y = j*sizeCell;
      if (playingField[i][j] == 0) {
        image(mur, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == 1) { 
        image(terre, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == 2) { 
        image(playerWalked, x, y, sizeCell, sizeCell);
      }
    }
  }
  joueur = loadImage("character.png");
  image(joueur, x, y, sizeCell, sizeCell);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    if (x < fieldWidth - sizeCell) {
      if (playingField[(x/sizeCell) + 1][y/sizeCell] == 0) {
        return;
      }
      x += sizeCell;
      playingField[x/sizeCell][y/sizeCell] = 2;
    }
    keyPressed = false;
  } else if (keyCode == LEFT) {
    if (x > 0) {
      if (playingField[(x/sizeCell) - 1][y/sizeCell] == 0) {
        return;
      }
      x -= sizeCell;
      playingField[x/sizeCell][y/sizeCell] = 2;
    }
    keyPressed = false;
  } else if (keyCode == DOWN) {
    if (y < fieldHeight - sizeCell) {
      if (playingField[x/(sizeCell)][(y/sizeCell) + 1] == 0) {
        return;
      }
      y += sizeCell;
      playingField[x/sizeCell][y/sizeCell] = 2;
    }
    keyPressed = false;
  } else if (keyCode == UP) {
    if (y > 0) {
      if (playingField[x/(sizeCell)][(y/sizeCell) - 1] == 0) {
        return;
      }
      y -= sizeCell;
      playingField[x/sizeCell][y/sizeCell] = 2;
    }  
    keyPressed = false;
  }
}
