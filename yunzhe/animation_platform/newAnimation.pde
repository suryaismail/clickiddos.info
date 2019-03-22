var SCREEN_WIDTH = 800,
    SCREEN_HEIGHT = 600,
    LEFT_BORDER = 5,
    RIGHT_BORDER = 760;

var FLOOR = SCREEN_HEIGHT - 60,
    playerX = 10,
    playerY = 0;

var LEFT = 37,
    UP = 38,
    RIGHT = 39,
    DOWN = 40,
    SPACE = 32;

var JUMP_STEP = 7,
    JUMP_HEIGHT = 30,
    jumpCounter = 0,
    WALK_STEP = 5;

var playerState = "idle";

PImage player;
PImage bg;
var PLAYER_HEIGHT = 76,
    PLAYER_WIDTH = 39;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  bg = loadImage("../../assets/background/bigRockTheBackground.png");
  image(bg);
  // Below are code for solid color background
  //background(255, 255, 255);
  //fill(255, 255, 255);
  player = loadImage("StickMan.png");
  playerY = FLOOR - PLAYER_HEIGHT;
}

void draw() {
  image(bg);
  //background(255, 255, 255);
  console.log(playerState);

  if (playerState == "wLeft" & playerX > LEFT_BORDER) {
    playerX -= WALK_STEP;
  }

  if (playerState == "wRight" & playerX < RIGHT_BORDER) {
    playerX += WALK_STEP;
  }

  if (playerState[0] == "j" || playerState[0] == "f") {

    if (playerState == "jLeft" || playerState == "fLeft") {

      if (jumpCounter < JUMP_HEIGHT) {
        playerX -= WALK_STEP;
        playerY -= JUMP_STEP;
      }

      if (jumpCounter >= JUMP_HEIGHT) {
        playerX -= WALK_STEP;
        playerY += JUMP_STEP;
      }
    }

    else if (playerState == "jRight" || playerState == "fRight") {

      if (jumpCounter < JUMP_HEIGHT) {
        playerX += WALK_STEP;
        playerY -= JUMP_STEP;
      }

      if (jumpCounter >= JUMP_HEIGHT) {
        playerX += WALK_STEP;
        playerY += JUMP_STEP;
      }
    }

    else {

      if (jumpCounter < JUMP_HEIGHT) {
        playerY -= JUMP_STEP;
      }

      if (jumpCounter >= JUMP_HEIGHT) {
        playerY += JUMP_STEP;
      }
    }

    jumpCounter += 1;

    if (jumpCounter == JUMP_HEIGHT) {

      if (playerState == "jLeft") {
        playerState = "fLeft";
      }

      else if (playerState == "jRight") {
        playerState = "fRight";
      }

      else {
        playerState == "fStraight";
      }
    }

    if (playerY >= FLOOR - PLAYER_HEIGHT) {
      console.log("WHEN TOUCH GROUND: ", playerState);
      console.log("playerState == 'fLeft': ", playerState == "fLeft");
      if (playerState == "fLeft") {
        playerState = "wLeft";
      }

      else if (playerState == "fRight") {
        playerState = "wRight";
      }

      else {
        playerState = "idle";
      }

      jumpCounter = 0;
    }
  }

  if (playerState == "idle") {
    playerY = FLOOR - PLAYER_HEIGHT;
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

      if (playerState == "fStraight") {
        playerState = "fLeft";
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

    if (playerState == "fStraight") {
      playerState = "fRight";
      break;
    }

    if (["wLeft", "wRight", "idle"].includes(playerState)) {
      playerState = "wRight";
      break;
    }

    case SPACE:
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

    default:
      break;
  }
}

void keyReleased() {

  switch (keyCode) {
    case LEFT:
      if (playerState == "jLeft") {
        playerState = "jStraight";
        break;
      }

      else if (playerState == "fLeft") {
        playerState = "fStraight";
        break;
      }

      else if (playerState == "wLeft") {
        playerState = "idle";
        break;
      }

    case RIGHT:
      if (playerState == "jRight") {
        playerState = "jStraight";
        break;
      }

      else if (playerState == "fRight") {
        playerState = "fStraight";
        break;
      }

      else if (playerState == "wRight") {
        playerState = "idle";
        break;
      }

    default:
      break;
  }
}
