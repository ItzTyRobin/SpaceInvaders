class Player {
  float x, y;
  float speed = 5;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    image(ship, x, y, ship.width * 0.06, ship.height * 0.06);
  }

  void move() {
    if (leftPressed) x -= speed;
    if (rightPressed) x += speed;
    x = constrain(x, 15, width - 15);
  }
}
