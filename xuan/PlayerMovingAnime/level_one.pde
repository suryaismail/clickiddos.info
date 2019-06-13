/* @pjs preload="ninja/ninjaJump.png","ninja/ninjaL5.png","ninja/ninjaL4.png", "ninja/ninjaL3.png", "ninja/ninjaL2.png", "ninja/ninjaL1.png","1stLevelBackground.png", "ninja/ninjaR5.png", "ninja/ninjaR4.png", "ninja/ninjaR3.png", "ninja/ninjaR2.png", "ninja/ninjaR1.png"; */
var FLOOR;
var platforms = new Array();
PImage bg;

var playerRight = [];
var playerLeft = [];
var playerJump;
var player;
var platform;

void setup() {
//Player Right Images
  playerRight[0] = loadImage("ninja/ninjaR1.png");
  playerRight[1] = loadImage("ninja/ninjaR2.png");
  playerRight[2] = loadImage("ninja/ninjaR3.png");
  playerRight[3] = loadImage("ninja/ninjaR4.png");
  playerRight[4] = loadImage("ninja/ninjaR5.png");
//Player Left Images
  playerLeft[0] = loadImage("ninja/ninjaL1.png");
  playerLeft[1] = loadImage("ninja/ninjaL2.png");
  playerLeft[2] = loadImage("ninja/ninjaL3.png");
  playerLeft[3] = loadImage("ninja/ninjaL4.png");
  playerLeft[4] = loadImage("ninja/ninjaL5.png");
// Player jump
  playerJump = loadImage("ninja/ninjaJump.png");

  FLOOR = SCREEN_HEIGHT;
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  fill(0, 0, 0);
  player = new Player(playerRight, playerLeft, playerJump, 10, FLOOR);
  platforms.push(new Platform(400, 500, 137, 27));
  bg = loadImage("1stLevelBackground.png");

  //console.log(FLOOR);
}

void draw() {
  calculate();
  image(bg);
  drawPlatforms(platforms);
  player.draw();
}

function calculate() {
    calculatePlayerMovement();
    calculateJump();
    calculateGravity();
    calculatePlatforms(platforms);
}
