void setup() {
  size(600,600);
  background(180);
  noStroke();
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {
  noStroke();
  
  int num = 5;
  int margin = 40;
  float gutter = 10;
  
  float cellSize = (width - (margin * 2) - gutter * (num - 1)) / num;
  
  int squareNumber = 0;
  
  for (int i = 0; i < num; i++) {
    for (int j = 0; j < num; j++) {
      squareNumber++;
      
      float xPos = margin + (cellSize / 2) + (cellSize + gutter) * i;
      float yPos = margin + (cellSize / 2) + (cellSize + gutter) * j;
      
      float angle = squareNumber * TWO_PI * millis() / 60000.0;
      drawSquareClock(xPos, yPos, cellSize, angle);
    }
  }
}

void drawSquareClock(float x, float y, float size, float angle) {
  // draw gray rectangle
  stroke(0);
  strokeWeight(1);
  fill(140, 180);
  rect(x, y, size, size);
  
  // draw the moving line
  // for the "square clock"
  stroke(255, 0, 0);
  float xEndpoint = x + cos(angle) * size/2;
  float yEndpoint = y + sin(angle) * size/2;
  line(x, y, xEndpoint, yEndpoint);
}