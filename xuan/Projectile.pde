var Speed = 10;

function Projectile(pImage, x, y) {
  this.pImage = pImage;
  this.startX = x;
  GameObject.call(this, x, y - pImage.height, pImage.width, pImage.height);

  this.draw = function () {
    this.x -= Speed;
    if (this.x < 0) {
      this.x = this.startX;
    }
    image(this.pImage, this.x, this.y);
  }
}
Projectile.prototype = Object.create(GameObject.prototype);
