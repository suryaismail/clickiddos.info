var screenWidth = 800;
var screenHeight = 600;

var floor = 435;

var movingLeft = false;
var movingRight = false;

var isJumping = false;
var jumpCounter = 0;
var JUMP_TIME = 20;

var posChange = true;

var LEFT = 37,
    RIGHT = 39,
    SPACE = 32

var playerX = 100;
var playerY = floor;
var PLAYER_WIDTH = 45;
var PLAYER_HEIGHT = 60;

var PLATFORM_X = 100;
var PLATFORM_Y = 400;
var PLATFORM_HEIGHT = 27;
var PLATFORM_WIDTH = 137;


PImage platform;
PImage bg;
PImage player;

void setup() {
  size(screenWidth, screenHeight);

  player = loadImage("wizardRight.png");
  bg = loadImage("xuanBackground.png");
  platform = loadImage("xuanPlatform.png");
}

void draw() {
  //load images
  background(bg);
  image(platform, PLATFORM_X, PLATFORM_Y);
  image(player, playerX, playerY);

  //moving left and right
  if (movingLeft) {
    playerX -= 5;
  }
  if (movingRight) {
    playerX += 5
  }

  //test for jumping
  if (isJumping) {
    if (jumpCounter < JUMP_TIME) {
      playerY -= 10

    jumpCounter += 1;

    if (jumpCounter > JUMP_TIME - 1) {
      jumpCounter = 0;
      isJumping = false;
    }
  }

  //gravity
  if (playerY < floor) {
  }

  /*test for platform
  if (playerX > PLATFORM_X) && (playerX + PLAYER_WIDTH > PLATFORM_X + PLATFORM_WIDTH) && (playerY + PLAYER_HEIGHT == PLATFORM_Y) {
    playerY == PLATFORM_Y - PLAYER_HEIGHT;
  }*/
}

void keyPressed() {

  switch (keyCode) {
    case LEFT:
        if (playerX > 0) {
          movingLeft = true;
        }
        break;
    case RIGHT:
      if (playerX < screenWidth) {
        movingRight = true;
      }
      break;
    case SPACE:
      isJumping = true;
    default:
      break;
  }
}

void keyReleased() {
  switch (keyCode) {
    case LEFT:
      movingLeft = false;
      break;
    case RIGHT:
      movingRight = false;
      break;
    default:
      break;
  }
}
