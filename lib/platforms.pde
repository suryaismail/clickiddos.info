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
      player.x = player.x - player.playerMovement.moveSpeed;
      return
    } else {
      // If player bumps from the right
      var startX = player.x
      player.x = player.x + player.playerMovement.moveSpeed;
    }
  }
}
