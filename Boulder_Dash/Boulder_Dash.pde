// initialize variables 
int sizeCell = 80;
int fieldHeight = 800;
int fieldWidth = 800;
int x = 0;
int y = 0;
PImage mur, terre, joueur, playerWalked, boulder;
int[][] playingField = new int[fieldHeight/sizeCell][fieldWidth/sizeCell];
float wallChance = 0.2;
float boulderChance = wallChance + 0.05;
float gen_tile;
int wallElement = 0;
int dirtElement = 1;
int boulderElement = 2;
int walkedElement = 3;

// generate gameboard and save it in a table
// load images
void setup() {
  size(800, 800);
  background(0);
  mur = loadImage("mur.png");
  terre = loadImage("terre.png");
  playerWalked = loadImage("Player_walked.jpg");
  boulder = loadImage("pierre.jpg");

  for (int i = 0; i < fieldHeight/sizeCell; i++) {
    for (int j = 0; j < fieldWidth/sizeCell; j++) {
      gen_tile = random(1);
      print(gen_tile, " ");
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
      checkBoulderState();
      if (playingField[i][j] == wallElement) {
        image(mur, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == dirtElement) { 
        image(terre, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == walkedElement) { 
        image(playerWalked, x, y, sizeCell, sizeCell);
      } else if ( (playingField[i][j] == boulderElement)) {
        image(boulder, x, y, sizeCell, sizeCell);
      }
    }
  }
  joueur = loadImage("character.png");
  image(joueur, x, y, sizeCell, sizeCell);
  checkBoulderState();
}

void keyPressed() {
  if (keyCode == RIGHT) {
    if (x < fieldWidth - sizeCell) {
      if ((playingField[(x/sizeCell) + 1][y/sizeCell] == wallElement) || (playingField[(x/sizeCell) + 1][y/sizeCell] == boulderElement)) {
        return;
      }
      x += sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
    keyPressed = false;
  } else if (keyCode == LEFT) {
    if (x > 0) {
      if ((playingField[(x/sizeCell) - 1][y/sizeCell] == wallElement) || (playingField[(x/sizeCell) - 1][y/sizeCell] == boulderElement)) {
        return;
      }
      x -= sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
    keyPressed = false;
  } else if (keyCode == DOWN) {
    if (y < fieldHeight - sizeCell) {
      if ((playingField[x/(sizeCell)][(y/sizeCell) + 1] == wallElement) || (playingField[x/(sizeCell)][(y/sizeCell) + 1] == boulderElement)) {
        return;
      }
      y += sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
    keyPressed = false;
  } else if (keyCode == UP) {
    if (y > 0) {
      if ((playingField[x/(sizeCell)][(y/sizeCell) - 1] == wallElement) || (playingField[x/(sizeCell)][(y/sizeCell) - 1] == boulderElement)){
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
    if ((playingField[x/sizeCell][(y/sizeCell) - 2] == boulderElement) && (playingField[x/sizeCell][(y/sizeCell) - 1] == walkedElement)) {
      playingField[x/sizeCell][y/sizeCell] = boulderElement;
       playingField[x/sizeCell][(y/sizeCell) - 2] = walkedElement;
    }
    if (playingField[x/sizeCell + 1][(y/sizeCell) + 1] == boulderElement) {
      playingField[x/sizeCell][y/sizeCell + 1] = boulderElement;
      playingField[x/sizeCell][(y/sizeCell)] = walkedElement;
    }
    
  } catch(Exception e) {}
}
