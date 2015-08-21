/*
 * Creative Coding
 * Week 3, 04 - spinning top: curved motion with sin() and cos()
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 *
 * This sketch is the first cut at translating the motion of a spinning top
 * to trace a drawing path. This sketch traces a path using sin() and cos()
 *
 */

float rad;       // radius for the moving hand

// controls which kind
// of recursive drawing is done
int STARBURST = 1;
int SWIRL = 0;
int mode = SWIRL;

int NUM_HANDS = 10;
float[] z;
float[] w;
int SWIRL_SIZE = 50;
float STROKE_WEIGHT=5;

int NUM_TOPS = 3;
Top[] tops;

void setup() {
  size(1000, 600);

  frameRate(100);
  
  tops = new Top[NUM_TOPS];
  for (int i = 0; i < NUM_TOPS; i++) {
    tops[i] = new Top(new Point(width/2, height/2));
  }
  
  background(0);
  
  z = new float[NUM_HANDS+1];
  w = new float[NUM_HANDS+1];
  
  for (int i = 0; i <= NUM_HANDS; i++) {
    z[i] = random(i) / 10;
    w[i] = random(i);
  } 
}

color chooseColorByPosition(Point p) {
  float r = map(p.getX(), 0, width, 0, 255);
  float g = map(p.getY(), 0, height, 0, 255);
  float b = map(p.getX() + p.getY(), 0, width + height, 0, 255);
  return color(r, g, b); 
}

void drawRecursiveSwirl(Point anchor, int level) {
  
  // stop drawing
  if (0 == level) {
    return;
  }
  
  // draw swirl
  float x = anchor.getX();
  float y = anchor.getY();
  
  rad = radians(frameCount);
  
  float bx = x + SWIRL_SIZE * sin(rad);
  float by = y + SWIRL_SIZE * cos(rad);

  float radius, handX, handY;
  if (STARBURST == mode) {
    radius = SWIRL_SIZE * sin(rad*random(level)/10);
    handX = bx + radius * sin(rad*random(level));
    handY = by + radius * cos(rad*random(level));
  } else {
    radius = SWIRL_SIZE * sin(rad*z[level]);
    handX = bx + radius * sin(rad*w[level]);
    handY = by + radius * cos(rad*w[level]);
  }
   
  color c = chooseColorByPosition(new Point(handX, handY));
  
  strokeWeight(STROKE_WEIGHT);
  stroke(c, 50);
  fill(c);
  line(bx, by, handX, handY);
  ellipse(handX, handY, 2, 2);
   
  // level down and then draw again
  level = level - 1;
  drawRecursiveSwirl(new Point(handX, handY), level);
}
  
void draw() {
  // blend the old frames into the background
  blendMode(BLEND);
  fill(0, 5);
  rect(0, 0, width, height);
  
  for (int i = 0; i < NUM_TOPS; i++) {
    tops[i].update();
    // tops[i].draw();
  
    // draw HANDS swirls recursively
    drawRecursiveSwirl(tops[i].getPosition(), NUM_HANDS);
  }
  
}

void mouseClicked() {
  if (STARBURST == mode) {
    mode = SWIRL;
  } else {
    mode = STARBURST;
  }
}
    