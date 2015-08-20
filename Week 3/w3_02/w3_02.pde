/*
 * Creative Coding
 * Week 3, 02 - array with sin()
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 *
 * This program demonstrates the use of arrays.
 * It creates three arrays that store the y-position, speed and phase of some oscillating circles.
 * You can change the number of circles by changing the value of num in setup()
 * You can change the background colour by holding the left mouse button and dragging.
 * 
 */

class Point {
  float x, y;
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  float getX() {
    return this.x;
  }
  
  float getY() {
    return this.y;
  }
  
  void setX(float x) {
    this.x = x;
  }
  
  void setY(float y) {
    this.y = y;
  }
}
    
class Ball {
  Point position;
  color ballColor;
  float radius;
  float speed;
  float phase;
  boolean stopped;
  
  Ball(Point p, float radius, color c) {
    this.position = p;
    this.radius = radius;
    this.ballColor = c;
    this.speed = random(10);
    this.phase = random(TWO_PI);
    this.stopped = false;
  }
  
  Point getPosition() {
    return this.position;
  }
  
  float getRadius() {
    return this.radius;
  }
  
  void stop() {
    this.stopped = true;
    this.ballColor = color(0,0,0);
  }
  
  void start() {
    this.stopped = false;
    this.speed = random(10);
    this.phase = random(TWO_PI);
    this.ballColor = color(255,255,255);
  }
  
  boolean isStopped() {
    return this.stopped;
  }
  
  void update() {
    if (!this.isStopped()) {
      this.position.setX(width/2 + sin(radians(frameCount * this.speed) + this.phase)* 200);
    }
  }
  
  void draw() {
    fill(this.ballColor);
    ellipse(this.position.getX(), this.position.getY(), this.radius, this.radius);
  }
}

    
int     num;    // the number of items in the array (# of circles)
Ball[] balls;

float red = 120;
float green = 120;
float blue = 120;

float BALL_RADIUS = 40;

void setup() {
  size(500, 500);

  num = 5;
  balls = new Ball[num];
  
  // calculate the gap in y based on the number of circles
  float gap = height / (num + 1);

  //setup an initial value for each item in the array
  for (int i=0; i<num; i++) {
    float y = gap * (i + 1);
    float x = -100; // this will be off canvas until first draw
    color c = color(255,255,255);
    balls[i] = new Ball(new Point(x, y), BALL_RADIUS, c);
  }
}


void draw() {
  background(red, green, blue);

  for (int i=0; i<num; i++) {
    // calculate the x-position of each ball based on the speed, phase and current frame
    balls[i].update();
    balls[i].draw();
  }
}


// change the background colour if the mouse is dragged
void mouseDragged() {
  red = map(mouseX, 0, width, 0, 255);
  green = map(mouseY, 0, height, 0, 255);
  blue = map(mouseX+mouseY, 0, width+height, 255, 0);
} //<>//

void mousePressed() {
  for (int i = 0; i < balls.length; i++) {
    Ball ball = balls[i];
    if (dist(mouseX, mouseY, ball.getPosition().getX(), ball.getPosition().getY()) < ball.getRadius()) {
        if (ball.isStopped()) {
          ball.start();
        } else {
          ball.stop();
        }
    }
  }
}

    
  