
/* @pjs preload="StickMan.png"; */

var screenWidth = 600;
var screenHeight = 400;
var MARGIN = 10;

var FLOOR = screenHeight - 40
var GRAVITY_STEP = 2;

var JUMP_STEP = 2;
var JUMP_HEIGHT = 35;
var amJumping = false;
var jumpCounter = 0;

var player;
var platform0, platform1;

void setup() {
  size(screenWidth, screenHeight);
  background(255, 255, 255);
  fill(255, 255, 255);
  noStroke();

  player = new Player(loadImage("StickMan.png"), 10, FLOOR)
  platform0 = new Platform(100, 300, 100, 5);
  platform1 = new Platform(200, 270, 230, 5);
}

void draw() {
  calculate()

  background(255, 255, 255)
  platform0.draw();
  platform1.draw();
  player.draw()
}


function calculate() {
    calculateJump()
    calculateGravity()
    calculatePlatform(player, platform0)
    calculatePlatform(player, platform1)
}

function calculateJump() {
    if (amJumping) {
      jumpCounter += 1
      if (jumpCounter < JUMP_HEIGHT) {
        player.y -= JUMP_STEP
      } else {
        jumpCounter = 0
        amJumping = false
        console.log("stop jump")
      }
    }
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
    return
  }

  if(isCollide(player, platform)) {
    if ((platform.top() <= player.bottom()) && (player.bottom() <= platform.bottom())) {
      player.setBottomTo(platform.top());
      amJumping = false;
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
        player.x -= 5;
      }
      break;
  case RIGHT:
      if (player.x < (screenWidth - MARGIN)) {
        player.x += 5;
      }
      break;
  case SPACE:
      amJumping = true;
      break;
  default:
      break;
  }
}

var count = 1;
function isCollide(a, b) {
  return (a.left() <= b.right() && a.right() >= b.left()) &&
         (a.top() <= b.bottom() && a.bottom() >= b.top())
}

function Player(pImage, x, y) {
  this.pImage = pImage
  this.x = x
  this.y = y - pImage.height
  this.width = pImage.width
  this.height = pImage.height

  this.top = function() {return this.y}
  this.bottom = function() {return this.y + this.height }
  this.left = function() {return this.x }
  this.right = function() {return this.x + this.width }
  this.midY = function() {return this.y + (this.height / 2) }

  this.draw = function () {
    image(this.pImage, this.x, this.y)
  }
  this.toString = function () {
    return ("top " + this.top() + " bottom " + this.bottom() +
    " left " + this.left() + " right " + this.right())
  }

  this.setBottomTo = function (bottom) {
    this.y = bottom - this.height;
  }
}

function Platform(x, y, width, height) {
  this.x = x
  this.y = y
  this.width = width
  this.height = height
  if (height <= GRAVITY_STEP) {
    console.log("PLATFORMS(" + height + ") must have height more than GRAVITY_STEP(" + GRAVITY_STEP + ")")
    this.height = GRAVITY_STEP + 1;
  }

  this.top = function() {return this.y}
  this.bottom = function() {return this.y + this.height }
  this.left = function() {return this.x }
  this.right = function() {return this.x + this.width }

  this.draw = function () {
    fill(0, 125, 125)
    rect(x, y, width, height)
  }
  this.toString = function () {
    return ("top " + this.top() + " bottom " + this.bottom() +
    " left " + this.left() + " right " + this.right())
  }
}
