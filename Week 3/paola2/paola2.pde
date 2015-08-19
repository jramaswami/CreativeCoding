class Ball {
 
  // I think you meant velocity when
  // you had a variable called easing
  float velocity = 0.01;
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
  
  Ball(float x, float y, float[] Tx, float[] Ty) {
    // I believe this is more idiomatic
    this.x = x;
    this.y = y;
    
    // You already declared these variables.
    // You do not need to declare the variables again,
    // so instead of float targetX = float[] Tx you do 
    // the following:
    this.targetX = Tx;
    this.targetY = Ty;
    
    this.radius = 10.0;
    
    // I took out setting a targets sequence
    // because you appear to want it to be
    // randomized
    chooseRandomTarget();
  }

  void chooseRandomTarget() {
    this.currentTarget = int(random(1, 4));
    
    // calculate a velocity vector    
    float deltaX = this.targetX[this.currentTarget] - this.x;
    float deltaY = this.targetY[this.currentTarget] - this.y;
    
    this.velocityVector[0] = deltaX * this.velocity;
    this.velocityVector[1] = deltaY * this.velocity;
  }
  
  // So I replaced your run
  // method with an update()
  // method just because that's
  // how I learned to do motion.
  void update() {
    
    // see if we "hit" the target point
    float deltaX = this.targetX[this.currentTarget] - this.x;
    float deltaY = this.targetY[this.currentTarget] - this.y;
    if (abs(deltaX) < 0.1 && abs(deltaY) < 0.1) { //<>//
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
    ellipse(this.x, this.y, this.radius, this.radius);
    
    // draw target
    fill(0,0,0);
    ellipse(this.targetX[this.currentTarget], this.targetY[this.currentTarget], 1, 1);
    
  }
}


// I changed this to plural
// because it more accurately
// describes what the variable
// is.
Ball[] myBalls; 

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
  // int numBalls = 3;
  // or
  int numBalls = 10;
  myBalls = new Ball[numBalls];
  
  for (int i=0; i< myBalls.length; i++) {
    initX = random(width);
    initY = random(height);
    
    // I'm not sure what you were trying to do
    // here so I made random targets
    float tarX[] = new float[5];
    float tarY[] = new float[5];
    for (int j = 0; j < 5; j++) {
      tarX[j] = random(width);
      tarY[j] = random(height);      
    }
    // you don't need this because
    // the randomizing takes place 
    // in the Ball constructor
    // change= int(random(1, 4));
  
    myBalls[i] = new Ball(initX, initY, tarX, tarY);
  }
}

void draw() {
  // clear background
  background(180);
  for (int i=0; i< myBalls.length; i++) {
    myBalls[i].update();
    myBalls[i].draw();
  }
}

void keyReleased() {
  for (int i=0; i< myBalls.length; i++) {
    myBalls[i].chooseRandomTarget();
  }
}