function playerMovement(keycode, player, margin, screenWidth, floor) {
  var LEFT = 37,
      UP = 38,
      RIGHT = 39,
      DOWN = 40,
      SPACE = 32;

  switch (keycode) {
    case LEFT:
        if (!player.movingLeft & player.x > margin) {
          player.movingLeft = true;
        }
        else {
          player.movingLeft = false;
        }
        break;
    case RIGHT:
        if (!player.movingRight & player.x < screenWidth - margin) {
          player.movingRight = true;
        }
        else {
          player.movingRight = false;
        }
        break;
    case SPACE:
        if (player.bottom() == floor) {
          player.jumping = true;
        }
        break;
    default:
        break;
  }
}
