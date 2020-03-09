class Draw_Board {
  
  void mainDraw() {
    drawTable();
    drawPlayer();
  }
  
  void drawTable() {
    for (int i = 0; i < width/sizeCell; i++) {
      for (int j = 0; j < height/sizeCell; j++) {
        int x_draw = i*sizeCell;
        int y_draw = j*sizeCell;
        if (playingField[i][j] == wallElement) {
          image(mur, x_draw, y_draw, sizeCell, sizeCell);
        } else if (playingField[i][j] == dirtElement) { 
          image(terre, x_draw, y_draw, sizeCell, sizeCell);
        } else if (playingField[i][j] == walkedElement) { 
          image(playerWalked, x_draw, y_draw, sizeCell, sizeCell);
        } else if (playingField[i][j] == boulderElement) {
          image(boulder, x_draw, y_draw, sizeCell, sizeCell);
        } else if (playingField[i][j] == diamondElement) {
          image(terre, x_draw, y_draw, sizeCell, sizeCell);
          image(diamond, x_draw, y_draw, sizeCell, sizeCell);
        } else if (playingField[i][j] == doorElement) {
          image(terre, x_draw, y_draw, sizeCell, sizeCell);
          image(door, x_draw, y_draw, sizeCell, sizeCell);
        } else if (playingField[i][j] == boulderDestroyedElement) {
          image(playerWalked, x_draw, y_draw, sizeCell, sizeCell);
          image(boulderDestroyed, x_draw, y_draw, sizeCell, sizeCell);
        }
      }
    }
  }
  
  void drawPlayer() {
    image(joueur, x, y, sizeCell, sizeCell);
    if (isDead) {
      image(wasted, 0, 0, width, height);
    }  
  }
}

Draw_Board drawBoard;
