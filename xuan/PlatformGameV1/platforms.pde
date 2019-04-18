var screenWidth = 800;
var screenHeight = 600;

//floor of level = 435
var floor = 435;

var movingLeft = false;
var movingRight = false;

var isJumping = false;
var onFloor = true;
var jumpCounter = 0;
var JUMP_TIME = 23;

var posChange = true;

var LEFT = 37,
    RIGHT = 39,
    SPACE = 32

var playerX = 100;
var playerY = floor;
var movingSpeed = 5;
var PLAYER_WIDTH = 45;
var PLAYER_HEIGHT = 60;

var PLATFORM1_X = 100;
var PLATFORM1_Y = 400;
var PLATFORM2_X = 425;
var PLATFORM2_Y = 350;
var PLATFORM3_X = 175;
var PLATFORM3_Y = 275;
var PLATFORM4_X = 500;
var PLATFORM4_Y = 200;
var SPEED_X =  200;
var SPEED_Y =  230;
var PLATFORM_HEIGHT = 27;
var PLATFORM_WIDTH = 137;


PImage platform;
PImage bg;
PImage player;
PImage speed;
PImage congrates;

void setup() {
  size(screenWidth, screenHeight);

  player = loadImage("wizardRight.png");
  bg = loadImage("bigRockTheBackground.png");
  platform = loadImage("xuanPlatform.png");
  speed = loadImage("SuperSpeed.png");
  congrates = loadImage("Congrates.png")
}

void draw() {
  //load images
  //for testing, add '//' to the line below and replace remove '//' at background(255, 255, 255);
  background(bg, 255, 255);
  //background(255, 255, 255);
  image(platform, PLATFORM1_X, PLATFORM1_Y);
  image(platform, PLATFORM2_X, PLATFORM2_Y);
  image(platform, PLATFORM3_X, PLATFORM3_Y);
  image(platform, PLATFORM4_X, PLATFORM4_Y);
  image(speed, SPEED_X, SPEED_Y);
  image(player, playerX, playerY);

  //moving left and right
  if (movingLeft) {
    playerX -= movingSpeed;
  }
  if (movingRight) {
    playerX += movingSpeed;
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
  if ((playerY <= SPEED_Y) && (playerX >= 50 || playerX <= SPEED_Y - 50)) {
    movingSpeed = 15;

}   else {
    movingSpeed = 5;
  }

  if ((playerX + PLAYER_WIDTH - 20 >= PLATFORM1_X) && (playerX + 20 < PLATFORM1_X + PLATFORM_WIDTH) && (playerY + PLAYER_HEIGHT <= PLATFORM1_Y) && (playerY + PLAYER_HEIGHT > PLATFORM3_Y)) {
    console.log("platform");
    floor = PLATFORM1_Y - PLAYER_HEIGHT;

}  else if ((playerX + PLAYER_WIDTH - 20 >= PLATFORM2_X) && (playerX + 20 < PLATFORM2_X + PLATFORM_WIDTH) && (playerY + PLAYER_HEIGHT <= PLATFORM2_Y) && (playerY + PLAYER_HEIGHT > PLATFORM4_Y)) {
        console.log("platform");
        floor = PLATFORM2_Y - PLAYER_HEIGHT;

}  else if ((playerX + PLAYER_WIDTH - 20 >= PLATFORM3_X) && (playerX + 20 < PLATFORM3_X + PLATFORM_WIDTH) && (playerY + PLAYER_HEIGHT <= PLATFORM3_Y) && (playerY + PLAYER_HEIGHT < PLATFORM1_Y)) {
          console.log("platform");
          floor = PLATFORM3_Y - PLAYER_HEIGHT;

  }  else if ((playerX + PLAYER_WIDTH - 20 >= PLATFORM4_X) && (playerX + 20 < PLATFORM4_X + PLATFORM_WIDTH) && (playerY + PLAYER_HEIGHT <= PLATFORM4_Y) && (playerY + PLAYER_HEIGHT < PLATFORM2_Y)) {
                  console.log("platform");
                  image(congrates, 75, 100)
                  movingSpeed = 5;
                  floor = PLATFORM4_Y - PLAYER_HEIGHT;

  }   else {
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
