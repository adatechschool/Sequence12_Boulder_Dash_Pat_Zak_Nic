// initialize variables 
int sizeCell = 50;
PImage mur, terre, joueur, playerWalked, boulder, wasted, mort, diamond, door;
PFont diamondpoints;
int[][] playingField;
float wallChance = 0.2;
float boulderChance = wallChance + 0.1;
float diamondChance = boulderChance + 0.04;
float gen_tile;
int wallElement = 0;
int dirtElement = 1;
int boulderElement = 2;
int walkedElement = 3;
int diamondElement = 4;
int doorElement = 5;
boolean isDead = false;
int x, y;
boolean playerWalked_Door = false;
float diamondCounter;
int diamondCollected;



// generate gameboard and save it in a table
// load images
void setup() {
  boulderBehaviour = new Boulder();
  diamondCounter= 0;
  diamondCollected = 0;
  //print(width/sizeCell, " ",height/sizeCell);
  size(800, 800);
  background(0);
  playingField = new int[width/sizeCell][height/sizeCell];
  mur = loadImage("Sprites/mur.png");
  terre = loadImage("Sprites/terre.png");
  playerWalked = loadImage("Sprites/Player_walked.jpg");
  boulder = loadImage("Sprites/pierre.jpg");
  wasted = loadImage("Sprites/wasted.png");
  diamond = loadImage("Sprites/diamant.png");
  joueur = loadImage("Sprites/characterright.png");
  door = loadImage("Sprites/porte.png");
  diamondpoints = createFont("data/game_over.ttf", 32);

  x = 0;
  y = 0;

 
  for (int i = 0; i < width/sizeCell; i++) {
    for (int j = 0; j < height/sizeCell; j++) {
      gen_tile = random(1);
      if (gen_tile < wallChance) {
        playingField[i][j] = wallElement;
      } else if (gen_tile < boulderChance) {
        playingField[i][j] = boulderElement;
      } else if (gen_tile < diamondChance) {
        playingField[i][j] = diamondElement;
        diamondCounter++;
      } else {
        playingField[i][j] = dirtElement;
      }
    }
  }
  playingField[0][0] = walkedElement;
  playingField[(height/sizeCell) - 1][(width/sizeCell) - 1] = doorElement;
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
      } else if (playingField[i][j] == doorElement) {
        image(terre, x, y, sizeCell, sizeCell);
        image(door, x, y, sizeCell, sizeCell);
      }
    }
  }
  
  image(joueur, x, y, sizeCell, sizeCell);
  if (isDead) {
    image(wasted, 0, 0);
  }  
  
  boulderBehaviour.boulderBehave();
  if (playingField[x/sizeCell][y/sizeCell] == doorElement && diamondCounter*0.80 <= diamondCollected) {
    setup();
  }

  String textePoints = diamondCollected + " Diamonds collected !";
  textFont(diamondpoints, 100);
  fill(0, 0, 0);
  text(textePoints, width/15, height - 40);
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
      diamondCollected();
      joueur = loadImage("Sprites/characterright.png");
      if (playingField[x/sizeCell][y/sizeCell] != doorElement) {
        playingField[x/sizeCell][y/sizeCell] = walkedElement;
      }
    }
  } else if (keyCode == LEFT) {
    if (x > 0) {
      if ((playingField[(x/sizeCell) - 1][y/sizeCell] == wallElement) || (playingField[(x/sizeCell) - 1][y/sizeCell] == boulderElement)) {
        return;
      }
      x -= sizeCell;
      diamondCollected();
      joueur = loadImage("Sprites/characterleft.png");
      if (playingField[x/sizeCell][y/sizeCell] != doorElement) {
        playingField[x/sizeCell][y/sizeCell] = walkedElement;
      }
    }
  } else if (keyCode == DOWN) {
    if (y < height - sizeCell) {
      if ((playingField[x/(sizeCell)][(y/sizeCell) + 1] == wallElement) || (playingField[x/(sizeCell)][(y/sizeCell) + 1] == boulderElement)) {
        return;
      }
      y += sizeCell;
      diamondCollected();
      if (playingField[x/sizeCell][y/sizeCell] != doorElement) {
        playingField[x/sizeCell][y/sizeCell] = walkedElement;
      }
    }
  } else if (keyCode == UP) {
    if (y > 0) {
      if ((playingField[x/(sizeCell)][(y/sizeCell) - 1] == wallElement) || (playingField[x/(sizeCell)][(y/sizeCell) - 1] == boulderElement)){
        return;
      }
      y -= sizeCell;
      diamondCollected();
      if (playingField[x/sizeCell][y/sizeCell] != doorElement) {
        playingField[x/sizeCell][y/sizeCell] = walkedElement;
      }
    }  
  }
}




void diamondCollected() {
  if (playingField[x/sizeCell][(y/sizeCell)] == diamondElement) {
    diamondCollected++;
  }  
}







void checkBoulderState() {
  
  
  
}
