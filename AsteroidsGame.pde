public Star[] stars = new Star[300];
public Spaceship[] fleet = new Spaceship[5];
public int fleetSize = 5;
public int leftCorner, currentCorner; //Corner of rect based on fleetSize in Settings menu
public int r = 255; public int g = 255; public int b = 255;
public int slideRx = 524; public int slideGx = 824; public int slideBx = 1124;
public Spaceship Delta; public Spaceship Omicron;
public ArrayList <Asteroid> wreckers = new ArrayList <Asteroid> ();
public boolean wPressed, aPressed, dPressed;
public boolean inHyperSpace;
public int hyperTime;
public ArrayList <Particle> debris = new ArrayList <Particle> ();
public int shipsRemaining;
public boolean startScreen, leaderboard, settingScreen, resetConfirmation, controlScreen, gameStart, gameEnd;
public boolean setAccelKey, setLeftKey, setRightKey, setShootKey, setHyperKey, controlLock;
public char accelKey = 'w'; public char leftKey = 'a'; public char rightKey = 'd'; public char shootKey = ' '; public char hyperKey = 'r';
public boolean timeTaken;
public float startTime, timer, countdown;
public int score, asteroidsKilled;
public String name;
public int nameLength;
public ArrayList <String> leaderboardName = new ArrayList <String> ();
public ArrayList <Integer> leaderboardScore = new ArrayList <Integer> ();
public ArrayList <Float> leaderboardTime = new ArrayList <Float> ();

public void setup() {
  size(1200, 1000);
  background(0);
  
  for(int i = 0; i < stars.length; i++) {
    stars[i] = new Star((int)(Math.random()*width), (int)(Math.random()*height));
  }
  
  hyperTime = 0;
  for(int i = 0; i < fleetSize; i++) {
    fleet[i] = new Spaceship();
  }
  if(fleetSize%2 == 1) {
    fleet[1].moveOver(-50, 50);
    fleet[2].moveOver(-50, -50);
    fleet[3].moveOver(-100, 100);
    fleet[4].moveOver(-100, -100);
  }
  else {
    fleet[1].moveOver(-100, 0);
    fleet[2].moveOver(-50, 50);
    fleet[3].moveOver(-50, -50);
  }
  shipsRemaining = fleetSize;
  leftCorner = 300+(fleetSize - 1)*200 - 75; //Arithmetic sequence for corner of rect based on fleetSize in Settings menu
  currentCorner = leftCorner;
  
  controlLock = false; //Checks for controls with multiple same keybinds
  
  Delta = new Spaceship();
  Omicron = new Spaceship();
    Delta.moveOver(-450, -400); Omicron.moveOver(450, -400);
    Delta.enlarge(2); Omicron.enlarge(2);
    Delta.setPointDirection(-45); Omicron.setPointDirection(-135);
  
  debris.add(0, null);
  for(int i = 1; i <= 20; i++) {
    wreckers.add(new Asteroid());
  }
  
  timeTaken = false;
  startScreen = true;
  leaderboard = false;
  gameStart = false;
  gameEnd = false;
  score = 0;
  asteroidsKilled = 0;
  name = "";
  nameLength = 0;
}

////////////////////////////////////////////////////////////////////////////

public void draw() {
if(startScreen == true) {
  background(0);
  textAlign(CENTER);
  textSize(50);
  strokeWeight(2);
  text("Welcome to Asteroids!", width/2, 150);  
  
  stroke(r, g, b);
  Delta.show(); Omicron.show();
 
  strokeWeight(2);
  stroke(200);
  if(mouseX >= 450 && mouseX <= 750 && mouseY >= 250 && mouseY <= 350) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  fill(210, 0, 0);
  rect(450, 250, 300, 100);
  fill(255);
  textSize(30);
  text("Start Game", width/2, 305);
  
  strokeWeight(2);
  stroke(200);
  if(mouseX >= 450 && mouseX <= 750 && mouseY >= 450 && mouseY <= 550) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  fill(210, 0, 0);
  rect(450, 450, 300, 100);
  fill(255);
  textSize(30);
  text("Leaderboard", width/2, 505);
  
  strokeWeight(2);
  stroke(200);
  fill(210, 0, 0);
  rect(450, 650, 300, 100);
  fill(255);
  textSize(30);
  text("Coming Soon!", width/2, 705);
  fill(200);
  line(450,650,750,750);

  strokeWeight(2);
  stroke(200);
  if(mouseX >= 75 && mouseX <= 325 && mouseY >= 455 && mouseY <= 542) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  fill(210);
  rect(75, 455, 250, 87);
  fill(255);
  textSize(30);
  text("Settings", 200, 505);
  
  strokeWeight(2);
  stroke(200);
  if(mouseX >= 875 && mouseX <= 1125 && mouseY >= 455 && mouseY <= 542) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  fill(210);
  rect(875, 455, 250, 87);
  fill(255);
  textSize(30);
  text("Controls", 1000, 505);
  
  textSize(25);
  fill(255);
  text("©2021 Chan & Associates Co. Ltd. Inc. LLC", width/2, 850);
  text("Made in Room 334", width/2, 890);
}

/////////////////////////////////////////////////  End of startScreen

if(leaderboard == true) {
  background(0);
  fill(210, 0, 0);
  strokeWeight(2);
  stroke(200);
  if(mouseX >= 50 && mouseX <= 200 && mouseY >= 50 && mouseY <= 100) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(50, 50, 150, 50);
  fill(255);
  textSize(25);
  textAlign(CENTER);
  text("Return", 125, 83);
  
  textAlign(CENTER);
  fill(255);
  textSize(60);
  text("Leaderboard", width/2, 120);
  
  textSize(30);
  fill(200);
  text("Ranking", 125, 200);
  text("Name", 400, 200);
  text("Score", 675, 200);
  text("Time Survived", 1000, 200);
  
  int rankingY = 275; //Ranking
  fill(247,201,56); //Gold
  text("1", 125, rankingY);
  rankingY += 72;
  fill(230); //Silver
  text("2", 125, rankingY);
  rankingY += 72;
  fill(205,127,50); //bronze
  text("3", 125, rankingY);
  rankingY += 72;
  fill(180);
  for(int i = 4; i <= 10; i++) {
    text(i, 125, rankingY);
    rankingY += 72;
  }
  
  if(leaderboardScore.size() == 0) {
    textSize(40);
    fill(255);
    text("No Data Available", 700, 450);
    text("Please Try Again Later.", 700, 550);
    textSize(25);
    text("Please contact Mr. Chan at chanr@sfusd.edu for further assistance", 700, 750);
    return;
  }
  
  int namesY = 275; //Names
  textSize(30);
  fill(247,201,56); //Gold
  if(leaderboardName.size() > 0)
    text(leaderboardName.get(0), 400, namesY);
    namesY += 72;
  fill(230); //Silver
  if(leaderboardName.size() > 1)
    text(leaderboardName.get(1), 400, namesY);
    namesY += 72;
  fill(205,127,50); //bronze
  if(leaderboardName.size() > 2)
    text(leaderboardName.get(2), 400, namesY);
    namesY += 72;
  fill(180);
  for(int i = 3; i < leaderboardName.size() && i < 10; i++) {
    text(leaderboardName.get(i), 400, namesY); 
    namesY += 72;
  }
  
  int scoresY = 275; //Scores
  textSize(30);
  fill(247,201,56); //Gold
  if(leaderboardScore.size() > 0)
    text(leaderboardScore.get(0), 675, scoresY);
    scoresY += 72;
  fill(230); //Silver
  if(leaderboardScore.size() > 1)
    text(leaderboardScore.get(1), 675, scoresY);
    scoresY += 72;
  fill(205,127,50); //bronze
  if(leaderboardScore.size() > 2)
    text(leaderboardScore.get(2), 675, scoresY);
    scoresY += 72;
  fill(180);
  for(int i = 3; i < leaderboardScore.size() && i < 10; i++) {
    text(leaderboardScore.get(i), 675, scoresY); 
    scoresY += 72;
  }
  
  int timeY = 275; //time
  textSize(30);
  fill(247,201,56); //Gold
  if(leaderboardTime.size() > 0)
    text(leaderboardTime.get(0) + " seconds", 1000, timeY);
    timeY += 72;
  fill(230); //Silver
  if(leaderboardTime.size() > 1)
    text(leaderboardTime.get(1) + " seconds", 1000, timeY);
    timeY += 72;
  fill(205,127,50); //bronze
  if(leaderboardTime.size() > 2)
    text(leaderboardTime.get(2) + " seconds", 1000, timeY);
    timeY += 72;
  fill(180);
  for(int i = 3; i < leaderboardTime.size() && i < 10; i++) {
    text(leaderboardTime.get(i) + " seconds", 1000, timeY); 
    timeY += 72;
  }
}

///////////////////////////////////////////////// End of leaderboard

if(settingScreen == true) {
  background(0);
  fill(210, 0, 0);
  strokeWeight(2);
  stroke(200);
  if(mouseX >= 50 && mouseX <= 200 && mouseY >= 50 && mouseY <= 100) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(50, 50, 150, 50);
  fill(255);
  textSize(25);
  textAlign(CENTER);
  text("Return", 125, 83);
  
  textAlign(CENTER);
  fill(255);
  textSize(60);
  text("Settings", width/2, 120);
  
  fill(200);
  textSize(30);
  text("Fleet Size", 100, 250);
  text("1", 300, 250);
  text("2", 500, 250);
  text("3", 700, 250);
  text("4", 900, 250);
  text("5", 1100, 250);
  
  noFill();
  strokeWeight(3);
  stroke(247,201,56);
  leftCorner = 300+(fleetSize-1)*200 - 75; //Arithmetic sequence for corner of rect based on fleetSize in Settings menu
  if(currentCorner > leftCorner)
    currentCorner-=5;
  else if(currentCorner < leftCorner)
    currentCorner+=5;
  rect(currentCorner, 213, 150, 50);
  
  ///////////////////////RED
  if(mousePressed == true && (mouseY>=340 && mouseY<=410)) { //Vertical limiter
    if(slideRx == 269) { //Left of slider
      if(mouseX>=269 && mouseX<=275)
        slideRx = mouseX;
    }
    else if(slideRx == 524) { //Right of slider
      if(mouseX<=524 && mouseX>=518)
        slideRx = mouseX;
    }
    else if((slideRx > 269 && slideRx < 524) && (mouseX > slideRx - 20 && mouseX < slideRx + 20)) { //Middle of slider
      slideRx = mouseX;
    }
  }
  if(slideRx < 269) //Top backup reset
    slideRx = 269;
  if(slideRx > 524)  //Bottom backup reset
    slideRx = 524;
  r = slideRx-269;
  
  fill(200);
  text("Ship Color", 100, 360);
  noStroke();
  fill(r, 0, 0);
  text("Red = " + r, 400, 325);
  for(int slideR = 0; slideR <= 255; slideR++) {
    fill(slideR, g, b);
    rect(272+slideR, 350, 1, 40);
  }
  noFill();
  stroke(r, 0, 0);
  strokeWeight(1);
  rect(slideRx, 350, 6, 40);
  stroke(255);
  line(slideRx+3-10, 400, slideRx+3, 390);
  line(slideRx+3+10, 400, slideRx+3, 390);
  
  ////////////////////////GREEN
  if(mousePressed == true && (mouseY>=340 && mouseY<=410)) { //Vertical limiter
    if(slideGx == 569) { //Left of slider
      if(mouseX>=569 && mouseX<=575)
        slideGx = mouseX;
    }
    else if(slideGx == 824) { //Right of slider
      if(mouseX<=824 && mouseX>=818)
        slideGx = mouseX;
    }
    else if((slideGx > 569 && slideGx < 824) && (mouseX > slideGx - 20 && mouseX < slideGx + 20)) { //Middle of slider
      slideGx = mouseX;
    }
  }
  if(slideGx < 569) //Top backup reset
    slideGx = 569;
  if(slideGx > 824)  //Bottom backup reset
    slideGx = 824;
  g = slideGx-569;
  
  noStroke();
  fill(0, g, 0);
  text("Green = " + g, 700, 325);
  for(int slideG = 0; slideG <= 255; slideG++) {
    fill(r, slideG, b);
    rect(572 + slideG, 350, 1, 40);
  }
  noFill();
  stroke(0, g, 0);
  strokeWeight(1);
  rect(slideGx, 350, 6, 40);
  stroke(255);
  line(slideGx+3-10, 400, slideGx+3, 390);
  line(slideGx+3+10, 400, slideGx+3, 390);
  
  ///////////////////////////BLUE
  if(mousePressed == true && (mouseY>=340 && mouseY<=410)) { //Vertical limiter
    if(slideBx == 869) { //Left of slider
      if(mouseX>=869 && mouseX<=875)
        slideBx = mouseX;
    }
    else if(slideBx == 1124) { //Right of slider
      if(mouseX<=1124 && mouseX>=1118)
        slideBx = mouseX;
    }
    else if((slideBx > 869 && slideBx < 1124) && (mouseX > slideBx - 20 && mouseX < slideBx + 20)) { //Middle of slider
      slideBx = mouseX;
    }
  }
  if(slideBx < 869) //Top backup reset
    slideBx = 869;
  if(slideBx > 1124)  //Bottom backup reset
    slideBx = 1124;
  b = slideBx-869;
  
  noStroke();
  fill(0, 0, b);
  text("Blue = " + b, 1000, 325);
  for(int slideB = 0; slideB <= 255; slideB++) {
    fill(r, g, slideB);
    rect(872 + slideB, 350, 1, 40);
  }
  noFill();
  stroke(0, 0, b);
  strokeWeight(1);
  rect(slideBx, 350, 6, 40);
  stroke(255);
  line(slideBx+3-10, 400, slideBx+3, 390);
  line(slideBx+3+10, 400, slideBx+3, 390);  
  
  /////////////////////////////////////////////// Examples
  stroke(r, g, b);
  for(int i = 0; i < fleetSize; i++) {
    fleet[i] = new Spaceship();
    fleet[i].setPointDirection(-90);
  }
  if(fleetSize%2 == 1) {
    fleet[0].moveOver(100, -50);
    fleet[1].moveOver(50, 0);
    fleet[2].moveOver(150, 0);
    fleet[3].moveOver(0, 50);
    fleet[4].moveOver(200, 50);
  }
  else {
    fleet[0].moveOver(100, -50);
    fleet[1].moveOver(100, 50);
    fleet[2].moveOver(50, 0);
    fleet[3].moveOver(150, 0);
  }
  for(int i = 0; i < fleetSize; i++)
    fleet[i].show();
  
  
  fill(210, 0, 0);
  strokeWeight(2);
  stroke(255);
  if(mouseX >= 550 && mouseX <= 850 && mouseY >= 850 && mouseY <= 920) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(550, 850, 300, 70);
  textAlign(CENTER);
  textSize(25);
  fill(255);
  text("Reset Leaderboard", 700, 890);
} //End of settingScreen

//////////////////////////////////////////////// End of Settings Screen

if(resetConfirmation == true) {
  background(0);
  textSize(40);
  fill(255);
  text("Are you sure you want to reset the leaderboard?", width/2, 400);
  
  fill(210, 0, 0);
  strokeWeight(2);
  stroke(255);
  if(mouseX >= 275 && mouseX <= 425 && mouseY >= 550 && mouseY <= 600) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(275, 550, 150, 50);
  textSize(28);
  fill(255);
  text("Yes", 350, 583);
  
  fill(210, 0, 0);
  strokeWeight(2);
  stroke(255);
  if(mouseX >= 775 && mouseX <= 925 && mouseY >= 550 && mouseY <= 600) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(775, 550, 150, 50);
  textSize(28);
  fill(255);
  text("No", 850, 583);
}

/////////////////////////////////////////////// End of Reset Leaderboard Confirmation

if(controlScreen == true) {
  background(0);
  fill(210, 0, 0);
  strokeWeight(2);
  stroke(200);
  if(mouseX >= 50 && mouseX <= 200 && mouseY >= 50 && mouseY <= 100 && controlLock == false) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(50, 50, 150, 50);
  fill(255);
  textSize(25);
  textAlign(CENTER);
  text("Return", 125, 83);
  
  textAlign(CENTER);
  fill(255);
  textSize(60);
  text("Controls", width/2, 120);

  textAlign(RIGHT);
  textSize(30);
  fill(230);
  text("Accelerate", 450, 250);
  textAlign(CENTER);
  if(setAccelKey == true) {
    fill(200);
    text("Press any key", 862, 248);
  }
  else {
    if(accelKey == ' ')
      text("SPACEBAR", 862, 248);
    else
      text(accelKey, 862, 248);
  }
  noFill();
  strokeWeight(2);
  stroke(200);
  if((mouseX >= 750 && mouseX <= 975 && mouseY >= 200 && mouseY <= 280) || setAccelKey == true) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(750, 200, 225, 80);  
  
  textAlign(RIGHT);
  fill(230);
  text("Turn Left", 450, 400);
  textAlign(CENTER);
  if(setLeftKey == true) {
    fill(200);
    text("Press any key", 862, 398);
  }
  else {
    if(leftKey == ' ')
      text("SPACEBAR", 862, 398);
    else
      text(leftKey, 862, 398);
  }
  noFill();
  strokeWeight(2);
  stroke(200);
  if((mouseX >= 750 && mouseX <= 975 && mouseY >= 350 && mouseY <= 430) || setLeftKey == true) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(750, 350, 225, 80);  
  
  textAlign(RIGHT);
  fill(230);
  text("Turn Right", 450, 550);
  textAlign(CENTER);
  if(setRightKey == true) {
    fill(200);
    text("Press any key", 862, 548);
  }
  else {
    if(rightKey == ' ')
      text("SPACEBAR", 862, 548);
    else
      text(rightKey, 862, 548);
  }
  noFill();
  strokeWeight(2);
  stroke(200);
  if((mouseX >= 750 && mouseX <= 975 && mouseY >= 500 && mouseY <= 580) || setRightKey == true) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(750, 500, 225, 80);
  
  textAlign(RIGHT);
  fill(230);
  text("Fire Bullet", 450, 700);
  textAlign(CENTER);
  if(setShootKey == true) {
    fill(200);
    text("Press any key", 862, 698);
  }
  else {
    if(shootKey == ' ')
      text("SPACEBAR", 862, 698);
    else
      text(shootKey, 862, 698);
  }
  noFill();
  strokeWeight(2);
  stroke(200);
  if((mouseX >= 750 && mouseX <= 975 && mouseY >= 650 && mouseY <= 730) || setShootKey == true) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(750, 650, 225, 80);
  
  textAlign(RIGHT);
  fill(230);
  text("Hyperspace", 450, 850);
  textAlign(CENTER);
  if(setHyperKey == true) {
    fill(200);
    text("Press any key", 862, 848);
  }
  else {
    if(hyperKey == ' ')
      text("SPACEBAR", 862, 848);
    else
      text(hyperKey, 862, 848);
  }
  noFill();
  strokeWeight(2);
  stroke(200);
  if((mouseX >= 750 && mouseX <= 975 && mouseY >= 800 && mouseY <= 880) || setHyperKey == true) {
    strokeWeight(4);
    stroke(17, 140, 79);
  }
  rect(750, 800, 225, 80);
  
  if(accelKey == leftKey || accelKey == rightKey || accelKey == shootKey || accelKey == hyperKey)
    controlLock = true;
  else if(leftKey == rightKey || leftKey == shootKey || leftKey == hyperKey)
    controlLock = true;
  else if(rightKey == shootKey || rightKey == hyperKey)
    controlLock = true;
  else if(shootKey == hyperKey)
    controlLock = true;
  else
    controlLock = false; 
    
  if(controlLock == true) {
    fill(210, 0, 0);
    textAlign(CENTER);
    text("All keybinds must be unique! Don't break the game!", width/2, 935);
  }
}

//////////////////////////////////////////////// End of Controls Screen

if(gameStart == true) {
  background(0);
  fill(255);
  
  for(int i = 0; i < stars.length; i++) {
    stars[i].show();
    stars[i].shine();
  }
  
  for(int i = 0; i < wreckers.size(); i++) {
    if(wreckers.get(i).getExploding() == false)
      wreckers.get(i).move();
    wreckers.get(i).show();
  }
  
  for(int i = 0; i < fleetSize; i++) {
    if(fleet[i] != null) {
      fleet[i].move();
      stroke(r, g, b);
      fleet[i].show();
    }
  }  
      
  if(wPressed == true) {
    for(int i = 0; i < fleetSize; i++) {
      if(fleet[i] != null) {
        fleet[i].accelerate(0.1);
        fleet[i].thruster();
      }
    }
  }
  if(aPressed == true) {
    for(int i = 0; i < fleetSize; i++) 
     if(fleet[i] != null) 
      fleet[i].turn(-5);
  }
  if(dPressed == true) {
    for(int i = 0; i < fleetSize; i++) 
     if(fleet[i] != null) 
      fleet[i].turn(5);
  }
  
  for(int i = 0; i < fleetSize; i++) {
    for(int j = 0; j < wreckers.size(); j++) {
      if( fleet[i] != null && dist(fleet[i].getCenterX(), fleet[i].getCenterY(), wreckers.get(j).getCenterX(), wreckers.get(j).getCenterY()) < fleet[i].getRadius() + wreckers.get(j).getRadius() + 1.5) {
        double tempCenterX = wreckers.get(j).getCenterX(); 
        double tempCenterY = wreckers.get(j).getCenterY();
        int tempColor = wreckers.get(j).getColor();
        score+=(int)(100*wreckers.get(j).getRadius());
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
        shipsRemaining --;
        asteroidsKilled++;
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
  
  if(shipsRemaining == 0) {
    if(timeTaken == false) {
      timer = (float)((millis()-startTime)/1000);
      timeTaken = true;
    }
    if((float)(millis()/1000) - (float)(startTime/1000) - timer > 1) {
      gameStart = false;
      gameEnd = true;
    }
  }
} //End of gameStart
  
////////////////////////////////////////////////////////////////////

if(gameEnd == true) {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(40);
    text("Your fleet was destroyed!", width/2, 200);
    
    String theEndTime = "Your fleet survived for " + timer + " seconds :D";
    text(theEndTime, width/2, 350);

    String totalPoints = "You scored " + score + " points and exploded " + asteroidsKilled + " asteroids!";
    text(totalPoints, width/2, 500);
    
    fill(0);
    strokeWeight(2);
    stroke(255);
    rect(300, 600, 600, 100);
    textAlign(CENTER);
    textSize(25);
    if(nameLength == 0) {
      fill(200);
      text("Type your name to save your score", width/2, 650);
    }
    else {
      fill(255);
      text(name, width/2, 655);
      textSize(17);
      fill(220);
      text("Max name length is 26 characters", 1050, 660);
      text("Your name will autosave!", 1050, 690);
    }
    
    strokeWeight(2);
    stroke(200);
    if(mouseX >= 450 && mouseX <= 750 && mouseY >= 750 && mouseY <= 850) {
      strokeWeight(4);
      stroke(17, 140, 79);
    }
    fill(210, 0, 0);
    rect(450, 750, 300, 100);
    fill(255);
    textSize(25);
    text("Back to Main Menu", width/2, 805);
    
} //End of gameEnd
} //End of draw()

///////////////////////////////////////////////////////////////////////////////////////////////

public void mousePressed() {
if(startScreen == true) {
  if(mouseX >= 450 && mouseX <= 750 && mouseY >= 250 && mouseY <= 350) { //Start Game
    startScreen = false;
    gameStart = true;
    startTime = millis();
  } 
  if(mouseX >= 450 && mouseX <= 750 && mouseY >= 450 && mouseY <= 550) { //Leaderboard
    startScreen = false;
    leaderboard = true;
  }  
  if(mouseX >= 75 && mouseX <= 325 && mouseY >= 455 && mouseY <= 542) { //Settings
    startScreen = false;
    settingScreen = true;
  }    
  if(mouseX >= 875 && mouseX <= 1125 && mouseY >= 455 && mouseY <= 542) { //Controls
    startScreen = false;
    controlScreen = true;
    return;
  }
} //End of startScreen

///////////////////////////////////////////////////////////////////////////////////////////
if(leaderboard == true) {
  if(mouseX >= 50 && mouseX <= 200 && mouseY >= 50 && mouseY <= 100) {
    startScreen = true;
    leaderboard = false;
    background(0);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////
if(settingScreen == true) {
  if(mouseX >= 50 && mouseX <= 200 && mouseY >= 50 && mouseY <= 100) {
    startScreen = true;
    settingScreen = false;
    background(0);
  } 
    
  if(mouseX >= 225 && mouseX <= 375 && mouseY >= 200 && mouseY <= 300) 
    fleetSize = 1;
  if(mouseX >= 425 && mouseX <= 575 && mouseY >= 200 && mouseY <= 300) 
    fleetSize = 2;
  if(mouseX >= 625 && mouseX <= 775 && mouseY >= 200 && mouseY <= 300) 
    fleetSize = 3;
  if(mouseX >= 825 && mouseX <= 975 && mouseY >= 200 && mouseY <= 300) 
    fleetSize = 4;
  if(mouseX >= 1025 && mouseX <= 1175 && mouseY >= 200 && mouseY <= 300) 
    fleetSize = 5;
  shipsRemaining = fleetSize;
  
  for(int i = 0; i < fleetSize; i++) {
    fleet[i] = new Spaceship();
  }
  if(fleetSize%2 == 1) {
    fleet[1].moveOver(-50, 50);
    fleet[2].moveOver(-50, -50);
    fleet[3].moveOver(-100, 100);
    fleet[4].moveOver(-100, -100);
  }
  else {
    fleet[1].moveOver(-100, 0);
    fleet[2].moveOver(-50, 50);
    fleet[3].moveOver(-50, -50);
  }
  
  if(mouseX >= 550 && mouseX <= 850 && mouseY >= 850 && mouseY <= 920) {
    settingScreen = false;
    resetConfirmation = true;
    background(0);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////
if(resetConfirmation == true) {
  if(mouseX >= 275 && mouseX <= 425 && mouseY >= 550 && mouseY <= 600) {
    while(leaderboardScore.size() != 0) {
      leaderboardScore.remove(0);
      leaderboardTime.remove(0);
      leaderboardName.remove(0);
    }
    resetConfirmation = false;
    startScreen = true;
    background(0);
  }
  if(mouseX >= 775 && mouseX <= 925 && mouseY >= 550 && mouseY <= 600) {
    resetConfirmation = false;
    settingScreen = true;
    background(0);
  }
}
/////////////////////////////////////////////////////////////////////////////////////////
if(controlScreen == true) {
  if(mouseX >= 50 && mouseX <= 200 && mouseY >= 50 && mouseY <= 100 && controlLock == false) {
    startScreen = true;
    controlScreen = false;
    setAccelKey = false;
    setLeftKey = false;
    setRightKey = false;
    setShootKey = false;
    setHyperKey = false;
    background(0);
  }
  
  else if(mouseX >= 750 && mouseX <= 975 && mouseY >= 200 && mouseY <= 280) { //Accelerate Controls
    setAccelKey = true;
    setLeftKey = false;
    setRightKey = false;
    setShootKey = false;
    setHyperKey = false;    
  }
  else if(mouseX >= 750 && mouseX <= 975 && mouseY >= 350 && mouseY <= 430) {
    setAccelKey = false;
    setLeftKey = true;
    setRightKey = false;
    setShootKey = false;
    setHyperKey = false;
  }
  else if(mouseX >= 750 && mouseX <= 975 && mouseY >= 500 && mouseY <= 580) {
    setAccelKey = false;
    setLeftKey = false;
    setRightKey = true;
    setShootKey = false;
    setHyperKey = false;
  }
  else if(mouseX >= 750 && mouseX <= 975 && mouseY >= 650 && mouseY <= 730) {
    setAccelKey = false;
    setLeftKey = false;
    setRightKey = false;
    setShootKey = true;
    setHyperKey = false;
  }
  else if(mouseX >= 750 && mouseX <= 975 && mouseY >= 800 && mouseY <= 880) {
    setAccelKey = false;
    setLeftKey = false;
    setRightKey = false;
    setShootKey = false;
    setHyperKey = true;
  }
  else {
    setAccelKey = false;
    setLeftKey = false;
    setRightKey = false;
    setShootKey = false;
    setHyperKey = false;
  }
}
/////////////////////////////////////////////////////////////////////////////////////////

if(gameEnd == true) {
  if(mouseX >= 450 && mouseX <= 750 && mouseY >= 750 && mouseY <= 850) { //Return to main menu
    background(0);
    for(int i = 0; i < leaderboardScore.size(); i++) {
      if(score > leaderboardScore.get(i)) {
        leaderboardScore.add(i, score);
        leaderboardTime.add(i, timer);
        leaderboardName.add(i, name);
        i = leaderboardScore.size();
      }
      else if(score == leaderboardScore.get(i)) { //Tiebreaker is time survived
        if(timer > leaderboardTime.get(i)) {
          leaderboardScore.add(i, score);
          leaderboardTime.add(i, timer);
          leaderboardName.add(i, name);
          i = leaderboardScore.size();
        }
      }
      else if(i == leaderboardScore.size()-1) {
        leaderboardScore.add(score);
        leaderboardTime.add(timer);
        leaderboardName.add(name);
        i = leaderboardScore.size();
      }
    }
    if(leaderboardScore.size() == 0) {
      leaderboardScore.add(score);
      leaderboardTime.add(timer);
      leaderboardName.add(name);
    }
    while(debris.size() != 0)
      debris.remove(0);
    while(wreckers.size() != 0)
      wreckers.remove(0);
    setup();
  } //End of return to main menu
  
} //End of end screen
} //End of draw()

////////////////////////////////////////////////////////////////////
public void keyPressed() {
  if(gameStart == true) {
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
        if(fleet[i] != null)
          fleet[i].hyperspace(newX, newY, newPoint);
      }
      if(fleet[1] != null)
        fleet[1].moveOver(-50, 50);
      if(fleet[2] != null)
        fleet[2].moveOver(-50, -50);
      if(fleet[3] != null)
        fleet[3].moveOver(-100, 100);
      if(fleet[4] != null)
        fleet[4].moveOver(-100, -100);
      for(int i = 0; i < stars.length; i++)
        stars[i] = new Star((int)(Math.random()*width), (int)(Math.random()*height));
      while(wreckers.size() != 0)
        wreckers.remove(0);
      for(int i = 1; i <= 15; i++)
        wreckers.add(new Asteroid());
    }
  }
  
  if(gameEnd == true) {
    if((key == 127 || key == 96) && nameLength > 0) {
      name = name.substring(0, nameLength-1);
      nameLength--;
    }
    else if(key >= 32 && key <= 126 && key != 96 && nameLength < 26) {
      name += String.fromCharCode(key);
      nameLength++;
    }
  } //End of game start
  
  if(controlScreen == true) {
    if(setAccelKey == true && key >= 32 && key <= 126) {
      if(key == 32)
        accelKey = ' ';
      else
        accelKey = String.fromCharCode(key);
    }
    if(setLeftKey == true && key >= 32 && key <= 126) {
      if(key == 32)
        leftKey = ' ';
      else
        leftKey = String.fromCharCode(key);
    }
    if(setRightKey == true && key >= 32 && key <= 126) {
      if(key == 32)
        rightKey = ' ';
      else
        rightKey = String.fromCharCode(key);
    }
    if(setShootKey == true && key >= 32 && key <= 126) {
      if(key == 32)
        shootKey = ' ';
      else
        shootKey = String.fromCharCode(key);
    }
    if(setHyperKey == true && key >= 32 && key <= 126) {
       if(key == 32)
        hyperKey = ' ';
      else
        hyperKey = String.fromCharCode(key);
    }
    
    if(key >= 32 && key <= 126) {
      setAccelKey = false;
      setLeftKey = false;
      setRightKey = false;
      setShootKey = false;
      setHyperKey = false;
    } //FOR GITHUB JAVASCRIPT
  } //End of Control Screen 
}

/////////////////////////////////////////////////////////////

public void keyReleased() {
  if(key == accelKey)
    wPressed = false;
  if(key == leftKey)
    aPressed = false;
  if(key == rightKey)
    dPressed = false;
}
