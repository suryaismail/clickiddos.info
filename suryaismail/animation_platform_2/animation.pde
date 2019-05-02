
/* @pjs preload="StickMan.png"; */

var screenWidth = 600;
var screenHeight = 400;
var MARGIN = 10;

var FLOOR = screenHeight - 40;
var PLAYER_STEP = 7;

var JUMP_STEP = 2;
var JUMP_HEIGHT = 35;
var amJumping = false;
var jumpCounter = 0;

var player;
var platform0, platform1, platform2;

void setup() {
  size(screenWidth, screenHeight);
  background(255, 255, 255);
  fill(125, 125, 125);
  noStroke();

  player = new Player(loadImage("StickMan.png"), 10, FLOOR)
  platform0 = new Platform(100, 270, 100, 5);
  platform1 = new Platform(200, 250, 150, 5);
  platform2 = new Platform(400, 300, 30, 5);
}

void draw() {
  calculate()

  background(255, 255, 255)
  platform0.draw();
  platform1.draw();
  platform2.draw();

  player.draw()
}

function calculate() {
    calculateJump()
    calculateGravity()
    calculatePlatform(player, platform0)
    calculatePlatform(player, platform1)
    calculatePlatform(player, platform2)
}

function calculateJump() {
    if (amJumping) {
      jumpCounter += 1
      if (jumpCounter < JUMP_HEIGHT) {
        player.y -= JUMP_STEP
      } else {
        stopJump()
      }
    }
}

function stopJump() {
  amJumping = false;
  jumpCounter = 0
}

function calculateGravity() {
  if (amJumping) {
    return
  }
  if (player.bottom() > FLOOR) {
    player.setBottomTo(FLOOR);
  } else if (player.bottom() < FLOOR) {
    player.y += GRAVITY_STEP;
  }
}

function calculatePlatform(player, platform) {
  if (amJumping) {
    if(isCollide(player, platform)) {
      // If player head touch the platform, stop him from going up
      if ((platform.top() <= player.top()) && (player.top() <= platform.bottom())) {
        player.y = platform.bottom();
        stopJump();
      }
    }
    return
  }

  if(isCollide(player, platform)) {
    // If player feet touch the platform
    if ((platform.top() <= player.bottom()) && (player.bottom() <= platform.bottom())) {
      player.setBottomTo(platform.top());
      return
    }
    // If player bumps from the left
    if (player.midX() < platform.midX()) {
      var startX = player.x
      player.x = player.x - PLAYER_STEP;
      return
    } else {
      // If player bumps from the right
      var startX = player.x
      player.x = player.x + PLAYER_STEP;
    }
  }
}

void keyPressed() {
  var LEFT = 37,
      UP = 38,
      RIGHT = 39,
      DOWN = 40,
      SPACE = 32;

  switch (keyCode) {
  case LEFT:
      if (player.x > MARGIN) {
        player.x -= PLAYER_STEP;
      }
      break;
  case RIGHT:
      if (player.x < (screenWidth - MARGIN)) {
        player.x += PLAYER_STEP;
      }
      break;
  case SPACE:
      amJumping = true;
      break;
  default:
      break;
  }
}
