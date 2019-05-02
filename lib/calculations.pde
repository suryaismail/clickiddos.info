var STEP = 5;
var JUMP_HEIGHT = 35;
var jumpCounter = 0;
var LEFT = 37, RIGHT = 39, SPACE = 32;
var movingLeft = false;
var movingRight = false;
var amJumping = false;
var FLOOR = 600;

//From constructors.pde
function isCollide(a, b) {
  return (a.left() <= b.right() && a.right() >= b.left()) &&
         (a.top() <= b.bottom() && a.bottom() >= b.top())
}

//Stops jump
function stopJump() {
  amJumping = false;
  jumpCounter = 0;
}

//Jump
function calculateJump() {
    if (amJumping) {
      jumpCounter += 1
      if (jumpCounter < JUMP_HEIGHT) {
        player.y -= STEP;
      } else {
        stopJump();
      }
    }
}

//Gravity
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

//Movement left and right
function calculateLeftRight() {
  if (movingLeft && player.x > 0) {
    player.x -= STEP;
  }
  if (movingRight && player.x + player.width < 800) {
    player.x += STEP;
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
      if (player.bottom() >= FLOOR || isCollide(player, platform)) {
        amJumping = true;
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
