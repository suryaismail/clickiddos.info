
/* @pjs preload="StickMan.png"; */

var FLOOR;

var player;
var platforms = new Array();
var toTG = true, toOG = false;

const gameStates = {
    START: 'start',
    PLAY: 'play',
    END: 'end'
};

var gameState = gameStates.START;
PImage startImage;
PImage endImage;
var endCounter = 0;
PImage bg;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);

  FLOOR = SCREEN_HEIGHT - 60;
  bg = loadImage("../../assets/background/bigRockTheBackground.png");

  startImage = loadImage("Start.png");
  endImage = loadImage("End.png");

  player = new Player(loadImage("StickMan.png"), 10, FLOOR);

  platforms.push(new Platform(100, 370, 100, 5));
  platforms.push(new Platform(200, 350, 150, 5));
  platforms.push(new Platform(400, 400, 30, 5));
  platforms[1].movePixels.setup([40, 40, 120, 40, 80], ["L", "U", "R", "D", "L"], 5);
}

void draw() {
  if (gameState == gameStates.START) {
    background(255, 255, 255);
    image(startImage, 100, 100);
    return;
  }
  // Oo, we died, so punish the player a bit
  if (gameState == gameStates.END) {
    background(255, 255, 255);
    image(endImage, 100, 200);
    endCounter -= 1;
    if (endCounter <= 0) {
      gameState = gameStates.PLAY;
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
  if (gameState == gameStates.START) {
    gameState = gameStates.PLAY;
  }
}
