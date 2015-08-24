class ElementManager {
  ArrayList<Element0> elements;
  ArrayList<Link0> links;

  float BALL_RADIUS = 50;
  float MAX_VELOCITY = 3;

  ElementManager() {
    this.elements = new ArrayList<Element0>();
  }

  void addElement(Element0 e) {
    this.elements.add(e);
  }

  void addRandomElement() {
    float x = random(width);
    float y = random(height);
    float x_vel = random(this.MAX_VELOCITY);
    float y_vel = random(this.MAX_VELOCITY);
    int i = this.elements.size() + 1;
    em.addElement(new Element0(new PVector(x, y), new PVector(x_vel, y_vel), this.BALL_RADIUS, i));
  }
  
  void removeRandomElement() {
    // choose random element
    int i = int(random(this.elements.size()));
    
    // get it
    Element0 e = this.elements.get(i);
    
    // see if it has any links
    ArrayList<Link0> l2r = new ArrayList<Link0>();
    for (Link0 l : this.links) {
      if (l.e1 == e || l.e2 == e) {
        l2r.add(l);
      }
    }
    
    // remove links
    for (Link0 l: l2r) {
      this.links.remove(l);
    }
    
    // remove element
    elements.remove(e);
  }
  
  void changeVelocities(PVector delta) {
    for (Element0 e : elements) {
      e.velocity.add(delta);
    }
  }

  void accelerateAll(float delta) {
    for (Element0 e : elements) {
      e.velocity.mult(delta);
    }
  }
  
  private void detectCollisions() {
    resetCollisions();
    int sz = this.elements.size();
    int n = 0;
    for (Element0 e1 : this.elements) {
      n++;
      for (int i = n; i < sz; i++) {
        Element0 e2 = this.elements.get(i);
        if (e1.position.dist(e2.position) < e1.radius + e2.radius) {
          // collision detected
          e1.intersecting = true;
          e2.intersecting = true;
          this.links.add(new Link0(e1, e2));
        }
      }
    }
  }
  
  private void resetCollisions() {
    this.links = new ArrayList<Link0>();
    for (Element0 e : this.elements) {
      e.intersecting = false;
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

