void mouseMoved(){
  //menu.process();
}

void mousePressed() {
  //menu.process();
  //menu.behaviour();

  if (gameState == MENU) {

    if (
      mouseX >= width / 2 - 120 &&
      mouseX <= width / 2 + 120 &&
      mouseY >= 410 &&
      mouseY <= 480
      ) {

      gameState = GAME;

      startLevel(0);
    }

    return;
  }

  // ----------------------------------------------------------
  // RESULT
  // ----------------------------------------------------------

  if (gameState == RESULT) {

    if (
      mouseX >= width / 2 - 120 &&
      mouseX <= width / 2 + 120 &&
      mouseY >= 470 &&
      mouseY <= 540
      ) {

      score = 0;

      startLevel(0);

      gameState = GAME;
    }

    return;
  }

  // ----------------------------------------------------------
  // GAME
  // ----------------------------------------------------------

  if (gameState != GAME) {
    return;
  }

  if (running || levelComplete) {
    return;
  }

  int panelX = 650;

  // MOVE
  if (
    mouseX >= panelX + 25 &&
    mouseX <= panelX + 130 &&
    mouseY >= 505 &&
    mouseY <= 550
    ) {

    addCommand(Command.MOVE);

    return;
  }

  // LEFT
  if (
    mouseX >= panelX + 145 &&
    mouseX <= panelX + 250 &&
    mouseY >= 505 &&
    mouseY <= 550
    ) {

    addCommand(Command.LEFT);

    return;
  }

  // RIGHT
  if (
    mouseX >= panelX + 265 &&
    mouseX <= panelX + 365 &&
    mouseY >= 505 &&
    mouseY <= 550
    ) {

    addCommand(Command.RIGHT);

    return;
  }

  // RUN
  if (
    mouseX >= panelX + 25 &&
    mouseX <= panelX + 130 &&
    mouseY >= 565 &&
    mouseY <= 610
    ) {

    runProgram();

    return;
  }

  // DELETE
  if (
    mouseX >= panelX + 145 &&
    mouseX <= panelX + 250 &&
    mouseY >= 565 &&
    mouseY <= 610
    ) {

    deleteCommand();

    return;
  }

  // CLEAR
  if (
    mouseX >= panelX + 265 &&
    mouseX <= panelX + 365 &&
    mouseY >= 565 &&
    mouseY <= 610
    ) {

    program.clear();

    message = "Program dibersihkan.";
    messageColor = TEXT_COLOR;

    return;
  }
}
