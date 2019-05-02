var screenWidth = 800;
var screenHeight = 600;

//FLOOR of level = 435
var FLOOR = 435;

var movingLeft = false;
var movingRight = false;

var isJumping = false;
var onFloor = true;
var jumpCounter = 0;
var JUMP_TIME = 30;
var STEP = 5;

var posChange = true;

var LEFT = 37,
    RIGHT = 39,
    SPACE = 32

var playerX = 100;
var playerY = FLOOR;
var PLAYER_WIDTH = 45;
var PLAYER_HEIGHT = 60;

var PLATFORM_X = 100;
var PLATFORM_Y = 397;
var PLATFORM_HEIGHT = 27;
var PLATFORM_WIDTH = 137;

var SPIKES_HEIGHT = 122;
var SPIKES_WIDTH = 116;
var SPIKES_Y = FLOOR - PLAYER_HEIGHT;
var SPIKES_X = 600;

PImage platform;
PImage bg;
PImage player;
PImage spikes;

void setup() {
  size(screenWidth, screenHeight);

  spikes = loadImage("spikes.png");
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
  image(spikes, SPIKES_X, SPIKES_Y);

  //moving left and right
  if (movingLeft && playerX > 0) {
    playerX -= STEP;
  }
  if (movingRight && playerX + PLAYER_WIDTH < 800) {
    playerX += STEP;
  }

  //test for jumping
  if (isJumping) {
    if (jumpCounter < JUMP_TIME) {
      playerY -= STEP;
    }

    jumpCounter += 1;

    if (jumpCounter > JUMP_TIME) {
      jumpCounter = 0;
      isJumping = false;
    }
  } else {

    //gravity
    if (playerY < FLOOR) {
      playerY += STEP;
      onFloor = false;
    } else {
      onFloor = true;
    }
  }

  //test for platform, number 20 in next if statement makes it so that player doesn't get on platform at
  //wrong place. This number can be changed to suit preference.
  if ((playerX + PLAYER_WIDTH - 20 >= PLATFORM_X) && (playerX + 20 < PLATFORM_X + PLATFORM_WIDTH)
  && (playerY + PLAYER_HEIGHT <= PLATFORM_Y)) {
    FLOOR = PLATFORM_Y - PLAYER_HEIGHT;
    if ((FLOOR - playerY <= STEP) && (!isJumping)) {
      playerY = FLOOR;
    }
  } else {
    FLOOR = 435;
  }
}

void keyPressed() {

  switch (keyCode) {
    case LEFT:
          movingLeft = true;
        break;
    case RIGHT:
        movingRight = true;
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
