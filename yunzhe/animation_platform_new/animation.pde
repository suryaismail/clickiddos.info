
/* @pjs preload="StickMan.png"; */

var FLOOR;

var player;
var platforms = new Array();
PImage bg;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);

  FLOOR = SCREEN_HEIGHT - 136;
  bg = loadImage("../../assets/background/bigRockTheBackground.png");
  player = new Player(loadImage("StickMan.png"), 10, FLOOR);

  platforms.push(new Platform(100, 270, 100, 5));
  platforms.push(new Platform(200, 250, 150, 5));
  platforms.push(new Platform(400, 300, 30, 5));
}

void draw() {
  calculate();

  image(bg);
  drawPlatforms();
  player.draw();
}

function calculate() {
    calculateJump();
    calculateGravity();
    calculatePlatforms();
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
    if (player.jumping) {
      player.jumpStepCount += 1;
      if (player.jumpStepCount < player.jumpDura) {
        player.y -= player.jumpSpeed;
      } else {
        stopJump();
      }
    }
}

function stopJump() {
  player.jumping = false;
  player.jumpStepCount = 0;
}

function calculateGravity() {
  if (player.jumping) {
    return;
  }
  if (player.bottom() > FLOOR) {
    player.setBottomTo(FLOOR);
  } else if (player.bottom() < FLOOR) {
    player.y += GRAVITY_STEP;
  }
}

function calculatePlatform(platform) {
  if (player.jumping) {
    if(isCollide(player, platform)) {
      // If player head touch the platform, stop him from going up
      if ((platform.top() <= player.top()) && (player.top() <= platform.bottom())) {
        player.y = platform.bottom();
        stopJump();
      }
    }
    return;
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
      player.x = player.x - player.moveSpeed;
      return
    } else {
      // If player bumps from the right
      var startX = player.x
      player.x = player.x + player.moveSpeed;
    }
  }
}

void keyPressed() {
  playerMovement(keycode, player, MARGIN, SCREEN_WIDTH, FLOOR);
}

void keyReleased() {
  playerMovement(keycode, player, MARGIN, SCREEN_WIDTH, FLOOR);
}
