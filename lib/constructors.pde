var GRAVITY_STEP = 5;
var SCREEN_WIDTH = 800;
var SCREEN_HEIGHT = 600;
var MARGIN = 10;

// Game objects
function GameObject(x, y, width, height) {
  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;
}

GameObject.prototype.top = function() {return this.y}
GameObject.prototype.bottom = function() {return this.y + this.height }
GameObject.prototype.left = function() {return this.x }
GameObject.prototype.right = function() {return this.x + this.width }
GameObject.prototype.midY = function() {return this.y + (this.height / 2) }
GameObject.prototype.midX = function() {return this.x + (this.width / 2) }

GameObject.prototype.setBottomTo = function (bottom) {
  this.y = bottom - this.height;
}
GameObject.prototype.setRightTo = function (right) {
  this.x = right - this.width;
}

function isCollide(a, b) {
  return (a.left() <= b.right() && a.right() >= b.left()) &&
         (a.top() <= b.bottom() && a.bottom() >= b.top())
}

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

// Platforms
function Platform(x, y, width, height) {
  GameObject.call(this, x, y, width, (height <= GRAVITY_STEP) ? this.height = GRAVITY_STEP + 1 : height);

  this.playerIsOnPlatform = function () {
    if ((isCollide(player, this)) && ((platform.top() <= player.bottom()) && (player.bottom() <= platform.bottom()))) {
      return true;
    }
    else {
      return false;
    }
  }

  this.draw = function () {
    fill(0, 125, 125);
    rect(x, y, width, height);
  }

}
Platform.prototype = Object.create(GameObject.prototype);
