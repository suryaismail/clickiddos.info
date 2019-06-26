/* @pjs preload="../assets/wizard/wizardRight.png", "../assets/SmallFoes/SmallFoe.png"; */

var FLOOR;
var platforms = new Array();
PImage bg;

var player;
var enemy;
var platform;
var playerImages = [];

void setup() {
  FLOOR = SCREEN_HEIGHT;
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  fill(0, 0, 0);

  playerImages[0] = loadImage("../assets/wizard/wizardRight.png");
  player = new Player(playerImages, playerImages,
    playerImages[0], playerImages[0], 10, FLOOR);
  enemy = new Enemy(loadImage("../assets/SmallFoes/SmallFoe.png"), 400, FLOOR, 500, 300, 3)
  platforms.push(new Platform(400, 500, 137, 27));
  bg = loadImage("../assets/background/bigRockTheBackground.png");

  console.log(FLOOR);
}


void draw() {
  calculate();
  image(bg);
  drawPlatforms(platforms);
  player.draw();
  enemy.draw();
}

function calculate() {
    calculateEnemyBoundaries();
    calculatePlayerMovement();
    calculateEnemyMovement();
    calculateJump();
    calculateGravity();
    calculatePlatforms(platforms);
}
