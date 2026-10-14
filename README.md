# Code Runner

Code Runner is a small educational puzzle game made with Processing (Java mode). Write a short sequence of instructions to guide a robot across a grid and reach the star while avoiding walls.

## Run the game

1. Install [Processing](https://processing.org/download).
2. Open `sketch_261003a.pde` in Processing. Keep the other `.pde` files in the same sketch folder; they contain the game's classes and UI code.
3. Choose **Java mode** and click **Run**.

The sketch opens at 1024 × 768 pixels.

## How to play

On the title screen, click the start area to enter the game. Build a program with the keyboard, then run it. The robot starts at the level's starting position each time a program runs.

| Key | Instruction or action |
| --- | --- |
| `1` | Add `MOVE` (advance one cell in the direction the robot faces) |
| `2` | Add `TURN LEFT` |
| `3` | Add `TURN RIGHT` |
| `R` | Run the program |
| `Backspace` | Delete the last instruction |
| `C` | Clear the program |

Programs can contain up to 8 instructions. Turns rotate the robot in place. A move into a wall costs one life; a move outside the grid is blocked. Reach the star to complete a level. Your score increases after each completed level, with fewer instructions earning more points (100 points minus 5 per instruction, with a 20-point minimum).

## Levels

The game defines four grid puzzles. Each level shows a short objective below the board, and completing one advances to the next. Finish all four to see the final score.

## Project files

- `sketch_261003a.pde` — Processing entry point, rendering, level setup, input, and game logic
- `Player.pde`, `Level.pde`, `Command.pde`, `Goal.pde`, `Wall.pde` — game data and objects
- `Menus.pde`, `Button.pde`, `GameState.pde`, `Utilities.pde` — menu and UI helpers
