
/* @pjs preload="StickMan.png"; */

var FLOOR;

var player;
var platforms = new Array();
PImage bg;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);

  FLOOR = SCREEN_HEIGHT - 60;
  bg = loadImage("../../assets/background/bigRockTheBackground.png");
  player = new Player(loadImage("StickMan.png"), 10, FLOOR);

  platforms.push(new Platform(100, 370, 100, 5));
  platforms.push(new Platform(200, 350, 150, 5));
  platforms.push(new Platform(400, 400, 30, 5));
}

void draw() {
  image(bg);
  calculate();
  drawPlatforms();
  player.draw();
}

function calculate() {
    calculateMovement();
    calculateJump();
    calculateGravity();
    calculatePlatforms();
}

function calculateMovement() {
    if ((player.movement.movingLeft) && (player.x > MARGIN)) {
      player.x -= player.movement.moveSpeed;
    }

    if ((player.movement.movingRight) && (player.right() < SCREEN_WIDTH - MARGIN)) {
      player.x += player.movement.moveSpeed;
    }
}

function calculatePlatforms() {
    for (var i = 0; i < platforms.length; i++) {
      calculatePlatform(platforms[i]);
    }
}

function drawPlatforms() {
    for (var i = 0; i < platforms.length; i++) {
      platforms[i].draw();
    }
}

function calculateJump() {
    if (player.jump.jumping) {
      player.jump.jumpStepCount += 1;
      if (player.jump.jumpStepCount < player.jump.jumpDura) {
        player.y -= player.jump.jumpSpeed;
      } else {
        stopJump();
      }
    }
}

function stopJump() {
  player.jump.jumping = false;
  player.jump.jumpStepCount = 0;
}

function calculateGravity() {
  if (player.jump.jumping) {
    return;
  }
  if (player.bottom() > FLOOR) {
    player.setBottomTo(FLOOR);
  } else if (player.bottom() < FLOOR) {
    player.y += GRAVITY_STEP;
  }
}

function calculatePlatform(platform) {
  if (player.jump.jumping) {
    if (isCollide(player, platform)) {
      // If player head touch the platform, stop him from going up
      if ((platform.top() <= player.top()) && (player.top() <= platform.bottom())) {
        player.y = platform.bottom();
        stopJump();
      }
    }
  }

  if (isCollide(player, platform)) {
    // If player feet touch the platform
    if ((platform.top() <= player.bottom()) && (player.bottom() <= platform.bottom())) {
      player.setBottomTo(platform.top());
      return
    }
    // If player bumps from the left
    if (player.midX() < platform.midX()) {
      var startX = player.x
      player.x = player.x - player.movement.moveSpeed;
      return
    } else {
      // If player bumps from the right
      var startX = player.x
      player.x = player.x + player.movement.moveSpeed;
    }
  }
}

void keyPressed() {
  playerMovementPress(keyCode, player, platforms, MARGIN, SCREEN_WIDTH, FLOOR);
}

void keyReleased() {
  playerMovementRelease(keyCode, player, MARGIN, SCREEN_WIDTH, FLOOR);
}
