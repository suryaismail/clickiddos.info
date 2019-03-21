var screenWidth = 640;
var screenHeight = 480;

var manX = 320;
var manY = 350;
var mario_state = "";
var leftCount = 1;
var rightCount = 1;
var step = 3;
var imageCount = 3;
var frameCount = 1;

PImage marioLeft = [];
PImage marioRight = [];
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
  if (mario_state.toUpperCase().slice(0, 4) == "LEFT" || mario_state.toUpperCase().slice(0, 5) == "RIGHT") {
    if (jumpCounter < jumpHeightMax) {
      manY -=1;
    }
    if (jumpCounter >= jumpHeightMax) {
      manY +=1;
    }
    jumpCounter += 1;

    if (jumpCounter > 60) {
      jumpCounter = 0;
      mario_state = mario_state.toUpperCase().slice(0, 4) == "LEFT" ? "faceLeft" : "faceRight";
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
        mario_state = mario_state.toUpperCase().slice(0, 4) == "LEFT" ? "leftJumpLeft" : mario_state.toUpperCase().slice(0, 5) == "RIGHT" ? "rightJumpLeft" : "faceLeft";
        frameCount = frameCount >= step ? 1 : frameCount + 1;
        leftCount = frameCount == step && leftCount < 3 ? leftCount + 1 : frameCount == 3 && leftCount >= imageCount ? 1 : leftCount;
        console.log("step: " + step)
        console.log("image count: " + imageCount)
        console.log("frame count: " + frameCount)
        console.log("left count: " + leftCount)
        console.log(mario_state)
      }
      break;
  case RIGHT:
      if (manX < rightLimit) {
        manX += 5;
        mario_state = mario_state.toUpperCase().slice(0, 4) == "LEFT" ? "leftJumpRight" : mario_state.toUpperCase().slice(0, 5) == "RIGHT" ? "rightJumpRight" : "faceRight";
        frameCount = frameCount >= step ? 1 : frameCount + 1;
        rightCount = frameCount == step && rightCount < 3 ? rightCount + 1 : frameCount == 3 && rightCount >= imageCount ? 1 : rightCount;
        console.log("step: " + step)
        console.log("image count: " + imageCount)
        console.log("frame count: " + frameCount)
        console.log("right count: " + rightCount)
        console.log(mario_state)
      }
      break;
  case SPACE:
      mario_state = mario_state == "faceLeft" ? "leftJump" : "rightJump";
      break;
  default:
      break;
  }
}
void mario_frame(state) {
  if (state.toUpperCase().slice(-5) == "RIGHT") {
    return marioRight[rightCount];
  }
  else if (state.toUpperCase().slice(-4) == "LEFT") {
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
