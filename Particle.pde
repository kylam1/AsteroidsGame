class Particle {
  private double myX, myY, mySize, myAngle, mySpeed;
  private color myColor;
  public Particle(double x, double y, color astColor) {
    myX = x;
    myY = y;
    mySize = 7;
    myAngle = Math.random()*2*PI; 
    mySpeed = Math.random()*3+1;
    myColor = astColor;
  }
  
  public double getSize() {return mySize; }
  
  public void move() {
    myX+=Math.cos(myAngle)*mySpeed;
    myY+=Math.sin(myAngle)*mySpeed;
    mySize-=0.2;
    mySpeed-=0.1;
  }
  
  public void show() {
    noStroke();
    fill(myColor);
    ellipse((float)(myX + Math.cos(myAngle)*7), (float)(myY  + Math.sin(myAngle)*7), (float)mySize, (float)mySize);
  }
}
