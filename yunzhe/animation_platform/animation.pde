
var screenWidth = 800;
var screenHeight = 600;
var MARGIN = 40;

var FLOOR = screenHeight - 40
var walkLevel = FLOOR;
var manX = 10;
var manY = 0;

var JUMP_STEP = 2;
var JUMP_HEIGHT = 40;
var amJumping = false;
var leftPressed = false;
var rightPressed = false;
var walkStep = 5;

PImage man;
var MAN_HEIGHT = 76;
var MAN_WIDTH = 39;

var PLATFORM_X = 120;
var PLATFORM_Y = 40;
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

  fill(0, 125, 125);
  rect(0, floor, PLATFORM_WIDTH, 2);

  if (leftPressed || rightPressed) {
    if (leftPressed) {
      if (manX > MARGIN) {
        manX -= walkStep;
      }
    }
    else if (rightPressed) {
      if (manX < (screenWidth - MARGIN)) {
        manX += walkStep;
      }
    }
  }

  if (amJumping) {
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

  if (!amJumping) {
    if ((manY + MAN_HEIGHT) <  walkLevel) {
      manY += 2;
    } else {
      manY = walkLevel - MAN_HEIGHT;
    }
  }

  image(man, manX, manY);
}

void keyPressed() {
  var LEFT = 37,
      UP = 38,
      RIGHT = 39,
      DOWN = 40,
      SPACE = 32;

  switch (keyCode) {
  case LEFT:
      leftPressed = true;
      break;
  case RIGHT:
      rightPressed = true;
      break;
  case SPACE:
      amJumping = true;
      break;
  default:
      break;
  }
}

void keyReleased() {
  var LEFT = 37,
      UP = 38,
      RIGHT = 39,
      DOWN = 40,
      SPACE = 32;

  switch (keyCode) {
  case LEFT:
      leftPressed = false;
      break;
  case RIGHT:
      rightPressed = false;
      break;
  case SPACE:
      amJumping = true;
      break;
  default:
      break;
  }
}

void drawPlatform() {
  fill(0, 125, 125);
  rect(PLATFORM_X + MAN_WIDTH, PLATFORM_Y, PLATFORM_WIDTH, PLATFORM_HEIGHT);
}
