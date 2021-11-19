class Star //note that this class does NOT extend Floater
{
  private int myX, myY;
  private int whiteness, rChange, gChange, bChange;
  
  public Star(int x, int y) {
    myX = x;
    myY = y;
    whiteness = (int)(Math.random()*200)+25;
    rChange = (int)(Math.random()*20);
    gChange = (int)(Math.random()*20);
    bChange = (int)(Math.random()*20);
  }
  
  public void show() {
    noStroke();
    fill(whiteness + rChange, whiteness + gChange, whiteness + bChange);
    ellipse(myX, myY, 5, 5);
  }
  
  public void shine() {
    if(whiteness < 50)
      whiteness+= Math.random()*30;
    else if(whiteness > 205)
      whiteness-= Math.random()*30;
    else
      whiteness+= (int)(Math.random()*30) - 15;
  }
}
