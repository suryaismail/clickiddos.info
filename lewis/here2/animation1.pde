
var screenWidth = 600;
var screenHeight = 300;
var waveX = 0;
var waveY = 0;

PImage wave;

void setup() {
  size(screenWidth, screenHeight);
  background(100);

  wave = loadImage("Waves.jpg");
}

void draw() {
  image(wave, waveX, waveY);
  image(wave, waveX - screenWidth, waveY);
  if (!running) {
    return;
  }
  waveX += 5;
  if (waveX >= screenHeight) {
    waveX = 0;
  }
}
