class ElementManager {
  ArrayList<Element0> elements;
  ArrayList<Link0> links;

  ElementManager() {
    this.elements = new ArrayList<Element0>();
  }

  void addElement(Element0 e) {
    this.elements.add(e);
  }

  private void detectCollisions() {
    this.links = new ArrayList<Link0>();
    int sz = this.elements.size();
    int n = 0;
    for (Element0 e1 : this.elements) {
      n++;
      for (int i = n; i < sz; i++) {
        Element0 e2 = this.elements.get(i);
        if (e1.position.dist(e2.position) < e1.radius + e2.radius) {
          // collision detected
          this.links.add(new Link0(e1, e2));
        }
      }
    }
  }

  void update() {

    this.detectCollisions();

    for (Element0 e : this.elements) {
      e.update();
    }
  }

  void draw() {
    for (Element0 e : this.elements) {
      e.draw();
    }

    for (Link0 l : this.links) {
      l.draw();
    }
  }

}

