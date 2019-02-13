import gohai.glvideo.*;
GLCapture cam;

DessinApplet dessin;

Capture cam;
PImage backgroundImg;

// Settings
boolean debugMode = false;

// A variable for the color we are searching for.
color trackColor;

void setup() {
  size(640, 480, P2D);
  frameRate(15);

  colorMode(HSB, 360, 100, 100);

  String[] cameras = GLCapture.list();

  if (cameras.length == 0) {

    println("There are no cameras available for capture.");
    exit();

  } else {

    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new GLCapture(this, cameras[0]);
    cam.start();

    // Background images
    backgroundImg = loadImage("background.png");

    // Start off tracking for red
    trackColor = color(0, 194, 113);
  }

  // Run draw window
  this.dessin = new DessinApplet();
}

void settings() {
  size(640, 480);
}

void captureEvent(Capture cam) {
  cam.read();
}

void drawGreenBackground() { //<>//

  for (int y = 0; y < cam.height; y++) {

    for (int x = 0; x < cam.width; x++) {

      int stelle = x+(y*cam.width);

      float red = red(cam.pixels[stelle]);
      float green = green(cam.pixels[stelle]);
      float blue = blue(cam.pixels[stelle]);

      if (red>270 && green<70 && blue<30) {
        color c = color(backgroundImg.get(x, y));
        // Filters transparent pixels
        if (c != 16777215) {
          cam.set(x, y, c);
        }
      }
    }
  }
}


void draw() {

  // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
  float worldRecord = 200; 

  // XY coordinate of closest color
  int closestRightX = 0;
  int closestRightY = 0;
  int leftPartEnd = cam.width/2;
  int closestLeftX = 0;
  int closestLeftY = 0;

  if (debugMode) {
    line(leftPartEnd, 0, leftPartEnd, cam.height);
  }

  cam.loadPixels();

  // Begin loop to walk through every pixel
  for (int x = 0; x < leftPartEnd; x ++ ) {
    for (int y = 0; y < cam.height; y ++ ) {
      int loc = x + y*cam.width;
      // What is current color
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestRightX = x;
        closestRightY = y;
      }
    }
  }

  for (int x = leftPartEnd; x < cam.width; x ++ ) {
    for (int y = 0; y < cam.height; y ++ ) {
      int loc = x + y*cam.width;
      // What is current color
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestLeftX = x;
        closestLeftY = y;
      }
    }
  }

  color brushColor = color(backgroundImg.get(closestRightX, closestRightY));

  drawGreenBackground();

  image(cam, 0, 0);

  // We only consider the color found if its color distance is less than 10.
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (worldRecord < 200) {

    if (debugMode) {
      // Draw picked color
      fill(brushColor);
      rect(0, 0, 10, 10);

      // Draw a circle at the tracked pixel
      fill(trackColor);
      strokeWeight(2.0);
      stroke(0);
      ellipse(closestRightX, closestRightY, 8, 8);
      ellipse(closestLeftX, closestLeftY, 8, 8);
    }

    int inputDirection = 0;

    int leftArea = leftPartEnd + leftPartEnd / 3;
    int middleArea = leftPartEnd + (leftPartEnd/3) * 2;

    if (closestLeftX == 0 && closestLeftY == 0) {
      if (debugMode) {
        println("No fish found on the right side");
      }
    } else {
      if (closestLeftY < cam.height/3) {
        if (closestLeftX < leftArea) {
          inputDirection = 7;
        } else if (closestLeftX < middleArea) {
          inputDirection = 8;
        } else {
          inputDirection = 9;
        }
      } else if (closestLeftY < (cam.height/3)*2) {
        if (closestLeftX < leftArea) {
          inputDirection = 4;
        } else if (closestLeftX < middleArea) {
          inputDirection = 5;
        } else {
          inputDirection = 6;
        }
      } else {
        if (closestLeftX < leftArea) {
          inputDirection = 1;
        } else if (closestLeftX < middleArea) {
          inputDirection = 2;
        } else {
          inputDirection = 3;
        }
      }
    }

    dessin.control(inputDirection, brushColor);
  }
}

void mousePressed() {
  int stelle = mouseX+(mouseY*width);

  float red = red(cam.pixels[stelle]);
  float green = green(cam.pixels[stelle]);
  float blue = blue(cam.pixels[stelle]);

  println("R: " + red +" "+ "G: " + green +" "+ "B: " + blue);
}
