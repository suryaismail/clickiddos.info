
var screenWidth = 200;
var screenHeight = 200;

var manX = 100;
var manY = 100;

PImage manImages = [] ;
var manStep = 0;

void setup() {
  size(screenWidth, screenHeight);

  manImages [0] = loadImage("StickMan0.jpg");
  manImages [1] = loadImage("StickMan1.jpg");
  manImages [2] = loadImage("StickMan2.jpg");
  manImages [3] = loadImage("StickMan3.jpg");

}

void draw() {
  background(255, 255, 255);

  // Draw the man
  image(manImages[manStep], manX, manY);
}

void makeManStep() {
  // Increase the man's step
  ++manStep;
  console.log("lala" + manImages.length);
  if (manStep >= manImages.length) {
    manStep = 0;
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
      }
      makeManStep();
      break;
  case UP:
      if (manY > 0) {
        manY -= 5;
      }
      break;
  case RIGHT:
      if (manX < 100) {
        manX += 5;
      }
      makeManStep();
      break;
  case DOWN:
      if (manY < 100) {
        manY += 5;
      }
      break;
  default:
      break;
  }
}
