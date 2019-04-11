var GRAVITY_STEP = 2;

function GameObject(x, y, width, height) {
  this.x = x
  this.y = y
  this.width = width
  this.height = height
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

function Player(pImage, x, y) {
  this.pImage = pImage
  GameObject.call(this, x, y - pImage.height, pImage.width, pImage.height)

  this.draw = function () {
    image(this.pImage, this.x, this.y)
  }
}
Player.prototype = Object.create(GameObject.prototype);

function Platform(x, y, width, height) {
  GameObject.call(this, x, y, width, (height <= GRAVITY_STEP) ? this.height = GRAVITY_STEP + 1 : height)

  this.draw = function () {
    fill(0, 125, 125)
    rect(x, y, width, height)
  }

}
Platform.prototype = Object.create(GameObject.prototype);
