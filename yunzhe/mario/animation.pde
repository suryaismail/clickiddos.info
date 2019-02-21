var screenWidth = 640;
var screenHeight = 480;

var manX = 320;
var manY = 350;
var mario_state = "";
var leftCount = 0;
var rightCount = 0;
var step = 3;
var imageCount = 3;
var frameCount = 0;

PImage marioLeft[];
PImage marioRight[];
PImage bg;

void setup() {
  size(screenWidth, screenHeight);
  background(255, 255, 255);
  fill(255, 255, 255);
  noStroke();

  //man = loadImage("images/StickMan.png");
  marioRight[0] = loadImage("images/newMarioSprites/MarioRight.png");
  marioRight[1] = loadImage("images/newMarioSprites/MarioWalkRight.png");
  marioRight[2] = loadImage("images/newMarioSprites/MarioWalkRight2.png");
  marioRight[3] = loadImage("images/newMarioSprites/MarioWalkRight3.png");
  marioRight[4] = loadImage("images/newMarioSprites/MarioJumpRight.png");
  marioRight[5] = loadImage("images/newMarioSprites/MarioCrouchRight.png");
  marioRight[6] = loadImage("images/newMarioSprites/MarioBrakeRight.png");
  marioLeft[0] = loadImage("images/newMarioSprites/MarioLeft.png");
  marioLeft[1] = loadImage("images/newMarioSprites/MarioWalkLeft.png");
  marioLeft[2] = loadImage("images/newMarioSprites/MarioWalkLeft2.png");
  marioLeft[3] = loadImage("images/newMarioSprites/MarioWalkLeft3.png");
  marioLeft[4] = loadImage("images/newMarioSprites/MarioJumpLeft.png");
  marioLeft[5] = loadImage("images/newMarioSprites/MarioCrouchLeft.png");
  marioLeft[6] = loadImage("images/newMarioSprites/MarioBrakeLeft.png");
  bg = loadImage("images/SunnyDay.jpg");
  console.log("test");
}

var jumpCounter = 0;
void draw() {
  var jumpHeightMax = 30;
  if (mario_state == "rightJump" || mario_state == "leftJump") {
    if (jumpCounter < jumpHeightMax) {
      manY -=1;
    }
    if (jumpCounter >= jumpHeightMax) {
      manY +=1;
    }
    jumpCounter += 1;

    if (jumpCounter > 60) {
      jumpCounter = 0;
      mario_state = mario_state == "leftJump" ? "faceLeft" : "faceRight";
    }
  }

  image(bg, 0, 0);
  image(mario_frame(mario_state), manX, manY);

}

void keyPressed() {
  var LEFT = 37,
      UP = 38,
      RIGHT = 39,
      DOWN = 40,
      SPACE = 32;
      rightLimit = 595;

  switch (keyCode) {
  case LEFT:
      if (manX > 0) {
        manX -= 5;
        mario_state = "faceLeft";
        frameCount++;
        leftCount = frameCount == step ? leftCount += 1 : leftCount > imageCount ? 0 : leftCount;
      }
      break;
  case RIGHT:
      if (manX < rightLimit) {
        manX += 5;
        mario_state = "faceRight";
        frameCount++;
        rightCount = frameCount == step ? rightCount += 1 : rightCount > imageCount ? 0 : rightCount;
      }
      break;
  case SPACE:
      console.log("SPACE");
      mario_state = mario_state == "faceLeft" ? "leftJump" : "rightJump";
      break;
  default:
      break;
  }
}
void mario_frame(state) {
  if (state == "faceRight") {
    return marioRight[rightCount];
  }
  else if (state == "faceLeft") {
    return marioLeft[leftCount];
  }
  else if (state == "rightJump") {
    return marioRight[4];
  }
  else if (state == "leftJump") {
    return marioLeft[4];
  }
  else {
    return marioRight[0];
  }
}
