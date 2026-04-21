PImage bg;
Tank tank1;
Obstacle[] obs;
ArrayList<Bullet> bullets;

boolean tankAlive = true;

void setup() {
  size(500, 500);
  bg = loadImage("bg2.png");

  tank1 = new Tank();

  obs = new Obstacle[5];
  for (int i = 0; i < obs.length; i++) {
    obs[i] = new Obstacle(random(width), random(height));
  }

  bullets = new ArrayList<Bullet>();
}

void draw() {
  background(127);
  imageMode(CORNER);
  image(bg, 0, 0, width, height); // ✅ FIXED BACKGROUND

  // ===== HOTDOGS =====
  for (int i = 0; i < obs.length; i++) {
    if (obs[i] != null) {
      obs[i].move();
      obs[i].display();

      if (tankAlive && obs[i].collidesWith(tank1.x, tank1.y)) {
        tankAlive = false;
      }
    }
  }

  // ===== BULLETS =====
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.move();
    b.display();

    if (b.offScreen()) {
      bullets.remove(i);
      continue;
    }

    for (int j = 0; j < obs.length; j++) {
      if (obs[j] != null && obs[j].collidesWith(b.x, b.y)) {
        obs[j] = null;
        bullets.remove(i);
        break;
      }
    }
  }

  // ===== TANK =====
  if (tankAlive) {
    tank1.display();
  } else {
    fill(255, 0, 0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2);
  }
}

void keyPressed() {
  if (!tankAlive) return;

  if (key == 'w') tank1.move('w');
  if (key == 's') tank1.move('s');
  if (key == 'a') tank1.move('a');
  if (key == 'd') tank1.move('d');

  // 🔫 shoot
  if (key == ' ') {
    bullets.add(new Bullet(tank1.x, tank1.y, tank1.dir));
  }
}

// ===== BULLET CLASS =====
class Bullet {
  float x, y;
  float speed = 8;
  char dir;

  Bullet(float x, float y, char dir) {
    this.x = x;
    this.y = y;
    this.dir = dir;
  }

  void move() {
    if (dir == 'w') y -= speed;
    if (dir == 's') y += speed;
    if (dir == 'a') x -= speed;
    if (dir == 'd') x += speed;
  }

  void display() {
    fill(255, 255, 0);
    ellipse(x, y, 10, 10);
  }

  boolean offScreen() {
    return x < 0 || x > width || y < 0 || y > height;
  }
}
