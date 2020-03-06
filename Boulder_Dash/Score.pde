class Score {

  void printScore() {
    showDiamondScore();
    showBoulderScore();
  }

  void showDiamondScore() {
    String diamondPoints = diamondCollected + " Diamonds collected !";
    textFont(diamondpoints, 100);
    fill(0, 0, 0);
    text(diamondPoints, width/15, height - 40);
  }
  
  void showBoulderScore() {
    String boulderPoints = boulderDestroyedCounter + " Boulders destroyed !";
    textFont(diamondpoints, 100);
    fill(0, 0, 0);
    text(boulderPoints, width/15, height - 80);  
  }
}


Score printAllScore;
