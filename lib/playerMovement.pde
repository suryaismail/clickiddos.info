var LEFT = 37,
    UP = 38,
    RIGHT = 39,
    DOWN = 40,
    SPACE = 32;

function playerMovementPress(keycode, player, platforms, margin, screenWidth, floor) {
    var playerIsOnPlatform = false;
    for (var i = 0; i < platforms.length; i++) {
      if (isCollide(player, platforms[i])) {
        playerIsOnPlatform = true;
        break;
      }
    }
    switch (keycode) {
      case LEFT:
          player.movement.movingLeft = true;
          break;

      case RIGHT:
          player.movement.movingRight = true;
          break;

      case SPACE:
          if ((player.bottom() == floor) || playerIsOnPlatform) {
            player.jump.jumping = true;
          }
          break;

      default:
          break;
    }
}

function playerMovementRelease(keycode, player, margin, screenWidth, floor) {
    switch (keycode) {
      case LEFT:
          player.movement.movingLeft = false;
          break;

      case RIGHT:
          player.movement.movingRight = false;
          break;

      default:
          break;
    }
}
