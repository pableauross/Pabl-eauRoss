public class DessinApplet extends PApplet {
  
  String s = "test";
  int x = 100;
  int y = 100;
  int r = 30; // Brush size
  int speed = 2;
  color brushColor;
  color backgroundColor = color(255, 204, 0);
  
  DessinApplet() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(640, 420);
    smooth();
  }

  void draw() {
    fill(brushColor);
    ellipse(x,y,r,r);
    noStroke();
  }

  void control(int inputDirection, color myColor) {
    
    brushColor = myColor;
    
    switch (inputDirection) {
      case 1: x = x - speed;
              y = y + speed;
              break;
      case 2: y = y + speed;
              break;
      case 3: x = x + speed;
              y = y + speed;
              break;
      case 4: x = x - speed;
              break;
      case 6: x = x + speed;
              break;
      case 7: x = x - speed;
              y = x - speed;
              break;
      case 8: y = y - speed;
              break;
      case 9: x = x + speed;
              y = y - speed;
              break;
    }
    
    if (x > width) {
      x = width;
    } else if (x < 0) {
      x = 0;
    }
    
    if (y < 0) {
      y = 0;
    } else if (y > height) {
      y = height;
    }
  }
}
