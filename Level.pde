class Level {
  int id, maxCommands, startX, startY, startDirection;
  int goalX, goalY;
  int[] wallX, wallY;
  String description;

  Level(int id, int maxCommands,
    int startX, int startY, int startDirection,
    int goalX, int goalY,
    int[] wallX, int[] wallY,
    String description
    ) {
    this.id = id;
    this.maxCommands = maxCommands;

    this.startX = startX;
    this.startY = startY;
    this.startDirection = startDirection;

    this.goalX = goalX;
    this.goalY = goalY;

    this.wallX = wallX;
    this.wallY = wallY;

    this.description = description;
  }
}
