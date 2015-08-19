Ball [] myBall= new Ball[3];
float initX, initY;
int change;
void setup() {
  size(700, 400);
  for (int i=0; i< myBall.length; i++) {
    initX=random(width);
    initY=random(height);
    float TarX[]= ops here how??
      float TarY[]= ops here how??
      change= int(random(1, 4));
    myBall[i]= new Ball(initX, initY, ?, ?, change);
  }
}

void draw() {
  for (int i=0; i< myBall.length; i++) {
    myBall[i].run();
  }
}

void keyReleased() {
  for (int i=0; i< myBall.length; i++) {
    myBall[i].goesintokeyReleased();
  }
}
class Ball {
  float easing= 0.01;
  float []targetX={100, 200, 300, 400, 500};
  float [] targetY={70, 140, 210, 280, 350};
  float x, y; // initial position
  int changeTargetsSequence;
  Ball( float x_, float y_, float[]Tx, float []Ty, changeTargetsSequence_ ) {
    x=x_;
    y=y_;
    float targetX=float[]Tx; //How to write this in the right way?
    float targetY=float []Ty;
    changeTargetsSequence=changeTargetsSequence_;
  }

  void run() {
    for ( int i=0; i<targetX.length; i++) {

      if (i%hangeTargetsSequence==0) {
        x+= (targetX[i]-x)*easing;
        y+=(targetY[i]-y)*easing;
      }
    }
  }

  void goesintokeyReleased() {

    changeTargetsSequence= int(random(1, 4));
  }
}