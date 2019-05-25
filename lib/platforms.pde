<<<<<<< HEAD
// Platform movement functions
function PlatformMovement(thisPlatform) {
  this.left = function(px) {

    if (!isCollide(player, thisPlatform)) {
      thisPlatform.x -= px;
    }
    else if (thisPlatform.playerIsOnPlatform()) {
      thisPlatform.x -= px;
      player.x -= px;
    }
  };

  this.right = function(px) {

    if (!isCollide(player, thisPlatform)) {
      thisPlatform.x += px;
    }
    else if (thisPlatform.playerIsOnPlatform()) {
      thisPlatform.x += px;
      player.x += px;
    }
  };

  this.up = function(px) {

    if (!isCollide(player, thisPlatform)) {
      thisPlatform.y -= px;
    }
    else if (thisPlatform.playerIsOnPlatform()) {
      thisPlatform.y -= px;
      player.y -= px;
    }
  };

  this.down = function(px) {

    if (!isCollide(player, thisPlatform)) {
      thisPlatform.y += px;
    }
    else if (thisPlatform.playerIsOnPlatform()) {
      thisPlatform.y += px;
      player.y += px;
    }
  };

  this.currentStep = 0;
  this.currentCoords = {left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0};

  this.setup = function(steps, directions, speed) {
    if (steps.length != directions.length) {
      return;
    }

    this.currentCoords.left = thisPlatform.originX;
    this.currentCoords.right = thisPlatform.originX + thisPlatform.width;
    this.currentCoords.top = thisPlatform.originY;
    this.currentCoords.bottom = thisPlatform.originY + thisPlatform.height;

    this.steps = steps;
    this.directions = directions;
    this.speed = speed;
  }

  this.loop = function() {

    directions = this.directions;
    steps = this.steps;
    speed = this.speed;
    currentStep = this.currentStep;
    currentCoords = this.currentCoords;

    if (directions[currentStep] == "L") {
      if (thisPlatform.left() == currentCoords.left - steps[currentStep] * speed && thisPlatform.right() == currentCoords.right - steps[currentStep] * speed) {
        currentCoords.left -= steps[currentStep] * speed;
        currentCoords.right -= steps[currentStep] * speed;
        currentStep++;
      }
    }

    if (directions[currentStep] == "R") {
      if (thisPlatform.left() == currentCoords.left + steps[currentStep] * speed && thisPlatform.right() == currentCoords.right + steps[currentStep] * speed) {
        currentCoords.left += steps[currentStep] * speed;
        currentCoords.right += steps[currentStep] * speed;
        currentStep++;
      }
    }

    if (directions[currentStep] == "U") {
      if (thisPlatform.top() == currentCoords.top - steps[currentStep] * speed && thisPlatform.bottom() == currentCoords.bottom - steps[currentStep] * speed) {
        currentCoords.top -= steps[currentStep] * speed;
        currentCoords.bottom -= steps[currentStep] * speed;
        currentStep++;
      }
    }

    if (directions[currentStep] == "D") {
      if (thisPlatform.top() == currentCoords.top + steps[currentStep] * speed && thisPlatform.bottom() == currentCoords.bottom + steps[currentStep] * speed) {
        currentCoords.top += steps[currentStep] * speed;
        currentCoords.bottom += steps[currentStep] * speed;
        currentStep++;
      }
    }

    if (directions[currentStep] == "L") {
      this.left(speed);
    }

    if (directions[currentStep] == "R") {
      this.right(speed);
    }

    if (directions[currentStep] == "U") {
      this.up(speed);
    }

    if (directions[currentStep] == "D") {
      this.down(speed);
    }

    if (currentStep == steps.length) {
      currentStep = 0;
    }

    this.currentStep = currentStep;
  }
}

=======
>>>>>>> dbf0a22bae4f11fba2497cffc6583a799441bf8e
// Platforms
function Platform(x, y, width, height) {
  GameObject.call(this, x, y, width, (height <= GRAVITY_STEP) ? this.height = GRAVITY_STEP + 1 : height);

  this.playerIsOnPlatform = function () {
    if ((isCollide(player, this)) && ((platform.top() <= player.bottom()) && (player.bottom() <= platform.bottom()))) {
      return true;
    }
    else {
      return false;
    }
  }

  this.draw = function () {
    rect(x, y, width, height);
  }

}
Platform.prototype = Object.create(GameObject.prototype);

//Calcualte platforms
function calculatePlatforms(platforms) {
  for (var i = 0; i < platforms.length; i++) {
    calculatePlatform(platforms[i]);
  }
}

//Draw platforms
function drawPlatforms(platforms) {
  for (var i = 0; i < platforms.length; i++) {
    platforms[i].draw();
  }
}

// Platform functions
function calculatePlatform(platform) {
  var headBump = false;
  if (player.jump.jumping) {
    if (isCollide(player, platform)) {
      // If player head touch the platform, stop him from going up
      if ((platform.top() <= player.top()) && (player.top() <= platform.bottom())) {
        player.y = platform.bottom();
        headBump = true;
        stopJump();
        headBump = true;
      }
    }
  }

  if (isCollide(player, platform)) {
    // If player feet touch the platform
    if ((platform.top() <= player.bottom()) && (player.bottom() <= platform.bottom())) {
      player.setBottomTo(platform.top());
      return
    }

    if (headBump) {
      return;
    }

    // If player bumps from the left
    if (player.midX() < platform.midX()) {
      var startX = player.x
      if (player.x > MARGIN) {
          player.x = player.x - player.movement.moveSpeed;
      }
      return
    } else {
      // If player bumps from the right
      var startX = player.x
      if (player.right() < SCREEN_WIDTH - MARGIN) {
          player.x = player.x + player.movement.moveSpeed;
      }
    }
  }
}
