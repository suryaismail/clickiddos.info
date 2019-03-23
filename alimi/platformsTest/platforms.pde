var screenWidth = 800;
var screenHeight = 600;

//floor of level = 435
var floor = 435;

var movingLeft = false;
var movingRight = false;

var isJumping = false;
var onFloor = true;
var jumpCounter = 0;
var JUMP_TIME = 30;

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
  //for testing, add '//' to the line below and replace remove '//' at background(255, 255, 255);
  background(bg);
  //background(255, 255, 255);
  image(platform, PLATFORM_X, PLATFORM_Y);
  image(player, playerX, playerY);

  //moving left and right
  if (movingLeft) {
    playerX -= 5;
  }
  if (movingRight) {
    playerX += 5;
  }

  //gravity
  if (playerY < floor) {
    playerY += 5;
    onFloor = false;
  } else {
    onFloor = true;
  }

  //test for jumping
  if (isJumping) {
    if (jumpCounter < JUMP_TIME) {
      playerY -= 10;
    }

    jumpCounter += 1;

    if (jumpCounter > JUMP_TIME - 2) {
      jumpCounter = 0;
      isJumping = false;
    }
  }

  //test for platform, number 20 in nexy if statement makes it so that player doesn't get on platform at
  //wrong place. This number can be changed to suit preference.
  if ((playerX + PLAYER_WIDTH - 20 >= PLATFORM_X) && (playerX + 20 < PLATFORM_X + PLATFORM_WIDTH) && (playerY + PLAYER_HEIGHT <= PLATFORM_Y)) {
    console.log("platform");
    floor = PLATFORM_Y - PLAYER_HEIGHT;
  } else {
    console.log("floor");
    floor = 435;
  }
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
      if (onFloor) {
        isJumping = true;
      }
      break;
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
