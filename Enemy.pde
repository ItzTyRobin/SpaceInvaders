class Enemy {
  float x, y;
  float speed = 4;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    image(alienImage, x, y, alienImage.width * 0.04, alienImage.height * 0.04);
  }

  void move() {
    x += speed;
    if (x > width - 15 || x < 15) {
      speed *= -1;
      y += 30;
    }
  }

  boolean reachesPlayer() {
    return y > height - 60;
  }

  boolean hits(Bullet b) {
    return dist(b.x, b.y, x, y) < 15;
  }
}
