class Particle {
  double myX, myY, myAngle, mySpeed;
  color myColor;
  float mySize;
  float radius;
  int centerX = width/2;
  int centerY = (height/2) -150;
  Particle() {
    mySize = 2;
    myX = centerX;
    myY = centerY;
    mySpeed = (Math.random()*9.8)+0.2;
    myAngle = ((Math.random()*2*Math.PI));
    myColor = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
  }
  void move() {
    myX+=cos((float)(myAngle))*mySpeed;
    myY += sin((float)(myAngle))*mySpeed;
    radius = (int)sqrt((sq((float)myX-centerX))+(sq((float)myY-centerY)));//distance formula
    mySize = radius/15+2;

  }
  void show() {
    noStroke();
    fill(myColor);
    ellipse((float)(myX), (float)(myY), mySize, mySize);
  }//end show
  boolean offScreen(int i) {
    if ((patty[i].myX>width)||(patty[i].myX<0)||(patty[i].myY>height)||(patty[i].myY<0)) {
      return true;
    }
    return false;
  }//end offScreen

  void restart(int i) {
    if (patty[i].offScreen(i)) {
      patty[i].mySize = 2;
      patty[i].myX = centerX;
      patty[i].myY = centerY;
      patty[i].mySpeed =  (Math.random()*8)+2;
      patty[i].myAngle = ((Math.random()*2*Math.PI));
    }
  }
}//end particle class

class Spaceship extends Particle {
  float myScale =1;
  Spaceship() {
    myX = width/2;
    myY = height/2;
    mySpeed = 3;
  }//end constructor
  void show() {
    myScale = radius/300+0.5;
    fill(200);
    ellipse((float)myX, (float)myY, 70*myScale, 30*myScale);
    fill(110);
    ellipse((float)myX, (float)myY-15*myScale, 40*myScale, 30*myScale);
  }
  void move() {//THIS PART ISNT WORKING NOW THAT I ADDED THE RADIUS DEFINTION
    radius = (int)sqrt((sq((float)myX-centerX))+(sq((float)myY-centerY)));
    if (keyPressed) {
      if (key == 'w' && myY>centerY)
        myY-=5;
      if (key == 's' && myY<height-50)
        myY+=5;
      if (key=='a' && myX>80)
        myX-=5;
      if (key=='d' && myX<width-80)
        myX+=5;
    }
  }
  void restart(int i) {
  }
}//end spaceship class



Particle [] patty = new Particle[100];
void setup() {
  size(800,800);
  frameRate(20);
  patty[patty.length-1] = new Spaceship();
  for (int i = 0; i<patty.length-1; i++) {
    patty[i]= new Particle();
  }
}

void draw() {
  background(20, 10, 70);
  for (int i = 0; i<patty.length; i++) {
    patty[i].show();
    patty[i].move();
    patty[i].restart(i);
  }
}

