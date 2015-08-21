class Top {
  Point position;
  float dx, dy;
  color topColor;
  float radius;
  
  Top(Point p) {
    this.position = p;
    
    // dx and dy are the small change in position each frame
    this.dx = random(-1, 1);
    this.dy = random(-1, 1);
    
    this.radius = 5;
    this.topColor = color(255,0,0);
  }
  
  Point getPosition() {
    return this.position;
  }
  
  private void setPosition(Point p) {
    this.position = p;
  }
  
  void update() {
    // calculate new position
    this.setPosition(
      new Point(
          this.getPosition().getX() + this.dx, 
          this.getPosition().getY() + this.dy));
  
    float max = 1;
    float min = 0.5;
    
    //When the shape hits the edge of the window, it reverses its direction and changes velocity
    if (this.getPosition().getX() > width-100 || this.getPosition().getX() < 100) {
     this.dx = this.dx > 0 ? -random(min, max) : random(min, max);
    }
  
    if (this.getPosition().getY() > height-100 || this.getPosition().getY() < 100) {
      this.dy = this.dy > 0 ? -random(min, max) : random(min, max);
    }
  }
  
  void draw() {
    // show the top
    fill(this.topColor);
    ellipse(this.getPosition().getX(), this.getPosition().getY(), this.radius, this.radius);
  }    
}