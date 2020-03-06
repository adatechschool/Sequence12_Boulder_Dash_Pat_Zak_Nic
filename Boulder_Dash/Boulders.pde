class Boulder {
  
  void boulderBehave() {
    boulderCrush();
    boulderLeft();
    boulderRight();
  }
  
  void boulderCrush() {
    try {
      if ((playingField[x/sizeCell][(y/sizeCell) - 2] == boulderElement) && (playingField[x/sizeCell][(y/sizeCell) - 1] == walkedElement)) {
        playingField[x/sizeCell][y/sizeCell] = boulderElement;
         playingField[x/sizeCell][(y/sizeCell) - 2] = walkedElement;
         if (playingField[x/sizeCell][(y/sizeCell)] == boulderElement) {
           isDead = true;
           joueur = loadImage("Sprites/mort.png");
         }
      }
    } catch(Exception e) {}
  }

  void boulderLeft() {
    try {
      if ((playingField[x/sizeCell - 1][(y/sizeCell) - 1] == boulderElement) && (playingField[x/sizeCell - 1][y/sizeCell] == walkedElement)) {
        int boulderX = x/sizeCell - 1;
        int boulderY = y/sizeCell - 1;
        for (int i = 0; i < height/sizeCell; i++) {
          playingField[boulderX][boulderY + 1] = boulderElement;
          playingField[boulderX][boulderY] = walkedElement;
          boulderY++;
          if (playingField[boulderX][boulderY + 1] != walkedElement) {            checkBoulderState();
            break;
          }
        }
      }
    } catch(Exception e) {}
  }
  
  void boulderRight() {
    try {
        if ((playingField[x/sizeCell + 1][(y/sizeCell) - 1] == boulderElement) && (playingField[x/sizeCell + 1][y/sizeCell] == walkedElement)) {
        int boulderX = x/sizeCell + 1;
        int boulderY = y/sizeCell - 1;
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
}

Boulder boulderBehaviour;
