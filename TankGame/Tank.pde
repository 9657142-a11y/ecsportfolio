class Tank {
  int x, y, speed;
  PImage up, down, left, right;
  char dir;

  Tank() {
    x = 100;
    y = 100;
    speed = 5;

    up = loadImage("tank1.png");
    down = loadImage("stank1.png");
    left = loadImage("atank1.png");
    right = loadImage("dtank1.png");

    dir = 'd';
  }

  void display() {
    imageMode(CENTER);

    if (dir == 'w') image(up, x, y);
    if (dir == 's') image(down, x, y);
    if (dir == 'a') image(left, x, y);
    if (dir == 'd') image(right, x, y);
  }

  void move(char d) {
    dir = d;

    if (d == 'w') y -= speed;
    if (d == 's') y += speed;
    if (d == 'a') x -= speed;
    if (d == 'd') x += speed;
  }
}
