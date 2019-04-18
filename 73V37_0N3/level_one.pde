/* @pjs preload="../assets/wizard/wizardRight.png"; */

var screenWidth = 800;
var screenHeight = 600;

var FLOOR = screenHeight;
var onFloor = true;

var movingLeft = false;
var movingRight = false;
var isJumping = false;

var jumpCounter = 0;
var JUMP_TIME = 30;
var STEP = 5;

var posChange = true;

var LEFT = 37,
    RIGHT = 39,
    SPACE = 32

var playerX = 100;
var playerY = floor;

var PLATFORM_HEIGHT = 27;
var PLATFORM_WIDTH = 137;

PImage bg;

var player;

void setup() {
  player = new Player(loadImage("../assets/wizard/wizardRight.png"), 10, FLOOR);
  size(screenWidth, screenHeight);
  bg = loadImage("../assets/background/bigRockTheBackground.png");
}

void draw() {
  image(bg);
  player.draw();
}
