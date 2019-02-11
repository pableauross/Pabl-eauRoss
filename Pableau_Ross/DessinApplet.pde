public class DessinApplet extends PApplet {
  
  String s = "test";
  int epaisseur;
  int x = 50;
  int y = 50;
  int r = 20; // Brush size
  int deplacementX, deplacementY;
  int rouge, vert, bleu;
  color brushColor;
  color backgroundColor = color(255, 204, 0);
  
  DessinApplet() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(640, 420);
    epaisseur = 6;
    deplacementX = 1;
    deplacementY = 1;
    rouge = 100;
    vert = 100;
    bleu = 100;
    
    smooth();
  }

  void draw() {
    fill(brushColor);
    ellipse(x,y,r,r);
    
    //rect(200, 200, 168, 72);
   
    //fill(353, 95, 73, 100);  
    noStroke();

  }

  void control(int inputDirection, color myColor) {
    
    brushColor = myColor;
    
    switch (inputDirection) {
      case 1: x--;
              y++;
              break;
      case 2: y++;
              break;
      case 3: x++;
              y++;
              break;
      case 4: x--;
              break;
      case 6: x++;
              break;
      case 7: x--;
              y--;
              break;
      case 8: y--;
              break;
      case 9: x++;
              y--;
              break;
    }
    
    if (x == width) {
      x--;
    } else if (x == 0) {
      x++;
    }
    
    if (y == 0) {
      y++;
    } else if (y == height) {
      y--;
    }
  }
}
