/*
 * Creative Coding
 * Week 3, 01 - using map() to map mouse co-ordinates to background colour 
 * by Indae Hwang
 * Copyright (c) 2014 Monash University
 *
 * This program allows you to change the background color.
 * Press and hold 'left mouse button' to change color.
 * 
 */

  
float gray = 255;
float alpha = 255;
  
void setup() {
  size(500, 500);
  
  ellipseMode(CENTER);
  rectMode(CORNER); //<>//
}


void draw() {
  float r, g, b;
  r = g = b = 0;
  
  float margin = 40;
  float gutter = 10;
  float num = 5;
  float cellSize = (width - (margin * 2) - gutter * (num - 1)) / num;
  for (int i = 0; i < num; i++) {
    for (int j = 0; j < num; j++) {
      
      float x_pos = margin + cellSize / 2 + (cellSize + gutter) * i;
      float y_pos = margin + cellSize / 2 + (cellSize + gutter) * j;
      
      r = map(x_pos, 0, width, 0, 255);
      g = map(y_pos, 0, height, 0, 255);
      b = map(x_pos + y_pos, 0, width+height, 255, 0);
      noStroke();
      fill(r, g, b);
      ellipse(x_pos, y_pos, cellSize, cellSize);
    }
  }
  
  if (mousePressed) {
    gray = map(mouseX, 0, width, 0, 255);
    alpha = map(mouseY, 0, height, 0, 255);
  }
  fill(gray, alpha);
  rect(0, 0, width, height);
}