var LEFT = 37, UP = 38, RIGHT = 39, DOWN = 40, SPACE = 32;
var playerIsOnPlatform = false;

// Player movement
function Movement(moveSpeed) {
  this.movingLeft = false;
  this.movingRight = false;
  this.movingUp = false;
  this.movingDown = false;
  this.moveSpeed = moveSpeed;
}

// Player jumping
function Jump(jumpSpeed, jumpDura, jumpStepCount) {
  this.jumping = false;
  this.jumpSpeed = jumpSpeed;
  this.jumpDura = jumpDura;
  this.jumpStepCount = jumpStepCount;
}

// Player
function Player(pImage, x, y) {
  this.pImage = pImage;
  GameObject.call(this, x, y - pImage.height, pImage.width, pImage.height);

  this.movement = new Movement(7);
  this.jump = new Jump(5, 35, 0);

  this.draw = function () {
    image(this.pImage, this.x, this.y);
  }
}
Player.prototype = Object.create(GameObject.prototype);

void keyPressed() {

}

//Player movement key press
void keyPressed() {
  for (var i = 0; i < platforms.length; i++) {
    if (isCollide(player, platforms[i])) {
      playerIsOnPlatform = true;
      break;
    }
  }
  switch (keyCode) {
    case LEFT:
        player.movement.movingLeft = true;
        break;

    case RIGHT:
        player.movement.movingRight = true;
        break;

    case SPACE:
        if ((player.bottom() == FLOOR) || playerIsOnPlatform) {
          player.jump.jumping = true;
        }
        break;

    default:
        break;
    }
}

void keyReleased() {
    switch (keyCode) {
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

//Player stop jump
function stopJump() {
  player.jump.jumping = false;
  player.jump.jumpStepCount = 0;
}

//Player calculate jump
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

//All player movement
function calculateMovement() {
    if ((player.movement.movingLeft) && (player.x > MARGIN)) {
      player.x -= player.movement.moveSpeed;
    }

    if ((player.movement.movingRight) && (player.right() < SCREEN_WIDTH - MARGIN)) {
      player.x += player.movement.moveSpeed;
    }
}
