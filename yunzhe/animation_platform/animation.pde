
var screenWidth = 800;
var screenHeight = 600;
var MARGIN = 40;

var FLOOR = screenHeight - 40
var walkLevel = FLOOR;
var manX = 10;
var manY = 0;


var LEFT = 37,
    UP = 38,
    RIGHT = 39,
    DOWN = 40,
    SPACE = 32;

var JUMP_STEP = 7;
var JUMP_HEIGHT = 35;
var amJumping = false;
var walkStep = 5;
var playerState = "idle";

PImage man;
var MAN_HEIGHT = 76;
var MAN_WIDTH = 39;

var PLATFORM_X = 120;
var PLATFORM_Y = 400;
var PLATFORM_WIDTH = 100;
var PLATFORM_HEIGHT = 5;

void setup() {
  size(screenWidth, screenHeight);
  background(255, 255, 255);
  fill(255, 255, 255);
  noStroke();

  man = loadImage("StickMan.png");
  manY = walkLevel - MAN_HEIGHT;
}

var jumpCounter = 0;
void draw() {

  background(255, 255, 255);
  drawPlatform();

  console.log(playerState)
  fill(0, 125, 125);
  rect(0, floor, PLATFORM_WIDTH, 2);

  if (playerState = "wLeft") {
      if (manX > MARGIN) {
        manX -= walkStep;
      }
  }
  if (playerState = "wRight") {
    if (manX < (screenWidth - MARGIN)) {
      manX += walkStep;
    }
  }

  if (playerState = "amJumping") {

    if (jumpCounter < JUMP_HEIGHT) {
      manY -= JUMP_STEP;
    }
    if (jumpCounter >= JUMP_HEIGHT) {
      manY += JUMP_STEP;

      // If he hits the platfrom, stop his jump
      if ((PLATFORM_X < manX) && (manX < PLATFORM_X + PLATFORM_WIDTH)) {
        if ((manY + MAN_HEIGHT) <= PLATFORM_Y) {
          jumpCounter = 0;
          amJumping = false;
        }
      }

    }
    jumpCounter += 1;

    if (jumpCounter > (JUMP_HEIGHT * 2)) {
      jumpCounter = 0;
      amJumping = false;
    }
  }

  // Check if the man is above the platform and change the floor if he is
  if ((PLATFORM_X < manX) && (manX < PLATFORM_X + PLATFORM_WIDTH)) {
    if ((manY + MAN_HEIGHT) <= PLATFORM_Y) {
      walkLevel = PLATFORM_Y;
    } else {
      walkLevel = FLOOR;
    }
  } else {
    walkLevel = FLOOR;
  }

  if (playerState != "amJumping") {
    if ((manY + MAN_HEIGHT) <  walkLevel) {
      manY += 2;
    } else {
      manY = walkLevel - MAN_HEIGHT;
    }
  }

  image(man, manX, manY);
}

void keyPressed() {

  switch (keyCode) {
  case LEFT:
      playerState = "wLeft";
      break;
  case RIGHT:
      playerState = "wRight";
      break;
  case SPACE:
      playerState = "amJumping";
      break;
  default:
      break;
  }
}

void keyReleased() {

  switch (keyCode) {
  case LEFT:
      playerState = "wLeft";
      break;
  case RIGHT:
      playerState = "wRight";
      break;
  default:
      break;
  }
}

void drawPlatform() {
  fill(0, 125, 125);
  rect(PLATFORM_X + MAN_WIDTH, PLATFORM_Y, PLATFORM_WIDTH, PLATFORM_HEIGHT);
}
