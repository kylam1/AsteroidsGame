public Star[] stars = new Star[300];
public Spaceship[] fleet = new Spaceship[5];
//public Spaceship zoom = new Spaceship();
public ArrayList <Asteroid> wreckers = new ArrayList <Asteroid> ();
//public Asteroid rock = new Asteroid();
public boolean wPressed, aPressed, dPressed;
public boolean inHyperSpace;

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
  
  for(int i = 1; i <= 18; i++) {
    wreckers.add(new Asteroid());
  }
}

public void draw() {
  background(0);
  for(int i = 0; i < stars.length; i++) {
    stars[i].show();
    stars[i].shine();
  }
  
  for(int i = 0; i < wreckers.size(); i++) {
    wreckers.get(i).move();
    wreckers.get(i).show();
  }
  
  for(int i = 0; i < fleet.length; i++) {
    fleet[i].move();
    fleet[i].show();
  }  
      
  if(wPressed == true) {
    for(int i = 0; i < fleet.length; i++) {
      fleet[i].accelerate(0.1);
      fleet[i].thruster();
    }
  }
  if(aPressed == true) {
    for(int i = 0; i < fleet.length; i++) 
      fleet[i].turn(-5);
  }
  if(dPressed == true) {
    for(int i = 0; i < fleet.length; i++) 
      fleet[i].turn(5);
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
