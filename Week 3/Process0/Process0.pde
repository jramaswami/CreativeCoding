ElementManager em;
LinkDrawingStrategy[] ldss;
String[] ldsNames;

void setup() {
  size(600, 600);
  
  /**
   * r = 20; mv = 2.5; numElements = 500; GrayTonedLinks; HiddenElements
   */
  ldss = new LinkDrawingStrategy[3];
  ldsNames = new String[3];
  ldss[0] = new OscillatingColoredLinks(0.1);
  ldsNames[0] = "Oscillating Colored Links";
  ldss[1] = new GrayTonedLinks();
  ldsNames[1] = "Gray Toned Links";
  ldss[2] = new ThinWhiteLinks();
  ldsNames[2] = "White Links";
  
  frameRate(90);
  
  float r = 20;
  float mv = 2.5;
  int numElements = 500;
  
  em = new ElementManager();
  em.setMaxVelocity(mv);
  em.setElementRadius(r);
  em.setLinkDrawingStrategy(ldss[0]);
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

void keyPressed() {
  switch (char(key)) {
    case '1':
      em.setLinkDrawingStrategy(ldss[0]);
      println("Changing to drawing strategy: " + ldsNames[0]);
      break;
    case '2':
      em.setLinkDrawingStrategy(ldss[1]);
      println("Changing to drawing strategy: " + ldsNames[1]);
      break;
    case '3':
      em.setLinkDrawingStrategy(ldss[2]);
      println("Changing to drawing strategy: " + ldsNames[2]);
      break;
  }
}
