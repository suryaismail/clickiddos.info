
/* @pjs preload="StickMan.png"; */

var player;
var platforms = new Array();

PImage startImage;
PImage endImage;
var endCounter = 0;
var playerImages = [];
PImage bg;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);

  FLOOR = SCREEN_HEIGHT - 60;
  bg = loadImage("../../assets/background/bigRockTheBackground.png");

  startImage = loadImage("Start.png");
  endImage = loadImage("End.png");

  playerImages[0] = loadImage("StickMan.png");
  player = new Player(playerImages, playerImages,
    playerImages[0], playerImages[0], 10, FLOOR);

  platforms.push(new Platform(100, 370, 100, 5));
  platforms.push(new Platform(200, 350, 150, 5));
  platforms.push(new Platform(400, 400, 30, 5));
  platforms[1].movePixels.setup([40, 40, 120, 40, 80], ["L", "U", "R", "D", "L"], 5);
}

void draw() {
  if (currGameState == gameStates.START) {
    background(255, 255, 255);
    image(startImage, 100, 100);
    return;
  }
  // Oo, we died, so punish the player a bit
  if (currGameState == gameStates.END) {
    background(255, 255, 255);
    image(endImage, 100, 200);
    endCounter -= 1;
    if (endCounter <= 0) {
      currGameState = gameStates.PLAYING;
    }
    return;
  }

  calculate();

  image(bg);
  drawPlatforms(platforms);

  player.draw();
}

function calculate() {
    loopPlatforms(platforms);
    calculatePlayerMovement();
    calculateJump();
    calculateGravity();
    calculatePlatforms(platforms);
}

void mouseClicked() {
  if (currGameState == gameStates.START) {
    currGameState = gameStates.PLAYING;
  }
}
