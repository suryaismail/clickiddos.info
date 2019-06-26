/* @pjs preload="../assets/wizard/wizardRight.png", "../assets/SmallFoes/SmallFoe.png", "../assets/SmallFoes/SmallFoe2.png"; */
var FLOOR;
var platforms = new Array();
var player;
var door;
var enemy;
var platform;

void setup() {
  currGameState = gameStates.PLAYING;
  FLOOR = SCREEN_HEIGHT;
  size(SCREEN_WIDTH, SCREEN_HEIGHT);

  player = new Player(loadImage("../assets/wizard/wizardRight.png"), 10, FLOOR);
  door = new Door(150, 40, 40, 60);
  enemy = new Enemy(loadImage("../assets/SmallFoes/SmallFoe2.png"), 400, FLOOR, 500, 400, 3);

  //moving platforms
  platforms.push(new Platform(550, 500, 137, 27));
  platforms[0].movePixels.setup([50, 50], ["U", "D"], 3);

  platforms.push(new Platform(350, 500, 137, 27));
  platforms[1].movePixels.setup([100, 100], ["L", "R"], 3);

  //static platforms
  platforms.push(new Platform(100, 100, 135, 27));
}

void draw() {
  background(256, 256, 256);
  calculate();
  fill(255, 255, 255);
  drawPlatforms(platforms);
  fill(0, 17, 255);
  door.draw();
  enemy.draw();
  player.draw();
}

function calculate() {
    loopPlatforms(platforms);
    calculateEnemyMovement();
    calculateEnemyBoundaries();
    calculatePlayerMovement();
    calculateJump();
    calculateGravity();
    calculatePlatforms(platforms);
    doorCollision();
}
