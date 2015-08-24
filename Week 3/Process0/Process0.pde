ElementManager em;

void setup() {
  size(600, 600);
  
  float r = 20;
  float mv = 2.5;
  
  em = new ElementManager();
  em.setMaxVelocity(mv);
  em.setElementRadius(r);
  em.setLinkDrawingStrategy(new GrayTonedLinks());
  for (int i = 0; i < 500; i++) {
    em.addRandomElement();
  }
  background(0);
}

void draw() {
  blendMode(BLEND);
  fill(0, 2.5);
  rect(0, 0, width, height);  
  em.update();
  em.draw();
}
