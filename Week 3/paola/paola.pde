class Ball {
 
  // I think you meant velocity when
  // you had a variable called easing
  float velocity = 1;
  float[] velocityVector = new float[2];
  
  // These will be randomized in
  // the constructor so there
  // is no need to initialize them
  float[] targetX;
  float[] targetY;
  
  float x, y; // initial position
  
  // I changed the name to better describe
  // what the variable is holding
  int currentTarget;
  float radius;
  
  Ball(float x, float y) {
    // I believe this is more idiomatic
    this.x = x;
    this.y = y;
        
    this.radius = 10.0;
    
    // Moved random target choice here
    // because we'll be adding balls
    // on key press UP and I only
    // want to write this code once.
    this.targetX = new float[5];
    this.targetY = new float[5];
    for (int j = 0; j < 5; j++) {
      this.targetX[j] = random(width);
      this.targetY[j] = random(height);      
    }
    
    chooseRandomTarget();
  }

  void chooseRandomTarget() {
    this.currentTarget = int(random(1, 4));
    
    // calculate a velocity vector    
    float deltaX = this.targetX[this.currentTarget] - this.x;
    float deltaY = this.targetY[this.currentTarget] - this.y;
    
    // scale velocity vector to match ball's velocity
    float distance = sqrt(sq(deltaX) + sq(deltaY));
    
    this.velocityVector[0] = deltaX * this.velocity / distance;
    this.velocityVector[1] = deltaY * this.velocity / distance;
  }
  
  // So I replaced your run
  // method with an update()
  // method just because that's
  // how I learned to do motion.
  void update() {
    
    // TODO: what if velocity is so high that the ball passes through the target?
    // see if we "hit" the target point
    float deltaX = this.targetX[this.currentTarget] - this.x;
    float deltaY = this.targetY[this.currentTarget] - this.y;
    if (abs(deltaX) < this.radius && abs(deltaY) < this.radius) { //<>//
      // pick new random target
      this.chooseRandomTarget();
      this.update();
    }
    
    // apply velocity vector to move ball
    this.x = this.x + this.velocityVector[0];
    this.y = this.y + this.velocityVector[1];
  } 
  
  void draw() {
    // draw ball
    fill(255,0,0);
    ellipse(this.x, this.y, this.radius*2, this.radius*2);
    
    // draw target
    fill(0,0,0);
    ellipse(this.targetX[this.currentTarget], this.targetY[this.currentTarget], 1, 1); 
  }
  
  void changeVelocity(float deltaV) {
    this.velocity = this.velocity + deltaV;
  }
}


// I changed this to plural
// because it more accurately
// describes what the variable
// is.
// Changed to array list
// to allow for dynamic
// number of balls.
ArrayList<Ball> myBalls; 

void setup() {
  size(700, 400);
  background(180);
  
  // Added this so that we
  // can draw the Ball.
  ellipseMode(CENTER);
  
  // This should be declared in
  // setup because you don't use
  // it anywhere else.
  float initX, initY;
  
  // This would allow you to
  // change this and have more
  // (or less) balls. E.g
  int numBalls = 3;
  // or
  // int numBalls = 10;
  myBalls = new ArrayList<Ball>();
  
  for (int i=0; i< numBalls; i++) {
    initX = random(width);
    initY = random(height);  
    myBalls.add(new Ball(initX, initY));
  }
}

void draw() {
  // clear background
  background(180);
  for (int i=0; i< myBalls.size(); i++) {
    myBalls.get(i).update();
    myBalls.get(i).draw();
  }
}

void keyReleased() {
  if (' ' == key) {
    for (int i=0; i< myBalls.size(); i++) {
      myBalls.get(i).chooseRandomTarget();
    }
  } else if (UP == keyCode) {
    // add ball when user presses up arrow
    myBalls.add(new Ball(random(width), random(height)));
  } else if (DOWN == keyCode) {
    // remove ball when user presses down arrow
    // TODO: what if there are no balls?
    myBalls.remove(int(random(myBalls.size())));
  } else if ('f' == key) {
    for (int i=0; i< myBalls.size(); i++) {
      myBalls.get(i).changeVelocity(1);
    }
  } else if ('s' == key) {
    for (int i=0; i< myBalls.size(); i++) {
      myBalls.get(i).changeVelocity(-1);
    }
  }
}