class Link0 {
  Element0 e1;
  Element0 e2;
  
  Link0(Element0 e1, Element0 e2) {
    this.e1 = e1;
    this.e2 = e2;
  }
  
  void draw() {
    color c = lerpColor(e1.circleColor, e2.circleColor, 0.5);
    stroke(c);
    strokeWeight(2);
    noFill();
    line(e1.position.x, e1.position.y, e2.position.x, e2.position.y);
  }
}
