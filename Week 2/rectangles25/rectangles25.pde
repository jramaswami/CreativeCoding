/*
 * Sketch to reproduce Vera Molnar's 25 Squares (1991)
 *
 * Assignment for Week 2 of Creative Coding MOOC
 *
 * Author: Joseph Ramaswmai
 */
 
void setup() {
  size(530, 530);
  rectMode(CORNER);
  drawRectangles();
  frameRate(0.5);
  //noLoop();
}

void draw() {
  drawRectangles();

  // save your drawing when you press keyboard 's'
  if (keyPressed == true && key=='s') {
    saveFrame("rectangles25.jpg");
    println("Saved.");
  }  
}

void drawRectangles() { //<>//
  float gap = 5.0;
  float rectSize = 100.00;

  // set gray background
  background(180);
  
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      float x_pos = (float)(gap + ((rectSize + gap) * i));
      float y_pos = (float)(gap + ((rectSize + gap) * j));
      
      // random color variation
      float p = random(0,1);
      color rectColor = color(0);
      if (p < 0.2) {
        rectColor = color(#7C0E0E);
      } else {
        rectColor = color(#B91515);
      }

      // random x offset
      float max_offset = 7;
      float min_offset = 3;
      float x_offset = 0;
      p = random(0,1);
      if (p < 0.2) {
        x_offset = random(min_offset,max_offset);
        if (p < 0.1) {
          x_offset = -1 * x_offset;
        }
      }
      x_pos = x_pos + x_offset;
      
      // random y offset
      float y_offset = 0;
      p = random(0,1);
      if (p < 0.2) {
        y_offset = random(min_offset,max_offset);;
        if (p < 0.1) {
          y_offset = -1 * y_offset;
        }
      }
      y_pos = y_pos + y_offset;
      
      fill(rectColor);
      rect(x_pos, y_pos, rectSize, rectSize);      
    }
  }  
}