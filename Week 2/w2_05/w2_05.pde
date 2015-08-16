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

// variable used to store the current frame rate value
int frame_rate_value;

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
  
  // white background
  background(255);
}


void draw() {

  // clear all by redrawing
  // white background
  background(255);

  // determine cell size 
  int num = 20;
  int margin = 0;
  float gutter = 0; //distance between each cell
  float cellsize = ( width - (2 * margin) - gutter * (num - 1) ) / (num - 1);

  int circleNumber = 0; // counter
  for (int i=0; i<num; i++) {
    for (int j=0; j<num; j++) {
      circleNumber = (i * num) + j; // different way to calculate the circle number from w2_04

      float tx = margin + cellsize * i + gutter * i;
      float ty = margin + cellsize * j + gutter * j;

      movingCircle(tx, ty, cellsize, circleNumber);
    }
  }
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
  // rectangle that is actually
  // a line
  rect(tempX, tempY, 1, size*5);
  stroke(randomColor());
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