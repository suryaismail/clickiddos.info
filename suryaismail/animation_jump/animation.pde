
var screenWidth = 200;
var screenHeight = 200;

var manX = 100;
var manY = 100;
var posChange = true;
var amJumping = false;

PImage man;

void setup() {
  size(screenWidth, screenHeight);
  background(255, 255, 255);
  fill(255, 255, 255);
  noStroke();

  man = loadImage("StickMan.jpg");
}

var jumpCounter = 0;
void draw() {
  if (amJumping) {
    if (jumpCounter < 20) {
      manY -=1;
    }
    if (jumpCounter >= 20) {
      manY +=1;
    }
    jumpCounter += 1;

    if (jumpCounter > 40) {
      jumpCounter = 0;
      amJumping = false;
    }

    posChange = true;
  }

  if (posChange) {
    rect(manX - 1, manY - 1, 104, 104);
    image(man, manX, manY);
    posChange = false;
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
      if (manX > 0) {
        manX -= 5;
        posChange = true;
      }
      break;
  case UP:
      if (manY > 0) {
        manY -= 5;
        posChange = true;
      }
      break;
  case RIGHT:
      if (manX < 100) {
        manX += 5;
        posChange = true;
      }
      break;
  case DOWN:
      if (manY < 100) {
        manY += 5;
        posChange = true;
      }
      break;
  case SPACE:
      console.log("SPACE");
      amJumping = true;
      break;
  default:
      break;
  }
}
