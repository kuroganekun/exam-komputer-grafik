/*
 * CODE RUNNER
 * Educational Game PoC
 * Processing Java
 *
 * Controls:
 * - Click command buttons to build a program
 * - RUN    : execute the program
 * - DELETE : remove last command
 * - CLEAR  : clear all commands
 * - RESET  : reset current level
 *
 * Keyboard:
 * - R : Run
 * - C : Clear commands
 * - Backspace : Delete last command
 * - 1 : MOVE
 * - 2 : TURN LEFT
 * - 3 : TURN RIGHT
 * - 4 : WAIT
 */

// ============================================================
// GAME STATE
// ============================================================

final int MENU     = 0;
final int GAME     = 1;
final int RESULT   = 2;
private final int DEFAULT_LIFE = 3;

int gameState = MENU;

// ============================================================
// COLORS
// ============================================================

color BG_COLOR       = color(18, 22, 30);
color PANEL_COLOR    = color(28, 34, 45);
color GRID_COLOR     = color(45, 53, 68);

color TEXT_COLOR     = color(235, 240, 245);
color MUTED_COLOR    = color(150, 160, 175);

color ACCENT         = color(80, 180, 255);
color GREEN          = color(75, 210, 130);
color RED            = color(240, 90, 100);
color YELLOW         = color(245, 195, 75);
color PURPLE         = color(170, 120, 240);

// ============================================================
// SCREEN
// ============================================================

int SCREEN_W = 1100;
int SCREEN_H = 720;

// ============================================================
// GRID
// ============================================================

int cols = 8;
int rows = 6;

int cellSize = 70;

int gridX = 60;
int gridY = 120;

// ============================================================
// GAME OBJECTS
// ============================================================

Player player;
Goal goal;

ArrayList<Wall> walls = new ArrayList<>();
ArrayList<Command> program = new ArrayList<>();

ArrayList<Level> levels = new ArrayList<>();

int currentLevel = 0;

boolean running = false;
boolean levelComplete = false;
boolean gameOver = false;

int executionIndex = 0;
int executionTimer = 0;

int EXECUTION_DELAY = 20;
int currentLives = DEFAULT_LIFE;

STATE currentState;
Menu menu;

// ============================================================
// SCORE
// ============================================================

int score = 0;
int movesUsed = 0;

// ============================================================
// MESSAGE
// ============================================================

String message = "";
color messageColor = TEXT_COLOR;

// ============================================================
// SETUP
// ============================================================

void setup() {

  size(1024, 768);

  textFont(createFont("Arial", 16));
  program = new ArrayList<Command>(); // Inisialisasi command list
  levels = new ArrayList<Level>();  // Inisialisasi Level
  initializeLevels(); // Tambahkan level
  startLevel(0);
  
  //this.initialize();
  
}

void initialize(){
  
  levels.add(new Level(1, 5, //id, maxCommands
      1, 3, 1, //startX, startY, startDirection
      6, 3, //GoalX, GoalY
      new int[] {3, 3, 3}, // Wall X
      new int[] {1, 2, 4}, // Wall Y
      "Gunakan MOVE untuk mencapai bintang." //Description
      )
    );
    
  levels.add(new Level(2, 6,
      1, 5, 3,
      1, 1,
      new int[] {2, 2, 4, 5},
      new int[] {3, 4, 4, 2},
      "Robot harus berbelok untuk mencapai target."
      )
    );
    
  menu = new MainMenu();
  currentState = STATE.MENU;
  menu.update();
}

// ============================================================
// DRAW
// ============================================================

void draw() {

  background(BG_COLOR);
  //menu.render();
  //System.out.println("Current state "+ currentState);
  //menu.update();

  if (gameState == MENU) {
    drawMenu();
  } else if (gameState == GAME) {
    if(currentLives > 1){
      drawGame();
    }else {
      drawGameOver();
    }
    
  } else if (gameState == RESULT) {
    drawResult();
  }
}

void drawGameOver(){
  System.out.println("GAME OVER!");
}

// ============================================================
// MENU
// ============================================================

void drawMenu() {

  textAlign(CENTER, CENTER);

  fill(ACCENT);
  textSize(58);
  text("CODE RUNNER", width / 2, 180);

  fill(TEXT_COLOR);
  textSize(22);
  text("Belajar algoritma melalui permainan", width / 2, 245);

  // Description
  fill(MUTED_COLOR);
  textSize(16);

  text(
    "Susun instruksi untuk membantu robot mencapai target.",
    width / 2,
    310
    );

  text(
    "Gunakan MOVE, TURN LEFT, dan TURN RIGHT.",
    width / 2,
    340
    );

  // Start button
  //drawButton(
  //  width / 2 - 120,
  //  410,
  //  240,
  //  70,
  //  "START GAME",
  //  ACCENT
  //  );

  fill(MUTED_COLOR);
  textSize(14);
  text(
    "PoC Educational Game — Processing Java",
    width / 2,
    620
    );
}

// ============================================================
// GAME
// ============================================================

void drawGame() {

  drawHeader();

  drawGrid();

  drawCommandPanel();

  drawBottomInfo();

  updateExecution();
}

// ============================================================
// HEADER
// ============================================================

void drawHeader() {

  fill(PANEL_COLOR);
  noStroke();

  rect(
    0,
    0,
    width,
    80
    );

  fill(TEXT_COLOR);
  textAlign(LEFT, CENTER);
  textSize(24);

  text(
    "CODE RUNNER",
    35,
    40
    );

  fill(MUTED_COLOR);
  textSize(14);

  text(
    "LEVEL " + (currentLevel + 1) + " / " + levels.size(),
    230,
    40
    );

  text(
    "SCORE: " + score,
    400,
    40
    );

  // Status
  if (running) {

    fill(YELLOW);

    text(
      "RUNNING...",
      780,
      40
      );
  } else if (levelComplete) {

    fill(GREEN);

    text(
      "LEVEL COMPLETE!",
      780,
      40
      );
  } else {

    fill(MUTED_COLOR);

    text(
      "BUILD YOUR PROGRAM",
      780,
      40
      );
  }
}

// ============================================================
// GRID
// ============================================================

void drawGrid() {

  // Grid background
  fill(color(24, 29, 38));
  noStroke();

  rect(
    gridX,
    gridY,
    cols * cellSize,
    rows * cellSize
    );

  // Cells
  for (int y = 0; y < rows; y++) {

    for (int x = 0; x < cols; x++) {

      stroke(GRID_COLOR);
      strokeWeight(1);
      noFill();

      rect(
        gridX + x * cellSize,
        gridY + y * cellSize,
        cellSize,
        cellSize
        );
    }
  }

  // Walls
  for (Wall wall : walls) {

    fill(color(65, 72, 85));
    noStroke();

    rect(
      gridX + wall.x * cellSize + 5,
      gridY + wall.y * cellSize + 5,
      cellSize - 10,
      cellSize - 10,
      8
      );

    fill(color(100, 108, 125));
    textAlign(CENTER, CENTER);
    textSize(22);

    text(
      "X",
      gridX + wall.x * cellSize + cellSize / 2,
      gridY + wall.y * cellSize + cellSize / 2
      );
  }

  // Goal
  drawGoal();

  // Robot
  player.draw();
}

// ============================================================
// GOAL
// ============================================================

void drawGoal() {

  float cx =
    gridX +
    goal.x * cellSize +
    cellSize / 2;

  float cy =
    gridY +
    goal.y * cellSize +
    cellSize / 2;

  fill(GREEN);
  noStroke();

  ellipse(
    cx,
    cy,
    42,
    42
    );

  fill(255);

  textAlign(CENTER, CENTER);
  textSize(18);

  text(
    "★",
    cx,
    cy
    );
}

// ============================================================
// COMMAND PANEL
// ============================================================

void drawCommandPanel() {

  int panelX = 650;
  int panelY = 120;

  fill(PANEL_COLOR);
  noStroke();

  rect(
    panelX,
    panelY,
    390,
    400,
    12
    );

  // Title
  fill(TEXT_COLOR);
  textAlign(LEFT, CENTER);
  textSize(20);

  text(
    "YOUR PROGRAM",
    panelX + 25,
    panelY + 30
    );

  // Program slots
  int slotY = panelY + 65;

  for (int i = 0; i < 8; i++) {

    int y = slotY + i * 38;

    fill(color(36, 43, 55));

    rect(
      panelX + 25,
      y,
      340,
      30,
      5
      );

    fill(MUTED_COLOR);

    textAlign(LEFT, CENTER);
    textSize(13);

    text(
      "" + (i + 1),
      panelX + 35,
      y + 15
      );

    if (i < program.size()) {

      Command cmd = program.get(i);

      fill(TEXT_COLOR);

      text(
        cmd.name,
        panelX + 65,
        y + 15
        );
    }
  }

  // Command buttons
  int buttonY = 505;

  //drawButton(
  //  panelX + 25,
  //  buttonY,
  //  105,
  //  45,
  //  "MOVE",
  //  ACCENT
  //  );

  //drawButton(
  //  panelX + 145,
  //  buttonY,
  //  105,
  //  45,
  //  "LEFT",
  //  PURPLE
  //  );

  //drawButton(
  //  panelX + 265,
  //  buttonY,
  //  100,
  //  45,
  //  "RIGHT",
  //  PURPLE
  //  );

  // Action buttons
  //drawButton(
  //  panelX + 25,
  //  565,
  //  105,
  //  45,
  //  "RUN",
  //  GREEN
  //  );

  //drawButton(
  //  panelX + 145,
  //  565,
  //  105,
  //  45,
  //  "DELETE",
  //  YELLOW
  //  );

  //drawButton(
  //  panelX + 265,
  //  565,
  //  100,
  //  45,
  //  "CLEAR",
  //  RED
  //  );
}

// ============================================================
// BOTTOM INFO
// ============================================================

void drawBottomInfo() {

  fill(PANEL_COLOR);
  noStroke();

  rect(
    60,
    570,
    560,
    80,
    10
    );

  fill(TEXT_COLOR);
  textAlign(LEFT, TOP);
  textSize(14);

  text(
    "GOAL",
    80,
    585
    );

  fill(MUTED_COLOR);

  text(
    levels.get(currentLevel).description,
    80,
    610
    );

  // Message
  if (message.length() > 0) {

    fill(messageColor);

    textAlign(LEFT, CENTER);
    textSize(14);

    text(
      message,
      60,
      680
      );
  }
}

// ============================================================
// UPDATE EXECUTION
// ============================================================

void updateExecution() {

  if (!running) {
    return;
  }

  executionTimer++;

  if (executionTimer < EXECUTION_DELAY) {
    return;
  }

  executionTimer = 0;

  if (executionIndex >= program.size()) {

    running = false;

    if (player.x == goal.x &&
      player.y == goal.y) {

      completeLevel();
    } else {

      message = "Program selesai, tetapi robot belum mencapai target.";
      messageColor = RED;
    }

    return;
  }

  Command cmd = program.get(executionIndex);

  executeCommand(cmd);

  executionIndex++;
}

// ============================================================
// EXECUTE COMMAND
// ============================================================

void executeCommand(Command cmd) {

  if (cmd.type == Command.MOVE) {

    movePlayer();
  } else if (cmd.type == Command.LEFT) {

    player.turnLeft();
  } else if (cmd.type == Command.RIGHT) {

    player.turnRight();
  }
}

// ============================================================
// MOVE PLAYER
// ============================================================

void movePlayer() {

  int nextX = player.x;
  int nextY = player.y;

  if (player.direction == 0) {
    nextY--;
  } else if (player.direction == 1) {
    nextX++;
  } else if (player.direction == 2) {
    nextY++;
  } else if (player.direction == 3) {
    nextX--;
  }

  // Outside grid
  if (
    nextX < 0 ||
    nextX >= cols ||
    nextY < 0 ||
    nextY >= rows
    ) {

    message = "Robot tidak bisa keluar dari area!";
    messageColor = RED;

    return;
  }

  // Wall collision
  if (isWall(nextX, nextY)) {

    message = "Ada dinding di depan robot!";
    messageColor = RED;
    currentLives--;

    return;
  }

  player.x = nextX;
  player.y = nextY;

  movesUsed++;
}

// ============================================================
// CHECK WALL
// ============================================================

boolean isWall(int x, int y) {

  for (Wall wall : walls) {

    if (
      wall.x == x &&
      wall.y == y
      ) {

      return true;
    }
  }

  return false;
}

// ============================================================
// COMPLETE LEVEL
// ============================================================

void completeLevel() {

  levelComplete = true;

  int levelScore =
    max(
    100 - program.size() * 5,
    20
    );

  score += levelScore;

  message =
    "Berhasil! +" +
    levelScore +
    " points";

  messageColor = GREEN;

  delay(500);

  if (currentLevel < levels.size() - 1) {

    startLevel(currentLevel + 1);
  } else {

    gameState = RESULT;
  }
}

// ============================================================
// START LEVEL
// ============================================================

void startLevel(int levelIndex) {

  currentLevel = levelIndex;

  Level level =
    levels.get(currentLevel);

  player =
    new Player(
    level.startX,
    level.startY,
    level.startDirection
    );

  goal =
    new Goal(
    level.goalX,
    level.goalY
    );

  walls =
    new ArrayList<Wall>();

  for (int i = 0; i < level.wallX.length; i++) {

    walls.add(
      new Wall(
      level.wallX[i],
      level.wallY[i]
      )
      );
  }

  program.clear();

  running = false;

  levelComplete = false;

  executionIndex = 0;
  executionTimer = 0;

  movesUsed = 0;

  message =
    level.description;

  messageColor =
    TEXT_COLOR;
}

// ============================================================
// INITIALIZE LEVELS
// ============================================================

void initializeLevels() {

  levels =
    new ArrayList<Level>();

  // ----------------------------------------------------------
  // LEVEL 1
  // ----------------------------------------------------------

  levels.add(
    new Level(
    1,
    5,

    1,
    3,
    1,

    6,
    3,

    new int[] {
    3,
    3,
    3
    },

    new int[] {
      1,
      2,
      4
    },

    "Gunakan MOVE untuk mencapai bintang."
    )
    );

  // ----------------------------------------------------------
  // LEVEL 2
  // ----------------------------------------------------------

  levels.add(
    new Level(
    2,
    6,

    1,
    5,
    0,

    6,
    1,

    new int[] {
    2,
    2,
    4,
    5
    },

    new int[] {
      3,
      4,
      4,
      2
    },

    "Robot harus berbelok untuk mencapai target."
    )
    );

  // ----------------------------------------------------------
  // LEVEL 3
  // ----------------------------------------------------------

  levels.add(
    new Level(
    3,
    7,

    1,
    4,
    1,

    1,
    1,

    new int[] {
    3,
    3,
    3,
    5,
    5
    },

    new int[] {
      1,
      2,
      3,
      3,
      2
    },

    "Gunakan kombinasi MOVE dan TURN."
    )
    );

  // ----------------------------------------------------------
  // LEVEL 4
  // ----------------------------------------------------------

  levels.add(
    new Level(
    4,
    8,

    0,
    1,
    1,

    1,
    1,

    new int[] {
    3,
    3,
    3,
    5,
    5,
    5
    },

    new int[] {
      0,
      1,
      2,
      2,
      3,
      4
    },

    "Temukan jalur melalui rintangan."
    )
    );
}

// ============================================================
// MOUSE
// ============================================================



// ============================================================
// KEYBOARD
// ============================================================

void keyPressed() {

  if (gameState != GAME) {
    return;
  }

  if (running || levelComplete) {
    return;
  }

  // 1 = MOVE
  if (key == '1') {

    addCommand(Command.MOVE);
  }

  // 2 = LEFT
  else if (key == '2') {

    addCommand(Command.LEFT);
  }

  // 3 = RIGHT
  else if (key == '3') {

    addCommand(Command.RIGHT);
  }

  // R = RUN
  else if (
    key == 'r' ||
    key == 'R'
    ) {

    runProgram();
  }

  // C = CLEAR
  else if (
    key == 'c' ||
    key == 'C'
    ) {

    program.clear();

    message =
      "Program dibersihkan.";

    messageColor =
      TEXT_COLOR;
  }

  // Backspace = delete
  else if (keyCode == BACKSPACE) {

    deleteCommand();
  }
}

// ============================================================
// ADD COMMAND
// ============================================================

void addCommand(int type) {

  if (program.size() >= 8) {

    message =
      "Maksimal 8 instruksi.";

    messageColor =
      YELLOW;

    return;
  }

  String name = "";

  if (type == Command.MOVE) {
    name = "MOVE";
  } else if (type == Command.LEFT) {
    name = "TURN LEFT";
  } else if (type == Command.RIGHT) {
    name = "TURN RIGHT";
  }

  program.add(
    new Command(
    type,
    name
    )
    );

  message =
    "Instruksi ditambahkan: " +
    name;

  messageColor =
    TEXT_COLOR;
}

// ============================================================
// DELETE COMMAND
// ============================================================

void deleteCommand() {

  if (program.size() > 0) {

    program.remove(
      program.size() - 1
      );

    message =
      "Instruksi terakhir dihapus.";

    messageColor =
      TEXT_COLOR;
  }
}

// ============================================================
// RUN PROGRAM
// ============================================================

void runProgram() {

  if (program.size() == 0) {

    message =
      "Tambahkan instruksi terlebih dahulu.";

    messageColor =
      YELLOW;

    return;
  }

  // Reset robot to starting position
  Level level =
    levels.get(currentLevel);

  player =
    new Player(
    level.startX,
    level.startY,
    level.startDirection
    );

  running = true;

  executionIndex = 0;
  executionTimer = 0;

  message =
    "Robot menjalankan program...";

  messageColor =
    YELLOW;
}

// ============================================================
// RESULT SCREEN
// ============================================================

void drawResult() {

  textAlign(CENTER, CENTER);

  fill(GREEN);
  textSize(54);

  text(
    "MISSION COMPLETE!",
    width / 2,
    190
    );

  fill(TEXT_COLOR);
  textSize(24);

  text(
    "Semua level berhasil diselesaikan.",
    width / 2,
    270
    );

  fill(YELLOW);
  textSize(32);

  text(
    "SCORE: " + score,
    width / 2,
    340
    );

  fill(MUTED_COLOR);
  textSize(16);

  text(
    "Kamu telah menggunakan konsep algoritma",
    width / 2,
    400
    );

  text(
    "untuk mengendalikan robot.",
    width / 2,
    425
    );

  //drawButton(
  //  width / 2 - 120,
  //  470,
  //  240,
  //  70,
  //  "PLAY AGAIN",
  //  ACCENT
  //  );
}
