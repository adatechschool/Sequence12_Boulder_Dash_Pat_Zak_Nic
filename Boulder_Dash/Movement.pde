void keyPressed() {
  if (keyCode == ENTER) {
    setup();
    gameState = true;
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
