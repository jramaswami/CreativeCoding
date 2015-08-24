ElementManager em;

void setup() {
  size(600, 600);
  em = new ElementManager();
  for (int i = 0; i < 5; i++) {
    em.addRandomElement();
  }
}

void draw() {
  background(255);
  em.update();
  em.draw();
}

void keyPressed() {
  switch (keyCode) {
  case RIGHT:
    em.accelerateAll(1.1);
    break;
  case LEFT:
    em.accelerateAll(0.9);
    break;
  case UP:
    em.addRandomElement();
    break;
  case DOWN:
    em.removeRandomElement();
    break;
  }
}

