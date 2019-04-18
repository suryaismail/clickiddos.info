function playerMovement(keycode, player, margin, screenWidth, floor) {
  var LEFT = 37,
      UP = 38,
      RIGHT = 39,
      DOWN = 40,
      SPACE = 32;

      console.log("playerMovement keycode:" + keycode + " " + player.movement.movingLeft);

  switch (keycode) {
    case LEFT:
        if (!player.movement.movingLeft & player.x > margin) {
          player.movement.movingLeft = true;
        }
        else {
          player.movement.movingLeft = false;
        }
        break;
    case RIGHT:
        if (!player.movement.movingRight & player.x < screenWidth - margin) {
          player.movement.movingRight = true;
        }
        else {
          player.movement.movingRight = false;
        }
        break;
    case SPACE:
        if (player.bottom() == floor) {
          player.movement.jumping = true;
        }
        break;
    default:
        break;
  }
}
