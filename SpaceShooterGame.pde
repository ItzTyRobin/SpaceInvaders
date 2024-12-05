// Global Variables
Player player;
ArrayList<Bullet> bullets;
ArrayList<Bullet> enemyBullets;
ArrayList<Enemy> enemies;
int score = 0;
boolean gameOver = false;
boolean canShoot = true; // Cooldown
int shootCooldown = 250; // Cooldown time in milliseconds
int lastShotTime = 0;
boolean spacePressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int level = 1;

PImage ship, alienImage;

import processing.sound.*;
SoundFile spaceMusic;
SoundFile bulletSound;

void setup() {
  size(600, 800);

  // Load assets
  spaceMusic = new SoundFile(this, "spaceMus.wav");
  spaceMusic.loop();
  bulletSound = new SoundFile(this, "Pew.wav");
  bulletSound.amp(0.1);

  ship = loadImage("Ship.png");
  alienImage = loadImage("Alien.png");
  imageMode(CENTER);

  initializeGame();
}

void initializeGame() {
  player = new Player(width / 2, height - 50);
  bullets = new ArrayList<Bullet>();
  enemyBullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      enemies.add(new Enemy(120 + i * 100, 50 + j * 60));
    }
  }
}

void draw() {
  background(42);

  if (!gameOver) {
    // Player
    player.display();
    player.move();

    // Bullets
    updateBullets();

    // Enemies
    updateEnemies();

    // Display score
    displayScore();

    // Check win condition
    checkWin();

    // Shooting cooldown
    if (!canShoot && millis() - lastShotTime >= shootCooldown) {
      canShoot = true;
    }
  } else {
    displayGameOver();
  }
}

void updateBullets() {
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.display();
    b.move();
    if (b.offScreen()) bullets.remove(i);
  }
}


void updateEnemies() {
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.display();
    e.move();
    if (e.reachesPlayer()) {
      gameOver = true;
    }

    for (int j = bullets.size() - 1; j >= 0; j--) {
      Bullet b = bullets.get(j);
      if (e.hits(b)) {
        score += 10;
        enemies.remove(i);
        bullets.remove(j);
        break;
      }
    }
  }
}

void displayScore() {
  fill(255);
  textSize(20);
  text("Score: " + score, 10, 30);
}

void displayGameOver() {
  fill(255);
  textSize(50);
  textAlign(CENTER);
  text("Game Over", width / 2, height / 2);
  textSize(20);
  text("Press 'R' to Restart", width / 2, height / 2 + 50);
}

void checkWin() {
  if (enemies.size() == 0) {
    level++;
    initializeGame();
    for (Enemy e : enemies) {
      e.speed += level; // Increase enemy speed
    }
  }
}

void keyPressed() {
  if (key == ' ' && canShoot && !spacePressed) {
    bullets.add(new Bullet(player.x, player.y));
    canShoot = false;
    lastShotTime = millis();
    spacePressed = true;
    if (bulletSound != null) bulletSound.play();
  }
  if (key == 'a' || key == 'A') leftPressed = true;
  if (key == 'd' || key == 'D') rightPressed = true;
  if (key == 'r' || key == 'R') restartGame();
}

void keyReleased() {
  if (key == ' ') spacePressed = false;
  if (key == 'a' || key == 'A') leftPressed = false;
  if (key == 'd' || key == 'D') rightPressed = false;
}

void restartGame() {
  score = 0;
  gameOver = false;
  canShoot = true;
  spacePressed = false;
  level = 1;
  initializeGame();
}
