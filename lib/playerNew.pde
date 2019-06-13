var LEFT = 37, UP = 38, RIGHT = 39, DOWN = 40, SPACE = 32;
var playerIsOnPlatform = false;

// Player movement
function playerMovement(moveSpeed) {
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
function Player(right, left, jump, idle, x, y) {

  GameObject.call(this, x, y - playerRight[0].height, playerRight[0].width, playerRight[0].height);

  this.playerMovement = new playerMovement(7);
  this.jump = new Jump(5, 35, 0);

  this.pImage = playerRight[0];

  this.framesLeft = 0;
  this.framesRight = 0;
  this.imageFrames = 0;
  this.framesLimit = 2;

  this.draw = function () {
    for (var i = 0; i < platforms.length; i++) {
      if (isCollide(player, platforms[i])) {
        playerIsOnPlatform = true;
        break;
      } else {
        playerIsOnPlatform = false;
      }
    }

    if (this.jump.jumping) {
      this.pImage = jump;
    }

    //the jump image below should be a idle image
    if (player.bottom() == FLOOR || playerIsOnPlatform) {
      this.pImage = idle;
    }

    if (this.playerMovement.movingLeft) {
      this.imageFrames += 1;
      if (this.imageFrames == this.framesLimit) {
        this.framesLeft += 1;
        this.imageFrames = 0;
      }
      this.pImage = left[this.framesLeft];
    }

    else if (this.playerMovement.movingRight) {
      this.imageFrames += 1;
      if (this.imageFrames == this.framesLimit) {
        this.framesRight += 1;
        this.imageFrames = 0;
      }
      this.pImage = right[this.framesRight];
    }


    if (this.framesLeft == left.length - 1) {
      this.framesLeft = 0;
      }
    if (this.framesRight == right.length - 1) {
      this.framesRight = 0;
      }

    image(this.pImage, this.x, this.y);
  }
}
Player.prototype = Object.create(GameObject.prototype);

//Player movement key press
void keyPressed() {
  for (var i = 0; i < platforms.length; i++) {
    if (isCollide(player, platforms[i])) {
      playerIsOnPlatform = true;
      break;
    } else {
      playerIsOnPlatform = false;
    }
  }
  switch (keyCode) {
    case LEFT:
        player.playerMovement.movingLeft = true;
        break;

    case RIGHT:
        player.playerMovement.movingRight = true;
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
          player.playerMovement.movingLeft = false;
          break;

      case RIGHT:
          player.playerMovement.movingRight = false;
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
function calculatePlayerMovement() {
    if ((player.playerMovement.movingLeft) && (player.x >= MARGIN)) {
      player.x -= player.playerMovement.moveSpeed;
    }

    if ((player.playerMovement.movingRight) && (player.right() < SCREEN_WIDTH - MARGIN)) {
      player.x += player.playerMovement.moveSpeed;
    }
}
