var SCREEN_WIDTH = 800,
    SCREEN_HEIGHT = 600,
    LEFT_BORDER = 5,
    RIGHT_BORDER = 760,
    FLOOR = SCREEN_HEIGHT - 136;

var LEFT = 37,
    UP = 38,
    RIGHT = 39,
    DOWN = 40,
    SPACE = 32;

var JUMP_STEP = 7,
    JUMP_HEIGHT = 30,
    jumpCounter = 0,
    WALK_STEP = 5;
    GRAVITY = 5;

var playerState = "idle",
    playerOnFloor = true;

var playerX = 10,
    playerY = FLOOR,
    PLATFORM1_X = 300,
    PLATFORM1_Y = 400;

var PLAYER_HEIGHT = 76,
    PLAYER_WIDTH = 39,
    PLATFORM1_HEIGHT = 27,
    PLATFORM1_WIDTH = 137;

PImage player;
PImage bg;
PImage platform1;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  // Below are code for solid color background
  //background(255, 255, 255);
  //fill(255, 255, 255);
  bg = loadImage("../../assets/background/bigRockTheBackground.png");
  player = loadImage("StickMan.png");
  platform1 = loadImage("../../assets/xuanObstique1.png");
}

void draw() {
  image(bg);
  image(platform1, PLATFORM1_X, PLATFORM1_Y);
  image(platform1, 0, FLOOR)
  //background(255, 255, 255);
  console.log(playerState);
  console.log("playerY, FLOOR", playerY, FLOOR);
  console.log("playerOnFloor", playerOnFloor);
  if ((playerState == "wLeft") && (playerX > LEFT_BORDER) && ((playerX > PLATFORM1_X + PLATFORM1_WIDTH) || (playerY > PLATFORM1_Y + PLATFORM1_HEIGHT) || (playerY + PLAYER_HEIGHT < PLATFORM1_Y) || (playerY + PLAYER_HEIGHT <= PLATFORM1_Y))) {
    playerX -= WALK_STEP;
  }

  if ((playerState == "wRight") && (playerX < RIGHT_BORDER) && ((playerX + PLAYER_WIDTH < PLATFORM1_X) || (playerY > PLATFORM1_Y + PLATFORM1_HEIGHT) || (playerY + PLAYER_HEIGHT < PLATFORM1_Y) || (playerY + PLAYER_HEIGHT <= PLATFORM1_Y))) {
    playerX += WALK_STEP;
  }

  if (playerState[0] == "j") {

    /*if ((playerY - JUMP_STEP <= PLATFORM1_Y + PLATFORM1_HEIGHT) && (playerY >= PLATFORM1_Y + PLATFORM1_HEIGHT) && (playerX + PLAYER_WIDTH >= PLATFORM1_X) && (playerX < PLATFORM1_X + PLATFORM1_WIDTH) && !playerOnFloor) {
      console.log("FLOOR, playerY, PLATFORM1_Y + PLATFORM1_HEIGHT", FLOOR, playerY, PLATFORM1_Y + PLATFORM1_HEIGHT);
      //playerY = PLATFORM1_Y + PLATFORM1_HEIGHT;
      console.log("playerY", playerY);
      jumpCounter = 0;

      if (playerState == "jLeft") {
        playerState = "wLeft";
      }

      else if (playerState == "jRight") {
        playerState = "wRight";
      }

      else if (playerState == "jStraight") {
        playerState = "idle";
      }
    }*/

    if (jumpCounter < JUMP_HEIGHT) {

      if (playerState == "jLeft") {
        if (playerX > LEFT_BORDER) {
          playerX -= WALK_STEP;
        }
      }

      if (playerState == "jRight") {
        if (playerX < RIGHT_BORDER) {
          playerX += WALK_STEP;
        }
      }

      playerY -= JUMP_STEP + GRAVITY;
    }

    jumpCounter += 1;
  }

  if (jumpCounter == JUMP_HEIGHT) {
    jumpCounter = 0;

    if (playerState == "jLeft") {
      playerState = "wLeft";
    }

    else if (playerState == "jRight") {
      playerState = "wRight";
    }

    else if (playerState == "jStraight") {
      playerState = "idle";
    }
  }

  if (playerY < FLOOR) {
    playerY += GRAVITY;
    playerOnFloor = false;
  }
  else {
    playerOnFloor = true;
  }

  if ((playerX + PLAYER_WIDTH >= PLATFORM1_X) && (playerX < PLATFORM1_X + PLATFORM1_WIDTH) && (playerY + PLAYER_HEIGHT <= PLATFORM1_Y)) {
    console.log("on platform");
    console.log("FLOOR, playerY", FLOOR, playerY);
    FLOOR = PLATFORM1_Y - PLAYER_HEIGHT;
  }

  else {
    FLOOR = SCREEN_HEIGHT - 136;
  }

  image(player, playerX, playerY);
}

void keyPressed() {

  switch (keyCode) {

    case LEFT:
      if (playerState == "jStraight") {
        playerState = "jLeft";
        break;
      }

      if (["wLeft", "wRight", "idle"].includes(playerState)) {
        playerState = "wLeft";
        break;
      }

    case RIGHT:
    if (playerState == "jStraight") {
      playerState = "jRight";
      break;
    }

    if (["wLeft", "wRight", "idle"].includes(playerState)) {
      playerState = "wRight";
      break;
    }

    case SPACE:
      if (playerOnFloor) {

        if (playerState == "wLeft") {
          playerState = "jLeft";
          break;
        }

        if (playerState == "wRight") {
          playerState = "jRight";
          break;
        }

        if (playerState == "idle") {
          playerState = "jStraight";
          break;
        }
      }

    default:
      break;
  }
}

void keyReleased() {

  switch (keyCode) {
    case LEFT:
      //console.log("released LEFT");
      if (playerState == "jLeft") {
        playerState = "jStraight";
        break;
      }

      // There is a keyPressed bug where the right key gets
      // registered as released when pressing the right
      // key quickly after releasing the left key
      else if (playerState == "wLeft") {
        //console.log("playerState: ", playerState);
        //console.log("idle after release LEFT");
        playerState = "idle";
        break;
      }

    case RIGHT:
      //console.log("released RIGHT");
      if (playerState == "jRight") {
        playerState = "jStraight";
        break;
      }

      else if (playerState == "wRight") {
        //console.log("playerState: ", playerState);
        //console.log("idle after release RIGHT");
        playerState = "idle";
        break;
      }

    default:
      break;
  }
}
