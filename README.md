# HEAP

Blocks fall like Tetris. Climb the pile before it squashes you or the screen eats you.

**[Play it in your browser on itch.io](https://mysticbot32.itch.io/heap)**


## How to play

- **Move:** Left / Right arrow keys
- **Jump:** Up arrow or Space
- **Pause / resume:** P
- **Restart after dying:** R

Your score is how high you climb, and only your best height counts. Your best height is saved in your browser, so it's still there next time you play. A block that lands on you squashes you, and so does dropping below the bottom of the screen.

## How it works

- **Falling blocks:** a timer spawns a block above the camera every 2 seconds. Blocks come from a shuffled "bag" (like Tetris), so you get every shape once per round and no long streaks.
- **Squash rule:** each block has a hurtbox. When it lands, if you're overlapping it, you die. Touching a falling block from below is safe.
- **Camera:** blocks announce their landing with a custom `landed` signal. The camera stays still until the pile passes a line on screen, then keeps the peak on that line.
- **Jump math:** the jump is about 104px high, so standing blocks are limited to 3 cells (96px) to keep the pile climbable.
- **Look:** everything is drawn in code, with no sprites. Each block is a grid of 32px cells drawn with `_draw()` and nested loops. The player is still just a small white block, and I haven't given it a proper look yet.

## Run it locally

1. Install Godot 4.7.1.
2. Open `project.godot` from this repo.
3. Press F5.

The project uses the **Compatibility** renderer, which is also what the web export needs.

## Project layout

- `scenes/`: main, player, platform, death puff, enemy
- `scripts/`: game logic (`main.gd` spawns blocks and runs the camera, `player.gd` handles movement and death, `platform.gd` handles blocks)
- `scripts/palette.gd`: the game's colors, in one place

## Not done yet

- A start screen and a clickable pause button
- Enemies. The scene exists, but they aren't spawned yet.
- A smarter spawner that avoids making unclimbable walls
- Player art. The player is still a small white block.
