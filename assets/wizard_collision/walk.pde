var screenWidth = 1300;
var screenHeight = 400;

var WALK_FRAMES = 7;
var MIN_ROCK_X = 10;
var MAX_ROCK_X = 380;

var manX = 20;
var manY = 100;

var rockX = MAX_ROCK_X;
var rockY = 150;

PImage manImages = [] ;
PImage rockImage;
PImage boomImage;

var manStep = 0;
var boomCount = 0;

void setup() {
  size(screenWidth, screenHeight);

  manImages [0] = loadImage("WizardRight.png");
  manImages [1] = loadImage("WizardRight1.png");
  manImages [2] = loadImage("WizardRight2.png");
  manImages [3] = loadImage("WizardRight2.png");
  rockImage = loadImage("Rock.png");
  boomImage = loadImage("Boom.png");

}

var walkCount = 0;
void draw() {
  background(255, 255, 255);

  // Draw the man
  image(manImages[manStep], manX, manY);

  // Draw the rock
  image(rockImage, rockX, rockY);

  // Change the man and rock
  if (walkCount++ == WALK_FRAMES) {
    makeManStep();
    walkCount = 0;
    rockX -= 5;
    if (rockX < MIN_ROCK_X) {
      rockX = MAX_ROCK_X;


    }
  }

  // Check for collision
  if (isCollide(manImages[0], manX, manY, rockImage, rockX, rockY)) {
    console.log("BOOM")
    boomCount = 100;
    console.log(boomCount);
    rockX = MAX_ROCK_X;

  }
  // Draw the boom
  if (boomCount > 0) {
    image(boomImage, 50, 50);
    --boomCount;
  }

}

void makeManStep() {
  // Increase the man's step
  ++manStep;
  if (manStep >= manImages.length) {
    manStep = 0;
  }
}

void keyPressed() {
  var LEFT = 379
      UP = 38,
      RIGHT = 39,
      DOWN = 40;

  switch (keyCode) {
  case UP:
      if (manY > 0) {
        manY -= 5;
      }
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


function isCollide(objA, xA0, yA0, objB, xB0, yB0) {
    var xA1 = xA0 + objA.width - 50;
    var yA1 = yA0 + objA.height;
    var xB1 = xB0 + objB.width - 3;
    var yB1 = yB0 + objB.height;

    //console.log(xA0 + " " + yA0 + " " + xB0 + " " + yB0 + " " + xA1 + " " + yA1 + " " + xB1 + " " + yB1)
    var xIntersect = false;
    var yIntersect = false;
    if ((xA0 > xB0) && (xA0 < xB1)) {
      xIntersect = true;
        console.log("HEllo1");
        console.log(yA0  + " " + yB0 + " "+ yA1 + " " + yB1);
          //100 150 310 193
    }
    if ((xA1 > xB0) && (xA1 < xB1)) {
      xIntersect = true;
        console.log("HEllo2");
        console.log(yA0  + " " + yB0 + " "+ yA1 + " " + yB1);
    }
    if ((yA0 < yB0) && (yB0 < yA1)) {
      yIntersect = true;
        console.log("HEllo3");
    }
    if ((yA0 < yB1) && (yB1 < yA1)) {
      yIntersect = true;
        console.log("HEllo4");
    }
    if (xIntersect && yIntersect) {
      console.log("HEllo");
      return true;
    }
    return false;
//  console.log("notHEllo");
  }
