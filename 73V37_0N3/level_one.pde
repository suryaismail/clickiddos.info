/* @pjs preload="../assets/wizard/wizardRight.png"; */

var FLOOR;
var platforms = new Array();
PImage bg;

var player;
var platform;

void setup() {
  FLOOR = SCREEN_HEIGHT;
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  fill(0, 0, 0);

  player = new Player(loadImage("../assets/wizard/wizardRight.png"), 10, FLOOR);
  platforms.push(new Platform(400, 500, 137, 27));
  bg = loadImage("../assets/background/bigRockTheBackground.png");

  console.log(FLOOR);
}


void draw() {
  calculate();
  image(bg);
  drawPlatforms(platforms);
  player.draw();
}

function calculate() {
    calculateMovement();
    calculateJump();
    calculateGravity();
    calculatePlatforms(platforms);
}
