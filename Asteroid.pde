class Asteroid extends Floater {
  private double rotSpeed;
  public Asteroid() {
    myColor = (int)(Math.random()*50) + 75;
    myXspeed = Math.random()*6; myYspeed = Math.random()*6; 
    myPointDirection = Math.random()*360;
    rotSpeed = ((Math.random()*6)-3) + (myXspeed + myYspeed)/2;
    corners = 8;
    xCorners = new int[8]; yCorners = new int[8];
    int quadrant = (int)(Math.random()*4)+1;
    if(quadrant == 1) { //Above the canvas 
      myCenterX = Math.random()*width;
      myCenterY = height - 30;
    }
    if(quadrant == 2) { //Right of canvas
      myCenterX = width + 30;
      myCenterY = Math.random()*height;
      myXspeed = -myXspeed;
    }
    if(quadrant == 3) { //Below canvas
      myCenterX = Math.random()*width;
      myCenterY = height + 30;
      myYspeed = -myYspeed;
    }
    if(quadrant == 4) { //Left of canvas
      myCenterX = width - 30;
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
}
