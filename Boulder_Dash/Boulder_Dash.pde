int sizeCell = 80;
int fieldHeight = 800;
int fieldWidth = 800;
int x = 0;
int y = 0;
PImage mur, terre, joueur, playerWalked;
int[][] playingField = new int[fieldHeight/sizeCell][fieldWidth/sizeCell];
float wallChance = 0.1;
float boulderChance = 0.2;
float gen_tile;
int wallElement = 0;
int dirtElement = 1;
int boulderElement = 2;
int walkedElement = 3;

void setup() {
  size(800, 800);
  background(0);
  mur = loadImage("mur.png");
  terre = loadImage("terre.png");
  playerWalked = loadImage("Player_walked.jpg");

  for (int i = 0; i < fieldHeight/sizeCell; i++) {
    for (int j = 0; j < fieldWidth/sizeCell; j++) {
      gen_tile = random(1);
      if (gen_tile < wallChance) {
        playingField[i][j] = wallElement;
      } else if (gen_tile < boulderChance) {
        playingField[i][j] = boulderElement;
      } else {
        playingField[i][j] = dirtElement;
      }
    }
  }
  playingField[0][0] = walkedElement;
}

void draw() {
  for (int i = 0; i < fieldHeight/sizeCell; i++) {
    for (int j = 0; j < fieldWidth/sizeCell; j++) {
      int x = i*sizeCell;
      int y = j*sizeCell;
      if (playingField[i][j] == wallElement) {
        image(mur, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == dirtElement) { 
        image(terre, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == walkedElement) { 
        image(playerWalked, x, y, sizeCell, sizeCell);
      } else if ( (playingField[i][j] == boulderElement)) {
        image(terre, x, y, sizeCell, sizeCell);
        fill(255, 0, 0);
        circle(x+40, y+40, 80);
      }
    }
  }
  joueur = loadImage("character.png");
  image(joueur, x, y, sizeCell, sizeCell);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    if (x < fieldWidth - sizeCell) {
      if (playingField[(x/sizeCell) + 1][y/sizeCell] == wallElement) {
        return;
      }
      checkBoulderState();
      x += sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
    keyPressed = false;
  } else if (keyCode == LEFT) {
    if (x > 0) {
      if (playingField[(x/sizeCell) - 1][y/sizeCell] == wallElement) {
        return;
      }
      x -= sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
    keyPressed = false;
  } else if (keyCode == DOWN) {
    if (y < fieldHeight - sizeCell) {
      if (playingField[x/(sizeCell)][(y/sizeCell) + 1] == wallElement) {
        return;
      }
      y += sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
    keyPressed = false;
  } else if (keyCode == UP) {
    if (y > 0) {
      if (playingField[x/(sizeCell)][(y/sizeCell) - 1] == wallElement) {
        return;
      }
      y -= sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }  
    keyPressed = false;
  }
}

void checkBoulderState() {
  try {
    if (playingField[x/sizeCell][(y/sizeCell) - 1] == boulderElement) {
    print("ayyyyy"); }
  } catch(Exception e) {
    print("error");
  }
/*  for (int i = 0; i < fieldHeight/sizeCell; i++) {
    for (int j = 0; j < fieldWidth/sizeCell; j++) {
      int x = i*sizeCell;
      int y = j*sizeCell;
      if (playingField[i][j] == dirtElement && boulderChance > random(1)) {
        fill(255, 0, 0);
        circle(x+40, y+40, 80);
      } else {
      }
    }
  } */
}
