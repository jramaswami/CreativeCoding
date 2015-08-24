class Element0 {
  PVector position;
  PVector velocity;
  int copyNumber;
  float radius;
  color circleColor;
  boolean intersecting;
  float transparencyOnCollision;
  
  Element0(PVector initialPosition, PVector velocity, float radius, int copyNumber) {
    this.position = initialPosition;
    this.velocity = velocity;
    this.copyNumber = copyNumber;
    this.radius = radius;
    this.intersecting = false;
    this.transparencyOnCollision = 50;
    
    if (this.isOdd()) {
      this.circleColor = color(255, 0, 0);
    } else {
      this.circleColor = color(0, 0, 255);
    }
  }

  boolean isOdd() {
    return (1 == this.copyNumber % 2);
  }
  
  PVector getPosition() {
    return this.position;
  }

  void draw() {
    
    strokeWeight(2);
    if (intersecting) {
      noStroke();
      fill(this.circleColor, this.transparencyOnCollision);
    } else {
      noStroke();
      fill(this.circleColor);
    }
    ellipseMode(CENTER);
    ellipse(this.position.x, this.position.y, this.radius * 2, this.radius * 2);
  }

  private void reflectX() {
    this.velocity.x = this.velocity.x * -1;
  }

  private void reflectY() {
    this.velocity.y = this.velocity.y * -1;
  }

  void update() {
    // move ball
    this.position.x = this.position.x + this.velocity.x;
    this.position.y = this.position.y + this.velocity.y;

    // make sure ball is fully on canvas
    if (this.position.x < this.radius) {
      this.position.x = this.radius;
      this.reflectX();
    }
    if (this.position.x > width - this.radius) {
      this.position.x = width - this.radius;
      this.reflectX();
    }
    if (this.position.y < this.radius) {
      this.position.y = this.radius;
      this.reflectY();
    }
    if (this.position.y > height - this.radius) {
      this.position.y = height - this.radius;
      this.reflectY();
    }
  }
}

