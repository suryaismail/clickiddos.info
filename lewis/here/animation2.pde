var screenWidth = 1350;
var screenHeight = 635;

var manX = 0;// 650;
var manY = 400; //600;
var amJumping = false;
var right1 = true;
var left1 = false;

PImage Left = [];
PImage Right = [];
PImage bgImage;
PImage ninjaJump;
var LmanStep = 0;
var RmanStep = 0;

void setup() {
  size(screenWidth, screenHeight);
  noStroke();
  Left[0] = loadImage("ninL2.png");
  Left[1] = loadImage("ninL3.png");
  Left[2] = loadImage("ninL4.png");
  Left[3] = loadImage("ninL5.png");
  Left[4] = loadImage("ninL6.png");
  Right[0] = loadImage("ninR2.png");
  Right[1] = loadImage("ninR3.png");
  Right[2] = loadImage("ninR4.png");
  Right[3] = loadImage("ninR5.png");
  Right[4] = loadImage("ninR6.png");
  ninJump = loadImage("Ninja3.png");
  bgImage = loadImage("wall.png");
}

var jumpCounter = 0;
void draw() {
  if (amJumping) {
    if (jumpCounter < 20) {
      manY -=10;
    }
    if (jumpCounter >= 20) {
      manY +=10;
    }
    jumpCounter += 1;

    if (jumpCounter > 40) {
      jumpCounter = 0;
      amJumping = false;
    }
  }
  image(bgImage, 0, 0);
if (left1) { image(Left[LmanStep], manX, manY);}
else
if (right1)  {image(Right[RmanStep], manX,manY);}
else
if (amJumping){image(ninJump, manX, manY);}
else{image(Right[RmanStep], manX,manY)}

}

void makeManStep() {
  // Increase the man's step
  ++LmanStep;
  console.log("lala" + Left.length);
  if (LmanStep >= Left.length) {
    LmanStep = 0;

  }
  ++RmanStep;
  console.log("luala" + Right.length);
  if (RmanStep >= Right.length) {
    RmanStep = 0;
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
        manX -= 15;
        left1 = true;
        right1 = false;
        console.log(left1)
      }
      makeManStep();
      break;

      if (manY < 600) {
        manY -= 5;
      }
      break;
  case RIGHT:
      if (manX < 1300) {
        manX += 15;
        left1 = false;
        right1 = true;
        console.log(right1)
      }
      makeManStep();
      break;

      if (manY < 600) {
        manY += 5;
      }
      break;
  case SPACE:
      console.log("SPACE");
      amJumping = true;
      right1 = false;
      left1 = false;
      break;
  default:
      break;
  }
}
