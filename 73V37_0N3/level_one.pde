/* @pjs preload="../assets/wizard/wizardRight.png"; */

var screenWidth = 800;
var screenHeight = 600;

var FLOOR = screenHeight;
var onFloor = true;

var amJumping = false;

var LEFT = 37,
    RIGHT = 39,
    SPACE = 32

var playerX = 100;
var playerY = floor;
var PLAYER_STEP = 5;

var PLATFORM_HEIGHT = 27;
var PLATFORM_WIDTH = 137;

PImage bg;

var player;
var platform;

void setup() {
  size(screenWidth, screenHeight);
  fill(0, 0, 0);

  player = new Player(loadImage("../assets/wizard/wizardRight.png"), 10, FLOOR);
  platform = new Platform(400, 500, PLATFORM_WIDTH, PLATFORM_HEIGHT);
  bg = loadImage("../assets/background/bigRockTheBackground.png");
}

void draw() {
  calculate();
  image(bg);
  platform.draw();
  player.draw();
}

function calculate() {
    calculateLeftRight();
    calculateJump();
    calculateGravity();
    calculatePlatform(player, platform);
}
