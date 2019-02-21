
var screenWidth = 200;
var screenHeight = 200;

var manX = 100;
var manY = 100;
var posChange = true;

PImage man;

void setup() {
  size(screenWidth, screenHeight);
  background(255, 255, 255);
  fill(255, 255, 255);
  noStroke();

  man = loadImage("StickMan.jpg");
}

void draw() {
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
      DOWN = 40;

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
  default:
      break;
  }
}
