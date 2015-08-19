class Ball {
  
  // These are class constants. They will
  // determine if the ball's velocity is
  // variable, meaning that it speed is
  // based on the distance between the
  // ball and target; or constant, which
  // means the ball travels at a constant
  // velocity no matter how far the target
  // is from the ball.
  static final int VARIABLE_VELOCITY = 0;
  static final int CONSTANT_VELOCITY = 1;
  
  // I think you meant velocity when
  // you had a variable called easing
  float velocity = 1;
  float[] velocityVector = new float[2];
  
  // These will be randomized in
  // the constructor so there
  // is no need to initialize them
  float[] targetX;
  float[] targetY;
  
  // Since you want the balls to go
  // to the targets in a different order.
  int[] targetOrder;
  
  float x, y; // initial position
  
  int currentTargetOrderIndex;
  
  int velocityCalculationType;
  
  float radius;
  
  Ball(float x, float y, float[] Tx, float[] Ty, int[] targetOrder) {
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
    
    this.targetOrder = targetOrder;
    this.currentTargetOrderIndex = 0;
    
    this.velocityCalculationType = Ball.VARIABLE_VELOCITY;
    this._updateVelocityVector();
  }

  // this will allow you to set the target
  // order if you want to choreograph
  void setTargetOrder(int[] targetOrder) {
    this.targetOrder = targetOrder;
  }
  
  // this shuffles the target order
  // so that it is random
  void shuffleTargetOrder() {
    
    // shuffle the target order array
    int n = this.targetX.length;
    int t;
    for (int i = 0; i < n; i++) {
      // pick random item
      // excepting the last item
      int r = int(random(0, n - 1));
      // swap random item and next item 
      // in the array
      t = targetOrder[r];
      targetOrder[r] = targetOrder[r + 1];
      targetOrder[r + 1] = t;
    }
    this.currentTargetOrderIndex = 0;
    
    this._updateVelocityVector();
  }
  
  int _getTargetIndex() {
    return this.targetOrder[this.currentTargetOrderIndex];
  }
  
  void _updateVelocityVector() {
    // update the velocity vector    
    float deltaX = this.targetX[this._getTargetIndex()] - this.x;
    float deltaY = this.targetY[this._getTargetIndex()] - this.y;
     
    if (Ball.CONSTANT_VELOCITY == this.velocityCalculationType) {
      // scale velocity vector to match ball's velocity
      float distance = sqrt(sq(deltaX) + sq(deltaY));
      this.velocityVector[0] = deltaX * this.velocity / distance;
      this.velocityVector[1] = deltaY * this.velocity / distance;
    } else {
      // Muliply velocity by 0.01 because otherwise the unscaled
      // vector makes the balls go way to fast.
      this.velocityVector[0] = deltaX * this.velocity * 0.01;
      this.velocityVector[1] = deltaY * this.velocity * 0.01;
    }
  }
  
  void changeVelocity(float deltaV) {
    this.velocity = this.velocity + deltaV;
    this._updateVelocityVector();
  }  
  
  // So I replaced your run
  // method with an update()
  // method just because that's
  // how I learned to do motion.
  void update() {
    
    float deltaX = this.targetX[this._getTargetIndex()] - this.x;
    float deltaY = this.targetY[this._getTargetIndex()] - this.y;
    
    // see if we "hit" the target point
    if (abs(deltaX) < this.radius && abs(deltaY) < this.radius) { //<>//
      // pick next target
      this.currentTargetOrderIndex++;
      // don't fall off then end; go back
      // to the beginning if the currentTarget
      // is greater than the length of the 
      // target array
      if (this.currentTargetOrderIndex >= targetX.length) {
        this.currentTargetOrderIndex = 0;
      }
      this._updateVelocityVector();
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
    ellipse(this.targetX[this._getTargetIndex()], this.targetY[this._getTargetIndex()], 1, 1);
  }
}


// I changed this to plural
// because it more accurately
// describes what the variable
// is.
Ball[] myBalls; 

void setup() {
  size(700, 700);
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
  int numBalls = 3;
  myBalls = new Ball[numBalls];

  // So no here are the non-random
  // target arrays
  float tarX[] = {50, 100, 150, 200, 400};
  float tarY[] = {100, 200, 300, 400, 500};
  int[] targetOrder = {0, 1, 2, 3, 4};

  for (int i=0; i< myBalls.length; i++) {
    initX = random(width);
    initY = random(height);
    
    // Copy array so that each ball gets its
    // own array.  If you don't, all the balls
    // will be using the same array because arrays
    // are passed by *reference* not by value.
    int[] to = new int[targetOrder.length];
    arrayCopy(targetOrder, to);
    float[] tx = new float[tarX.length];
    arrayCopy(tarX, tx);    
    float[] ty = new float[tarY.length];
    arrayCopy(tarY, ty);
    
    myBalls[i] = new Ball(initX, initY, tx, ty, to);
    
    // change order for next ball
    int t = targetOrder[0];
    int n = targetOrder.length;
    for (int j = 1; j < n; j++) {
      targetOrder[j - 1] = targetOrder[j];
    }
    targetOrder[n-1] = t; 
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
  if (' ' == key) {
    for (int i=0; i< myBalls.length; i++) {
      myBalls[i].shuffleTargetOrder();
    }
  } else if ('f' == key) {
    for (int i=0; i< myBalls.length; i++) {
      myBalls[i].changeVelocity(1);
    }
  } else if ('s' == key) {
    for (int i=0; i< myBalls.length; i++) {
      myBalls[i].changeVelocity(-1);
    }
  }  
}