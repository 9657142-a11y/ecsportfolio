class Obstacle {
  float x, y;
  float speedX;
  PImage img;
  int size;

  Obstacle(float x, float y) {
    this.x = x;
    this.y = y;

    size = 60;
    img = loadImage("hotdog.png");

    speedX = random(2, 5);
    if (random(1) < 0.5) speedX *= -1;
  }

  void move() {
    x += speedX;

    if (x > width + size) {
      x = -size;
      y = random(height);
    }
    if (x < -size) {
      x = width + size;
      y = random(height);
    }
  }

  void display() {
    imageMode(CENTER);
    if (img != null) {
      image(img, x, y, size, size);
    } else {
      fill(255, 0, 0);
      ellipse(x, y, size, size);
    }
  }

  boolean collidesWith(float tx, float ty) {
    return dist(tx, ty, x, y) < size / 2;
  }
}
