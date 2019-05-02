
/* @pjs preload="StickMan.png"; */
var FLOOR;

var player;
var platforms = new Array();

void setup() {
  FLOOR = SCREEN_HEIGHT - 100;

  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  background(255, 255, 255);
  fill(125, 125, 125);
  noStroke();

  player = new Player(loadImage("StickMan.png"), 10, FLOOR)

  platforms.push(new Platform(100, 370, 100, 5));
  platforms.push(new Platform(200, 350, 150, 5));
  platforms.push(new Platform(400, 400, 30, 5));
}

void draw() {
  calculate()

  background(255, 255, 255);
  drawPlatforms(platforms);
  player.draw()
}

function calculate() {
  calculateMovement();
  calculateJump();
  calculateGravity();
  calculatePlatforms(platforms);
}

void keyPressed() {
  playerMovementPress(keyCode, player, platforms, MARGIN, SCREEN_WIDTH, FLOOR);
}

void keyReleased() {
  playerMovementRelease(keyCode, player, MARGIN, SCREEN_WIDTH, FLOOR);
}
