/*
 * Creative Coding
 * Week 1, 01 - Draw your name!
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 
 * This program allows you to draw using the mouse.
 * Press 's' to save your drawing as an image to the file "yourName.jpg"
 * Press 'r' to erase your drawing and start with a blank screen
 * 
 */


// setup function -- called once when the program begins
void setup() {

  // set the display window to size 500 x 500 pixels
  size(500, 500);

  // set the background colour to white
  background(255);

  // set the rectangle mode to draw from the centre with a specified radius
  rectMode(RADIUS);
  
  // draw rectangles to cover environment
  int spacer = 6;
  for (int i = 0; i < 500; i = i + spacer) {
    for (int j = 0; j < 500; j = j + spacer) {
      stroke(170); // set the stroke colour to a light grey
      fill(200, 150); // set the fill colour to black with transparency
      rect(i, j, random(6), random(6));
    }
  }
}


// draw function -- called continuously while the program is running
void draw() {

  /* draw a rectangle at your mouse point while you are pressing 
   the left mouse button */

  if (mousePressed) {
    // draw a rectangle with a small random variation in size
    int r = int(random(255));
    int g = int(random(255));
    int b = int(random(255));
    color c = color(r,g,b);
    stroke(c); // set the stroke colour to a light grey
    fill(c); // set the fill to random color
    rect(mouseX, mouseY, random(6), random(6));
  }


  // save your drawing when you press keyboard 's'
  if (keyPressed == true && key=='s') {
    saveFrame("joseph.jpg");
  }

  // erase your drawing when you press keyboard 'r'
  if (keyPressed == true && key == 'r') {
    setup();
  }
}