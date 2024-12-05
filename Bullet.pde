class Bullet {
  float x, y;
  float speed = 8;

  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    fill(255, 255, 0);
    rect(x - 2, y - 10, 4, 10);
  }

  void move() {
    y -= speed;
  }

  boolean offScreen() {
    return y < 0;
  }

  boolean hits(Player player) {
    return dist(x, y, player.x, player.y) < 15;
  }
}
