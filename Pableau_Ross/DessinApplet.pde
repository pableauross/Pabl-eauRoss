public static class DessinApplet extends PApplet {
  
  String s = "test";
  int epaisseur;
  static int x = 50;
  static int y = 50;
  int deplacementX, deplacementY;
  int rouge, vert, bleu;
  
  
  void setting() {
    size(640, 480);
    epaisseur = 6;
    deplacementX = 1;
    deplacementY = 1;
    rouge =100;
    vert = 100;
    bleu = 100;
    smooth();
  }
  
  void draw() {
   background(230);
   float r = random(10, 30);
   //fill(rouge, vert, bleu);
   //ellipse(mouseX, mouseY, r, r);
  
   if (key == CODED) {
      
     stroke(rouge, vert,bleu);
     strokeWeight(epaisseur);
      // line(pmouseX, pmouseY, mouseX, mouseY);
      fill(rouge, vert, bleu);
        ellipse(x,y,r,r);
     }
     
     fill(353, 95, 73, 100);  
    noStroke();
    ellipse(mouseX, mouseY, 20, 20);
   
  }
  
  
  static void control(int inputDirection) {
    
    System.out.println("inputCode: " + inputDirection);

    if (inputDirection == LEFT)   x  = x - 1;
    if (inputDirection == RIGHT)  x = x + 1;
    if (inputDirection == UP)     y = y - 1;
    if (inputDirection == DOWN)   y = y + 1;
    
    //bouger();
    //rebondir();
  }
  void mousePressed() {
    if (mouseButton == LEFT)   fill(0);
    if (mouseButton == RIGHT)  fill(255);
    if (mouseButton == CENTER) fill(128);
  }
  void rebondir() {
   
  // si on est trop à droite ET le déplacement horizontal est positif
   if (x > width && deplacementX > 0) {
     deplacementX = -deplacementX; // inverser la valeur (QUELQUE SOIT cette valeur)
   }
   
   // si on est trop à gauche ET le déplacement horizontal est négatif
   if (x < 0 && deplacementX < 0) {
     deplacementX = abs(deplacementX); // abs() enlève le négative de la valeur
   }
   
   // si on est trop bas ET le déplacement vertical est positif
   if (y > width && deplacementY > 0) { 
     deplacementY = -deplacementY; // rendre négative la valeur
   }
   
   // si on est trop haut ET le déplacement vertical est negatif
   if (y < 0 && deplacementY < 0) {
     deplacementY = abs(deplacementY); // rendre positive cette valeur
   }
  
  }
  void bouger() {
   x = x + deplacementX;
   y = y + deplacementY;  // bouger sur l'axe vertical
  }
}
