/*
 * Creative Coding
 * Week 2, 05 - Moving Patterns 1
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 *
 * This sketch builds on the previous sketches, drawing shapes based on the
 * current framerate. The movement of individual shapes combine to create a
 * gestalt field of motion. Use the arrow keys on your keyboard to change the
 * frame rate. 
 * 
 */

float FRICTION_COEFFICIENT = 0.5;

class Vector { //<>//

  float xComponent, yComponent;
  
  Vector(float xComponent, float yComponent) {
    this.xComponent = xComponent;
    this.yComponent = yComponent;
  }
  
  float getY() {
    return this.yComponent;
  }
  
  float getX() {
    return this.xComponent;
  }
}

class Point {
  float xPos, yPos;
  
  Point (float x, float y) {
    xPos = x;
    yPos = y;
  }
  
  float getX() {
    return xPos;
  }
  float getY(){
    return yPos;
  }
}

class Ball {
  float radius;
  Point location;
  Vector velocity;
  
  Ball (Point initialLocation, float initialRadius, Vector initialVelocity) {
    location = initialLocation;
    radius = initialRadius;
    velocity = initialVelocity;
  }
  
  void draw() {
    fill(255,0,0);
    ellipse(location.getX(), location.getY(), radius, radius);
  }
  
  void update() {
    // apply friction
    float x_vel = this.velocity.getX();
    float y_vel = this.velocity.getY();
    this.velocity = new Vector(x_vel * FRICTION_COEFFICIENT, y_vel * FRICTION_COEFFICIENT);
  
    // update postion based on velocity
    float x_pos = this.location.getX() + this.velocity.getX();
    float y_pos = this.location.getY() + this.velocity.getY();
    
    // check for wall collision
    if (x_pos < this.radius) {
      x_pos = this.radius;
      this.velocity = new Vector(this.velocity.getX() * -1, this.velocity.getY());
    }
    if (x_pos > width - this.radius) {
      x_pos = width - this.radius;
      this.velocity = new Vector(this.velocity.getX() * -1, this.velocity.getY());      
    }
    
    if (y_pos < this.radius) {
      y_pos = this.radius;
      this.velocity = new Vector(this.velocity.getX(), this.velocity.getY() * -1);
    }
    if (y_pos > height - this.radius) {
      y_pos = height - this.radius;
      this.velocity = new Vector(this.velocity.getX(), this.velocity.getY() * -1);      
    }
    
    this.location = new Point(x_pos,y_pos);
  
  }
    
  void detectCollisions(RectangleSprite[] rs) {
    for (int i = 0; i < rs.length; i++) {
      RectangleSprite r = rs[i];
      float r_min_x = r.getPosition().getX() - r.getWidth();
      float r_max_x = r.getPosition().getX() + r.getWidth();
      float r_min_y = r.getPosition().getY() - r.getWidth();
      float r_max_y = r.getPosition().getY() + r.getHeight();
      
      if (this.location.getY() > r_max_y + this.radius 
          || this.location.getY() < r_min_y - this.radius) {
            continue;
      }
      
      if (this.location.getX() > r_max_x + this.radius
          || this.location.getX() < r_min_x - this.radius) {
            continue;
      }
      
      // collision detected
      this.accelerate(new Vector(r.getVelocity().getX() * 0.5, r.getVelocity().getY() * 0.5));
    }
  }
  
  void accelerate(Vector a) {
    float x_vel = this.velocity.getX() + a.getX();
    float y_vel = this.velocity.getY() + a.getY();
    this.velocity = new Vector(x_vel, y_vel);
  }

}

class RectangleSprite {
  Point position;
  float rectHeight;
  float rectWidth;
  color rectColor;
  Vector velocity;
  
  RectangleSprite(Point position, float rectWidth, float rectHeight, color rectColor) {
    this.position = position;
    this.rectHeight = rectHeight;
    this.rectWidth = rectWidth;
    this.rectColor = rectColor;
    this.velocity = new Vector(0,0);
  }
  
  void updatePosition(Point newPosition) {
    // update current velocity
    float x_vel = this.position.getX() - newPosition.getX();
    float y_vel = this.position.getY() - newPosition.getY();
    this.velocity = new Vector(x_vel,y_vel);
    // update to new position
    this.position = newPosition;
  }
  
  Vector getVelocity() {
    return this.velocity;
  }
  
  void setColor(color newColor) {
    this.rectColor = newColor;
  }
  
  float getHeight() {
    return this.rectHeight;
  }
  
  float getWidth() {
    return this.rectWidth;
  }
  
  Point getPosition() {
    return this.position;
  }
  
  void draw() {
    noStroke();
    fill(this.rectColor);
    rect(this.position.getX(), this.position.getY(), this.rectWidth, this.rectHeight);    
  }
}

// variable used to store the current frame rate value
int frame_rate_value;

RectangleSprite[] rectSprites;
Ball ball;
float cellsize;
int num = 20;
int margin = 0;
float gutter = 0; //distance between each cell

void setup() {
  size(500, 500);
  
  // frame rate - to be adjusted
  // interactively when user
  // presses left and right
  // arrow keys; the default
  // rate is the one that makes
  // it appear that the shapes
  // are floating on a wavy
  // ocean
  frame_rate_value = 9;
  frameRate(frame_rate_value);
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  // white background
  background(255);
  
  ball = new Ball(new Point(random(0,width), random(0,height)), 20, new Vector(0,0));

  // determine cell size 
  cellsize = ( width - (2 * margin) - gutter * (num - 1) ) / (num - 1);
  
  // setup rectangles
  rectSprites = new RectangleSprite[num*num];  
  for (int i=0; i<num; i++) {
    for (int j=0; j<num; j++) {
      int circleNumber = (i * num) + j;  // counter
      float tx = margin + cellsize * i + gutter * i;
      float ty = margin + cellsize * j + gutter * j;
      rectSprites[circleNumber] = new RectangleSprite(new Point(tx,ty),1.0, cellsize*5, randomColor());
    }
  }
}


void draw() {

  // clear all by redrawing
  // white background
  background(255);
  
  int circleNumber = 0; // counter
  for (int i=0; i<num; i++) {
    for (int j=0; j<num; j++) {
      circleNumber = (i * num) + j; // different way to calculate the circle number from w2_04

      float tx = margin + cellsize * i + gutter * i;
      float ty = margin + cellsize * j + gutter * j;
     
      movingCircle(tx, ty, cellsize, circleNumber);
    }
  }
  
  if (rectSprites.length > 0)
    ball.detectCollisions(rectSprites);
  ball.update();
  ball.draw();
  
} //end of draw 


color randomColor() {
  // choose random color
  float r = random(0,255);
  float g = random(0,255);
  float b = random(0,255);
  color c = color(r,g,b);
  return c;
}

void movingCircle(float x, float y, float size, int circleNum) {

  float finalAngle;
  finalAngle = frameCount + circleNum;

  //the rotating angle for each tempX and tempY postion is affected by frameRate and angle;  
  float tempX = x + (size / 2) * sin(PI / frame_rate_value * finalAngle);
  float tempY = y + (size / 2) * cos(PI / frame_rate_value * finalAngle);
  
  noStroke();
  fill(randomColor());
  // small square
  rect(tempX, tempY, size/5, size/5);
  // long thin rectangle
  rectSprites[circleNum].updatePosition(new Point(tempX,tempY));
  rectSprites[circleNum].draw();
  
  noFill();
  // line between the square
  // and the line thin rectangle
  stroke(randomColor());
  line(x, y, tempX, tempY);
}


/*
 * keyReleased function
 *
 * called automatically by Processing when a keyboard key is released
 */
void keyReleased() {
  
  if (key == 'b' || key == 'B') {
    ball = new Ball(new Point(random(0,width), random(0,height)), 20, new Vector(0,0));
  }
  
  // right arrow -- increase frame_rate_value
  if (keyCode == RIGHT && frame_rate_value < 60) {
    frame_rate_value++;
  }

  // left arrow -- decrease frame_rate_value
  if ( keyCode == LEFT && frame_rate_value > 1) {
    frame_rate_value--;
  }

  // set the frameRate and print current value on the screen
  frameRate(frame_rate_value);
  println("Current frame Rate is: " + frame_rate_value);
}