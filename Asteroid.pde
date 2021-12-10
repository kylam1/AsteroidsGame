class Asteroid extends Floater {
  private double rotSpeed;
  private boolean exploding, dead;
  public Asteroid() {
    exploding = false;
    dead = false;
    myColor = (int)(Math.random()*50) + 75;
    myXspeed = Math.random()*2; myYspeed = Math.random()*2; 
    myPointDirection = Math.random()*360;
    rotSpeed = ((Math.random()*6)-3) + (myXspeed + myYspeed)/2;
    corners = 8;
    xCorners = new int[8]; yCorners = new int[8];
    int quadrant = (int)(Math.random()*4)+1;
    if(quadrant == 1) { //Above the canvas 
      myCenterX = Math.random()*width;
      myCenterY = height;
    }
    if(quadrant == 2) { //Right of canvas
      myCenterX = width;
      myCenterY = Math.random()*height;
      myXspeed = -myXspeed;
    }
    if(quadrant == 3) { //Below canvas
      myCenterX = Math.random()*width;
      myCenterY = height;
      myYspeed = -myYspeed;
    }
    if(quadrant == 4) { //Left of canvas
      myCenterX = width;
      myCenterY = Math.random()*height;
    }
    
    //Shape from top right corner
    xCorners[0] = (int)(Math.random()*10) + 5;
    xCorners[1] = (int)(Math.random()*10) + 7;
    xCorners[2] = (int)(Math.random()*10) + 5;
    xCorners[3] = (int)(Math.random()*3) - 1;
    xCorners[4] = (int)(Math.random()*10) - 15;
    xCorners[5] = (int)(Math.random()*10) - 17;
    xCorners[6] = (int)(Math.random()*10) - 15;
    xCorners[7] = (int)(Math.random()*3) - 1;
    
    yCorners[0] = (int)(Math.random()*10) - 15;
    yCorners[1] = (int)(Math.random()*3) - 1;
    yCorners[2] = (int)(Math.random()*10) + 5;
    yCorners[3] = (int)(Math.random()*10) + 7;
    yCorners[4] = (int)(Math.random()*10) + 5;
    yCorners[5] = (int)(Math.random()*3) - 1;
    yCorners[6] = (int)(Math.random()*10) - 15;
    yCorners[7] = (int)(Math.random()*10) - 17;
  }
  public void move() {
    turn(rotSpeed);
    super.move();
  }
  
  public int getColor() {return myColor; }
  public float getCenterX() {return (float)myCenterX; }
  public float getCenterY() {return (float)myCenterY; }
  public boolean getExploding() {return exploding;}
  public boolean dead() {return dead;}
  
  public float getRadius() {
    float sum = 0;
    for(int i = 0; i < corners; i++)
      sum += dist((float)myCenterX, (float)myCenterY, (float)(xCorners[i] + myCenterX), (float)(yCorners[i] + myCenterY));
    return sum/corners;
  }
}
