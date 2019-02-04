import processing.video.*;

Capture cam;
DessinApplet dessin;

// Settings
boolean debugMode = true;

// A variable for the color we are searching for.
color trackColor;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  
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
    cam = new Capture(this, cameras[3]);
    cam.start(); 
    // Start off tracking for red
    trackColor = color(255, 0, 0);
    
  }
  
  String[] args = {"Dessin"};
  DessinApplet dessin = new DessinApplet();
  PApplet.runSketch(args, dessin);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
    
  // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
  float worldRecord = 200; 

  // XY coordinate of closest color
  int closestRightX = 0;
  int closestRightY = 0;
  int leftPartEnd = cam.width/2;
  int closestLeftX = 0;
  int closestLeftY = 0;

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
  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (worldRecord < 200) {
    // Draw a circle at the tracked pixel
    fill(trackColor);
    strokeWeight(4.0);
    stroke(0);
    if (debugMode) {
      ellipse(closestRightX, closestRightY, 16, 16);
      ellipse(closestLeftX, closestLeftY, 16, 16);
    }    
    
    System.out.println("Position Droite");
    System.out.println("X: "+closestLeftX + "Y: "+closestLeftY);
    
    int inputDirection = 0;
    
    if (closestLeftY < cam.height/3)
    {
      if (closestLeftX < leftPartEnd/3 )
      {
        inputDirection = 7;
      }
      
      else if (closestLeftX < (leftPartEnd/3) * 2 )
      {
        inputDirection = 8;
      }      
      else
      {
        inputDirection = 9;
      }
    }  
    
    if (closestLeftY < (cam.height/3)*2)
    {
      if (closestLeftX < leftPartEnd/3 )
      {
        inputDirection = 4;
      }
      
      else if (closestLeftX < (leftPartEnd/3) * 2 )
      {
        inputDirection = 5;
      }      
      else
      {
        inputDirection = 6;
      }
    }
    
    else
    {
      if (closestLeftX < leftPartEnd/3 )
      {
        inputDirection = 1;
      }
      
      else if (closestLeftX < (leftPartEnd/3) * 2 )
      {
        inputDirection = 2;
      }      
      else
      {
        inputDirection = 3;
      }
    }
    
    DessinApplet.control(inputDirection);
    
    System.out.println("Input Direction: " + inputDirection);
  }
}
