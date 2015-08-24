class Link0 {
  Element0 e1;
  Element0 e2;

  Link0(Element0 e1, Element0 e2) {
    this.e1 = e1;
    this.e2 = e2;
  }

  void draw(LinkDrawingStrategy drawStrategy) {
    drawStrategy.draw(this);
  }
}

interface LinkDrawingStrategy {
  void draw(Link0 l);
}

class LerpLinkedElements implements LinkDrawingStrategy {
  void draw(Link0 l) {
    color c = lerpColor(l.e1.circleColor, l.e2.circleColor, 0.5);
    stroke(c);
    strokeWeight(2);
    noFill();
    line(l.e1.position.x, l.e1.position.y, l.e2.position.x, l.e2.position.y);
  }
}

class GrayTonedLinks implements LinkDrawingStrategy {
  void draw(Link0 l) {
    stroke(180);
    strokeWeight(0.5);
    line(l.e1.position.x, l.e1.position.y, l.e2.position.x, l.e2.position.y);
  }
}

class ThinBlackLinks implements LinkDrawingStrategy {
  void draw(Link0 l) {
    stroke(0);
    strokeWeight(0.25);
    line(l.e1.position.x, l.e1.position.y, l.e2.position.x, l.e2.position.y);
  }
}

class ThinWhiteLinks implements LinkDrawingStrategy {
  void draw(Link0 l) {
    stroke(255);
    strokeWeight(0.25);
    line(l.e1.position.x, l.e1.position.y, l.e2.position.x, l.e2.position.y);
  }
}

class OscillatingColoredLinks implements LinkDrawingStrategy {
  float speed;
  OscillatingColoredLinks(float speed) {
    this.speed = speed;
  }
  
  void draw(Link0 l) {
      float r = map(sin(frameCount*speed),-1,1,0,255);
      float g = map(cos(frameCount*speed),-1,1,0,255);
      float b = map(-sin(frameCount*speed),-1,1,0,255);
      stroke(r,g,b);
      strokeWeight(0.25);
      line(l.e1.position.x, l.e1.position.y, l.e2.position.x, l.e2.position.y);
  }
}
