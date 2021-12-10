public Star[] stars = new Star[300];
public Spaceship[] fleet = new Spaceship[5];
public ArrayList <Asteroid> wreckers = new ArrayList <Asteroid> ();
public boolean wPressed, aPressed, dPressed;
public boolean inHyperSpace;
public ArrayList <Particle> debris = new ArrayList <Particle> ();
public int shipsRemaining;

public void setup() {
  size(1200, 1000);
  for(int i = 0; i < stars.length; i++) {
    stars[i] = new Star((int)(Math.random()*width), (int)(Math.random()*height));
  }
  for(int i = 0; i < fleet.length; i++) {
    fleet[i] = new Spaceship();
  }
  fleet[1].moveOver(-50, 50);
  fleet[2].moveOver(-50, -50);
  fleet[3].moveOver(-100, 100);
  fleet[4].moveOver(-100, -100);
  shipsRemaining = fleet.length;
  
  for(int i = 1; i <= 18; i++) {
    wreckers.add(new Asteroid());
  }
  debris.add(0, null);
}

public void draw() {
  background(0);
  for(int i = 0; i < stars.length; i++) {
    stars[i].show();
    stars[i].shine();
  }
  
  for(int i = 0; i < wreckers.size(); i++) {
    if(wreckers.get(i).getExploding() == false)
      wreckers.get(i).move();
    wreckers.get(i).show();
  }
  
  for(int i = 0; i < fleet.length; i++) {
    if(fleet[i] != null) {
      fleet[i].move();
      fleet[i].show();
    }
  }  
      
  if(wPressed == true) {
    for(int i = 0; i < fleet.length; i++) {
      if(fleet[i] != null) {
        fleet[i].accelerate(0.1);
        fleet[i].thruster();
      }
    }
  }
  if(aPressed == true) {
    for(int i = 0; i < fleet.length; i++) 
     if(fleet[i] != null) 
      fleet[i].turn(-5);
  }
  if(dPressed == true) {
    for(int i = 0; i < fleet.length; i++) 
     if(fleet[i] != null) 
      fleet[i].turn(5);
  }
  
  for(int i = 0; i < fleet.length; i++) {
    for(int j = 0; j < wreckers.size(); j++) {
      if( fleet[i] != null && dist(fleet[i].getCenterX(), fleet[i].getCenterY(), wreckers.get(j).getCenterX(), wreckers.get(j).getCenterY()) < fleet[i].getRadius() + wreckers.get(j).getRadius() + 1.5) {
        double tempCenterX = wreckers.get(j).getCenterX(); 
        double tempCenterY = wreckers.get(j).getCenterY();
        int tempColor = wreckers.get(j).getColor();
        wreckers.set(j, new Asteroid());
        for(int k = 1; k < 25; k++) {
          debris.set(0, new Particle(tempCenterX, tempCenterY, tempColor));
          debris.add(new Particle(tempCenterX, tempCenterY, tempColor));
        }
        double shipCenterX = fleet[i].getCenterX();
        double shipCenterY = fleet[i].getCenterY();
        color explodeColor = color(200, 0, 0);
        for(int n = 25; n < 50; n++) {
          debris.add(n, new Particle(shipCenterX, shipCenterY, explodeColor));
        }
        fleet[i] = null;
        shipsRemaining -= 1;
      }
    }
  }
  if(debris.get(0) != null) {
    if(debris.get(0).getSize() > 3) {
      for(int k = 0; k < debris.size(); k++) {
        debris.get(k).move();
        debris.get(k).show();
      }
    }  
    else {
      for(int k = 1; k < 50; k++)
        debris.remove(1);
    }
  }
  if(debris.size() == 1) {
    debris.set(0, null);
  }
  
////////////////////////////////////////////////////////////////////
  if(shipsRemaining == 0) {
    noLoop();
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER);
    textSize(40);
    text("Your fleet was destroyed!", width/2, height/4);
    float timer = (float)millis()/1000;
    String theEndTime = "Your fleet survived for " + timer + " seconds :D";
    text(theEndTime, width/2, 2*height/5);
  }
}

public void keyPressed() {
  if(key == 'w' || key == 'W')
    wPressed = true;
  if(key == 'a' || key == 'A') 
    aPressed = true;
  if(key == 'd' || key == 'D')
    dPressed = true;
  if(key == ' ') {
    double newX = Math.random()*width-100;
    double newY = Math.random()*height-100;
    int newPoint = (int)(Math.random()*360);
    for(int i = 0; i < fleet.length; i++) {
      fleet[i].hyperspace(newX, newY, newPoint);
    }
    fleet[1].moveOver(-50, 50);
    fleet[2].moveOver(-50, -50);
    fleet[3].moveOver(-100, 100);
    fleet[4].moveOver(-100, -100);
    for(int i = 0; i < stars.length; i++)
      stars[i] = new Star((int)(Math.random()*width), (int)(Math.random()*height));
    while(wreckers.size() != 0)
      wreckers.remove(0);
    for(int i = 1; i <= 15; i++)
      wreckers.add(new Asteroid());
  }
}

public void keyReleased() {
  if(key == 'w' || key == 'W')
    wPressed = false;
  if(key == 'a' || key == 'A')
    aPressed = false;
  if(key == 'd' || key == 'D')
    dPressed = false;
}
