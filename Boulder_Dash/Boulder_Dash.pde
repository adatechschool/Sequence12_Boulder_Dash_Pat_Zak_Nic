// initialize variables 
int sizeCell = 40;
PImage mur, terre, joueur, playerWalked, boulder, wasted, mort, diamond, door;
int[][] playingField;
float wallChance = 0.1;
float boulderChance = wallChance + 0.2;
float diamondChance = boulderChance + 0.08;
float gen_tile;
int wallElement = 0;
int dirtElement = 1;
int boulderElement = 2;
int walkedElement = 3;
int diamondElement = 4;
int doorElement = 5;
int maxDiamond = 6;
boolean isDead = false;
int x, y;

// generate gameboard and save it in a table
// load images
void setup() {
  //print(width/sizeCell, " ",height/sizeCell);
  size(800, 800);
  background(0);
  playingField = new int[width/sizeCell][height/sizeCell];
  mur = loadImage("mur.png");
  terre = loadImage("terre.png");
  playerWalked = loadImage("Player_walked.jpg");
  boulder = loadImage("pierre.jpg");
  wasted = loadImage("wasted.png");
  diamond = loadImage("diamant.png");
  joueur = loadImage("characterright.png");
  door = loadImage("porte.png");
  x = 0;
  y = 0;

  int diamondCounter = 0;
  for (int i = 0; i < width/sizeCell; i++) {
    for (int j = 0; j < height/sizeCell; j++) {
      gen_tile = random(1);
      if (gen_tile < wallChance) {
        playingField[i][j] = wallElement;
      } else if (gen_tile < boulderChance) {
        playingField[i][j] = boulderElement;
      } else if (gen_tile < diamondChance && diamondCounter < maxDiamond) {
        playingField[i][j] = diamondElement;
        diamondCounter++;
      } else {
        playingField[i][j] = dirtElement;
      }
    }
  }
  playingField[0][0] = walkedElement;
}

void draw() {
  for (int i = 0; i < width/sizeCell; i++) {
    for (int j = 0; j < height/sizeCell; j++) {
      int x = i*sizeCell;
      int y = j*sizeCell;
      checkBoulderState();
      if (playingField[i][j] == wallElement) {
        image(mur, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == dirtElement) { 
        image(terre, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == walkedElement) { 
        image(playerWalked, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == boulderElement) {
        image(boulder, x, y, sizeCell, sizeCell);
      } else if (playingField[i][j] == diamondElement) {
        image(terre, x, y, sizeCell, sizeCell);
        image(diamond, x, y, sizeCell, sizeCell);
      }
    }
  }
  
  image(joueur, x, y, sizeCell, sizeCell);
  if (isDead) {
    image(wasted, 0, 0);
  }  
  checkBoulderState();
}

void keyPressed() {
  if (keyCode == ENTER) {
    setup();
    isDead = false;
  }
  
  if (isDead) {
    return;
  }
  if (keyCode == RIGHT) {
    if (x < width - sizeCell) {
      if ((playingField[(x/sizeCell) + 1][y/sizeCell] == wallElement) || (playingField[(x/sizeCell) + 1][y/sizeCell] == boulderElement)) {
        return;
      }
      x += sizeCell;
      joueur = loadImage("characterright.png");
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
  } else if (keyCode == LEFT) {
    if (x > 0) {
      if ((playingField[(x/sizeCell) - 1][y/sizeCell] == wallElement) || (playingField[(x/sizeCell) - 1][y/sizeCell] == boulderElement)) {
        return;
      }
      x -= sizeCell;
      joueur = loadImage("characterleft.png");
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
  } else if (keyCode == DOWN) {
    if (y < height - sizeCell) {
      if ((playingField[x/(sizeCell)][(y/sizeCell) + 1] == wallElement) || (playingField[x/(sizeCell)][(y/sizeCell) + 1] == boulderElement)) {
        return;
      }
      y += sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }
  } else if (keyCode == UP) {
    if (y > 0) {
      if ((playingField[x/(sizeCell)][(y/sizeCell) - 1] == wallElement) || (playingField[x/(sizeCell)][(y/sizeCell) - 1] == boulderElement)){
        return;
      }
      y -= sizeCell;
      playingField[x/sizeCell][y/sizeCell] = walkedElement;
    }  
  }
}

void checkBoulderState() {
  try {
    if ((playingField[x/sizeCell][(y/sizeCell) - 2] == boulderElement) && (playingField[x/sizeCell][(y/sizeCell) - 1] == walkedElement)) {
      playingField[x/sizeCell][y/sizeCell] = boulderElement;
       playingField[x/sizeCell][(y/sizeCell) - 2] = walkedElement;
       if (playingField[x/sizeCell][(y/sizeCell)] == boulderElement) {
         isDead = true;
         joueur = loadImage("mort.png");
       }
         
    }
  } catch(Exception e) {}
  try {
    if ((playingField[x/sizeCell - 1][(y/sizeCell) - 1] == boulderElement) && (playingField[x/sizeCell - 1][y/sizeCell] == walkedElement)) {
      int boulderX = x/sizeCell - 1;
      int boulderY = y/sizeCell - 1;
      int boulderYMemory = boulderY;
      for (int i = 0; i < height/sizeCell; i++) {
        playingField[boulderX][boulderY + 1] = boulderElement;
        playingField[boulderX][boulderY] = walkedElement;
        boulderY++;
        if (playingField[boulderX][boulderY + 1] != walkedElement) {
          checkBoulderState();
          break;
        }
      }
    }
  } catch(Exception e) {}
  try {
      if ((playingField[x/sizeCell + 1][(y/sizeCell) - 1] == boulderElement) && (playingField[x/sizeCell + 1][y/sizeCell] == walkedElement)) {
      int boulderX = x/sizeCell + 1;
      int boulderY = y/sizeCell - 1;
      int boulderYMemory = boulderY;
      for (int i = 0; i < height/sizeCell; i++) {
        playingField[boulderX][boulderY + 1] = boulderElement;
        playingField[boulderX][boulderY] = walkedElement;
        boulderY++;
        if (playingField[boulderX][boulderY + 1] != walkedElement) {
          break;
        }
      }
    }
  } catch (Exception e) {}
}

void reset() {
  //reset board  
}
