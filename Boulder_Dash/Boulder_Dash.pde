// initialize variables 
int sizeCell = 50;
PImage mur, terre, joueur, playerWalked, boulder, wasted, mort, diamond, door, boulderDestroyed, start;
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
int boulderDestroyedElement = 6;
boolean isDead = false;
int x, y;
boolean playerWalked_Door = false;
float diamondCounter;
int diamondCollected;
boolean gameState;




// generate gameboard and save it in a table
// load images
void setup() {
  gameState = false;
  boulderBehaviour = new Boulder();
  printAllScore = new Score();
  drawBoard = new Draw_Board();
  diamondCounter= 0;
  boulderDestroyedCounter = 0;
  diamondCollected = 0;
  //print(width/sizeCell, " ",height/sizeCell);
  size(800, 800);
  background(0);
  playingField = new int[width/sizeCell][height/sizeCell];
  mur = loadImage("Sprites/mur.png");
  terre = loadImage("Sprites/terre.png");
  playerWalked = loadImage("Sprites/Player_walked.jpg");
  boulder = loadImage("Sprites/pierre.jpg");
  boulderDestroyed = loadImage("Sprites/pierrecassee.png");
  wasted = loadImage("Sprites/wasted.png");
  diamond = loadImage("Sprites/diamant.png");
  joueur = loadImage("Sprites/characterright.png");
  door = loadImage("Sprites/porte.png");
  start = loadImage("Sprites/icyboulderdash.jpg");
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

  if (gameState) {
    boulderBehaviour.boulderBehave();
    drawBoard.mainDraw();
    printAllScore.printScore();
  } else {
    image(start, 0, 0, width, height);
  }
  
  
  
  if (playingField[x/sizeCell][y/sizeCell] == doorElement && diamondCounter*0.80 <= diamondCollected) {
    setup();
  }
}

void diamondCollected() {
  if (playingField[x/sizeCell][(y/sizeCell)] == diamondElement) {
    diamondCollected++;
  }  
}
