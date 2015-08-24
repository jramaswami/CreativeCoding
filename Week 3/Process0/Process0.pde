ElementManager em;
int elementCount = 5;
float BALL_RADIUS = 50;
float MAX_VELOCITY = 3;

void setup() {
  size(600, 600);
  em = new ElementManager();
  
  for (int i = 0; i < elementCount; i++) {
    float x = random(width);
    float y = random(height);
    float x_vel = random(MAX_VELOCITY);
    float y_vel = random(MAX_VELOCITY);
    em.addElement(new Element0(new PVector(x, y), new PVector(x_vel, y_vel), BALL_RADIUS, i));
  }
}

void draw() {
  background(180);
  em.update();
  em.draw();
}

