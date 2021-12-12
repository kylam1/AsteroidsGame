public Star[] stars = new Star[300];
public Spaceship[] fleet = new Spaceship[5];
public Spaceship Delta; public Spaceship Omicron;
public ArrayList <Asteroid> wreckers = new ArrayList <Asteroid> ();
public boolean wPressed, aPressed, dPressed;
public boolean inHyperSpace;
public ArrayList <Particle> debris = new ArrayList <Particle> ();
public int shipsRemaining;
public boolean startScreen, leaderboard, gameStart, gameEnd;
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
  
  for(int i = 0; i < fleet.length; i++) {
    fleet[i] = new Spaceship();
  }
  fleet[1].moveOver(-50, 50);
  fleet[2].moveOver(-50, -50);
  fleet[3].moveOver(-100, 100);
  fleet[4].moveOver(-100, -100);
  shipsRemaining = fleet.length;
  
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
  text("Welcome to Asteroids!", width/2, 150);  
  
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
        shipsRemaining -= 1;
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
    if(name == "") {
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

///////////////////////////////////////////////////////////////////////
} //End of draw()

public void mousePressed() {
if(startScreen == true) {
  if(mouseX >= 450 && mouseX <= 750 && mouseY >= 250 && mouseY <= 350) { //Start Game
    startScreen = false;
    gameStart = true;
    startTime = millis();
  } //End of start game
  
  if(mouseX >= 450 && mouseX <= 750 && mouseY >= 450 && mouseY <= 550) { //Leaderboard
    startScreen = false;
    leaderboard = true;
  }
} //End of startScreen

if(leaderboard == true) {
  if(mouseX >= 50 && mouseX <= 200 && mouseY >= 50 && mouseY <= 100) {
    startScreen = true;
    leaderboard = false;
    background(0);
  }
}

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
  
  if(gameEnd == true) {
    if((key == 127 || key == 96) && nameLength > 0) {
      name = name.substring(0, nameLength-1);
      nameLength--;
    }
    else if(key >= 32 && key != 127 && key != 96 && nameLength < 26) {
      if(keyCode != VK_SHIFT) {
        name += String.fromCharCode(key);
        nameLength++;
      }
    }
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
