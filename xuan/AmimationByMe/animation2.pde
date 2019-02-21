
var screenWidth = 200;
var screenHeight = 200;

PImage man;

void setup() {
  size(screenWidth, screenHeight);
  background(255, 255, 255);
  fill(255, 255, 255);
  noStroke();

  man = loadImage("WizardGood.jpg");
}

void draw() {
  if (posChange) {
    rect(manX - 1, manY - 1, 104, 104);
    image(man, manX, manY);
    posChange = false;
  }
}
