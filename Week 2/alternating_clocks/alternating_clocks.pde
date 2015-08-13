void setup() {
  size(600,600);
  background(180);
  noStroke();
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {
  background(180);
  noStroke();
  
  float margin = 40;
  float gutter = 10;
  int numCells = 5; 
  float cellSize = (width - (2 * margin) - ((numCells - 1) * gutter)) / numCells;
  
  int cellNumber = 0;
  for (int i = 0; i < numCells; i++) {
    for (int j = 0; j < numCells; j++) {
      cellNumber++;
      
      float xPos = margin + (cellSize / 2) + (cellSize + gutter) * j;
      float yPos = margin + (cellSize / 2) + (cellSize + gutter) * i;
      
      float angle = cellNumber * TWO_PI * millis() / 60000.0;
      drawCell(xPos, yPos, cellSize, angle, cellNumber);
    }
  }
}

void drawCell(float x, float y, float size, float angle, int cellNumber) {
  if (cellNumber % 2 == 0) {
    drawSquareClock(x, y, size, angle);
  } else {
    drawRoundClock(x, y, size, angle);
  }
}
      
void drawSquareClock(float x, float y, float size, float angle) {
  stroke(0);
  strokeWeight(1);
  fill(140,180);
  rect(x, y, size, size);
  
  float xEndPoint = x + cos(angle) * size/2;
  float yEndPoint = y + sin(angle) * size/2;
  stroke(0,0,255);
  line(x, y, xEndPoint, yEndPoint);
}

void drawRoundClock(float x, float y, float size, float angle) {
  stroke(0);
  strokeWeight(1);
  fill(140,180);
  ellipse(x, y, size, size);
  
  float xEndPoint = x + cos(angle) * size/2;
  float yEndPoint = y + sin(angle) * size/2;
  stroke(0,0,255);
  line(x, y, xEndPoint, yEndPoint);
}