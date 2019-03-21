var screenWidth = 800;
var screenHeight = 600;

var background = loadImage("xuanBackground.png");
var platform = loadImage("xuanPlatform.png");

var playerX = 100;
var playerY = 100;
var PLAYER_WIDTH = 45;
var PLAYER_HEIGHT = 60;
var posChange = true;

PImage platform;
PImage background;
PImage player;

void setup() {
  size(screenWidth, screenHeight);
  background(255, 255, 255);
  fill(255, 255, 255);
  noStroke();

  player = loadImage("wizardRight.png");
}

void draw() {
  background(255, 255, 255);

  if (posChange) {
    image(player, playerX, playerY);
    posChange = false;
  }
}

void keyPressed() {
  var LEFT = 37,
      RIGHT = 39

  switch (keyCode) {
    case LEFT:
        if (playerX > 0) {
          playerX -= 5;
          posChange = true;
        }
        break;
    case RIGHT:
      if (playerX < 0) {
        playerX += 5;
        posChange = true
      }
      break;
  default:
    break;
  }
}
