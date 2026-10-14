class Player {
  int x, y;
  int direction;

  Player(int startX, int startY, int startDirection) {
    this.x = startX;
    this.y = startY;
    this.direction = startDirection;
  }

  void turnLeft() {
    this.direction--;
    if (direction < 0) direction = 3;
  }

  void turnRight() {
    direction++;

    if (direction > 3) {
      direction = 0;
    }
  }

  void draw() {
    float cx = gridX + (x * cellSize) + (cellSize / 2);
    float cy = gridY + (y * cellSize) + (cellSize / 2);

    // Robot body
    fill(ACCENT);
    noStroke();
    rect(cx - 22, cy - 22, 44, 44, 10);

    // Robot screen
    fill(color(20, 30, 40));
    rect(cx - 14, cy - 12, 28, 20, 5);

    // Eyes
    fill(GREEN);

    ellipse(cx - 7, cy - 2, 5, 5);
    ellipse(cx + 7, cy - 2, 5, 5);

    // Direction indicator
    pushMatrix();
    translate(cx, cy);

    float angle = direction * HALF_PI;
    rotate(angle);

    fill(YELLOW);
    triangle(0, -32, -7, -20, 7, -20);
    popMatrix();
  }
}
