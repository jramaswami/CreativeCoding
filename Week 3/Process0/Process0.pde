ElementManager em;

void setup() {
  size(600, 600);
  
  /**
   * r = 20; mv = 2.5; numElements = 500; GrayTonedLinks; HiddenElements
   */
  
  float r = 20;
  float mv = 2.5;
  int numElements = 500;
  
  em = new ElementManager();
  em.setMaxVelocity(mv);
  em.setElementRadius(r);
  em.setLinkDrawingStrategy(new OscillatingColoredLinks(0.1));
  for (int i = 0; i < numElements; i++) {
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
