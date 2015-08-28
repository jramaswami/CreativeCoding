PImage[] img;
color[] pixelColors;
int scanLine;
int circleRadius;
int currentImage;
ArrayList<PVector> pixelList;
int pixelsPerFrame = 100;

void setup() {
  size(700, 500);
  circleRadius = 5;
  
  File imgDir = new File(dataPath(""));
  String[] imageNames = imgDir.list();
  img = new PImage[imageNames.length];
  for (int i = 0; i < imageNames.length; i++) {
    img[i] = loadImage(imageNames[i]);
    img[i].resize(width, height);
  }
  
  currentImage = 0;
  initPixelList();
}

void initPixelList() {
  pixelList = new ArrayList<PVector>();
  for (int x = circleRadius; x < width; x += circleRadius) {
    for (int y = circleRadius; y < height; y += circleRadius) {
      pixelList.add(new PVector(x, y));
    }
  }
}

void draw() {
  for (int i = 0; i < pixelsPerFrame; i++) {
    if (pixelList.size() == 0) {
      initPixelList();
      currentImage++;
      if (currentImage >= img.length) {
        currentImage = 0;
      }
    }
    int index = int(random(pixelList.size()));
    PVector p = pixelList.get(index);
    pixelList.remove(index);
    drawPixel(int(p.x), int(p.y));
  }
}

int canvasXtoImgX(int canvasX) {
  return canvasX % img[currentImage].width;
}

int canvasYtoImgY(int canvasY) {
  return canvasY % img[currentImage].height;
}

void drawPixel(int x, int y) {
  int imgX = canvasXtoImgX(x);
  int imgY = canvasYtoImgY(y);

  int xx = min(5, img[currentImage].width - imgX);
  int yy = min(5, img[currentImage].height - imgY);

  noStroke(); 
  fill(img[currentImage].get(imgX + int(random(-xx, xx)), imgY + int(random(-yy, yy))));
  ellipse(x, y, circleRadius, circleRadius);
}

void drawImage() {
  int imgX, imgY;
  imgX = imgY = 0;

  for (int x = circleRadius; x < width; x += circleRadius) {
    //imgX = canvasXtoImgX(x);

    for (int y = circleRadius; y < height; y += circleRadius) {
      /*
      imgY = canvasYtoImgY(y);
       
       noStroke();
       int xx = min(5, img[currentImage].width - imgX);
       int yy = min(5, img[currentImage].height - imgY); 
       fill(img[currentImage].get(imgX + int(random(-xx, xx)), imgY + int(random(-yy, yy))));
       ellipse(x, y, circleRadius, circleRadius);
       */
      drawPixel(x, y);
    }
  }
}  

