public Star[] stars = new Star[150];
public Spaceship zoom = new Spaceship();
public boolean wPressed, aPressed, dPressed;
public boolean inHyperSpace;

public void setup() {
  background(0);
  size(800, 800);
  for(int i = 0; i < stars.length; i++) {
    stars[i] = new Star((int)(Math.random()*800), (int)(Math.random()*800));
  }
}

public void draw() {
  background(0);
  for(int i = 0; i < stars.length; i++) {
    stars[i].show();
    stars[i].shine();
  }
  zoom.move();
  zoom.show();
  
  if(wPressed == true) {
      zoom.accelerate(0.1);
      zoom.thruster();
    }
  if(aPressed == true)
      zoom.turn(-5);
  if(dPressed == true)
      zoom.turn(5);
}

public void keyPressed() {
  if(key == 'w' || key == 'W')
    wPressed = true;
  if(key == 'a' || key == 'A')
    aPressed = true;
  if(key == 'd' || key == 'D')
    dPressed = true;
  if(key == ' ') {
    zoom.hyperspace();
    for(int i = 0; i < stars.length; i++)
      stars[i] = new Star((int)(Math.random()*800), (int)(Math.random()*800));
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
