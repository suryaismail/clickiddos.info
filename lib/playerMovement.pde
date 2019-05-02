var LEFT = 37,
    UP = 38,
    RIGHT = 39,
    DOWN = 40,
    SPACE = 32;

function playerMovementPress(keycode, player, platforms, margin, screenWidth, floor) {
    var playerIsOnPlatform = false;
    for (var i = 0; i < platforms.length; i++) {
      if (isCollide(player, platforms[i])) {
        playerIsOnPlatform = true;
        break;
      }
    }
    switch (keycode) {
      case LEFT:
          player.movement.movingLeft = true;
          break;

      case RIGHT:
          player.movement.movingRight = true;
          break;

      case SPACE:
          if ((player.bottom() == floor) || playerIsOnPlatform) {
            player.jump.jumping = true;
          }
          break;

      default:
          break;
    }
}

function playerMovementRelease(keycode, player, margin, screenWidth, floor) {
    switch (keycode) {
      case LEFT:
          player.movement.movingLeft = false;
          break;

      case RIGHT:
          player.movement.movingRight = false;
          break;

      default:
          break;
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

function calculateMovement() {
    if ((player.movement.movingLeft) && (player.x > MARGIN)) {
      player.x -= player.movement.moveSpeed;
    }

    if ((player.movement.movingRight) && (player.right() < SCREEN_WIDTH - MARGIN)) {
      player.x += player.movement.moveSpeed;
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

// Platform functions
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

function calculatePlatforms(platforms) {
  for (var i = 0; i < platforms.length; i++) {
    calculatePlatform(platforms[i]);
  }
}

function drawPlatforms(platforms) {
  console.log(1);
  for (var i = 0; i < platforms.length; i++) {
    platforms[i].draw();
  }
}
