class Spaceship extends Floater  
{ 
  public Spaceship() {
    myColor = 0;
    myCenterX = 400;
    myCenterY = 400;
    myXspeed = 0; myYspeed = 0; 
    myPointDirection = 0;
    corners = 18;
    xCorners = new int[24]; yCorners = new int[24];
    
    //Ship
    xCorners[0] = 0;
    xCorners[1] = 10;
    xCorners[2] = 20;
    xCorners[3] = 60;
    xCorners[4] = 20;
    xCorners[5]= 35;
    xCorners[6] = 25;
    xCorners[7] = 5;
    xCorners[8] = 5;
    xCorners[9] = -5; 
    xCorners[10] = -5;
    xCorners[11] = -25;
    xCorners[12] = -35;
    xCorners[13] = -20;
    xCorners[14] = -60;
    xCorners[15] = -20;
    xCorners[16] = -10;
    xCorners[17] = 0;
    //Cockpit
    xCorners[18] = 0;
    xCorners[19] = 5;
    xCorners[20] = 5;
    xCorners[21] = -5;
    xCorners[22] = -5;
    xCorners[23] = 0;
    
    //Ship
    yCorners[0] = -30;
    yCorners[1] = -20;
    yCorners[2] = 10;
    yCorners[3] = 30;
    yCorners[4] = 30;
    yCorners[5] = 45;
    yCorners[6] = 55;
    yCorners[7] = 30;
    yCorners[8] = 50;
    yCorners[9] = 50;
    yCorners[10] = 30;
    yCorners[11] = 55;
    yCorners[12] = 45;
    yCorners[13] = 30;
    yCorners[14] = 30;
    yCorners[15] = 10;
    yCorners[16] = -20;
    yCorners[17] = -30;
    //Cockpit
    yCorners[18] = -25;
    yCorners[19] = -20;
    yCorners[20] = -10;
    yCorners[21] = -10;
    yCorners[22] = -20;
    yCorners[23] = -25;
    
    for(int i = 0; i < xCorners.length; i++) {
      xCorners[i] = xCorners[i]/2;
      yCorners[i] = yCorners[i]/2;
    }
  }
  
  public double getmyPointDirection() {return myPointDirection;}
  
  public void thruster() {
    translate((float)myCenterX, (float)myCenterY);
    int red = 255;
    int green = 0;
    rotate((float)(myPointDirection * PI/180));
    float flameEndY = 37.5;
    for(float flameX = 12.5; flameX > -0; flameX -= 0.2) {
      noStroke();
      fill(red, green, 0);
      beginShape();
        curveVertex(flameX, (7*(flameX*flameX))/62.5+25); //y = (7*x^2)/62.5 + 25
        curveVertex(flameX, (7*(flameX*flameX))/62.5+25);
        curveVertex(0, 25);
        curveVertex(-flameX, (7*(flameX*flameX))/65+25);
        curveVertex(0, flameEndY);
        curveVertex(flameX, (7*(flameX*flameX))/62.5+25);
        curveVertex(flameX, (7*(flameX*flameX))/62.5+25);
      endShape(CLOSE);
      red -= 1.4;
      green += 1.4;
      flameEndY-=0.2;
    }
  }
  
  public void hyperspace() {
    myCenterX = Math.random()*750;
    myCenterY = Math.random()*750;
    myPointDirection = Math.random()*360;
    myXspeed = 0;
    myYspeed = 0;
  }
  
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(255);    
    
    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for rotate()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);
    
    //draw the polygon
    rotate(PI/2);
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);
    
    //Draw the cockpit
    fill(230);
    beginShape();
    for (int nI = corners; nI < 23; nI++)
      vertex(xCorners[nI], yCorners[nI]);
    endShape();

    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }
}
