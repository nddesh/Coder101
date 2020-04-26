//VARIABLES
int currentTime;
int time1, time2;
int startTime;
int mins, secs, time;
int lives = 3;
int score = 0;
int best;
int window = 0;

//IMAGES AND FONTS
PImage trash, bottle, bin, lifelost, back;
PFont font;

//CLASSES
Trash [] myTrash = new Trash[5];
Reusable [] myBottle = new Reusable[3];


//MAIN CODE
void setup() {
  size(1200, 800);
  frameRate(50);
  smooth();
  noStroke();
  textAlign(CENTER);
  window = 0;
  
  //images and fonts
  trash = loadImage("trashbottle2.png");
  bottle = loadImage("rebottle.png");
  bin = loadImage("recycle.png");
  lifelost = loadImage("Lifelost.png");
  back = loadImage("back.png");
  font = createFont("Exo-SemiBold.ttf", 60); 
  
  //object creation
  for (int i=0; i<5; i++) {
    myTrash[i] = new Trash(random(50, width-100), random(height, height+500), random(6, 8));}
  for (int j=0; j<3; j++) {
    myBottle[j] = new Reusable(random(50, width-100), random(height, height+500), random(6, 8));}
}


void draw() {
  textFont(font);
  background(back);
  
  //START SCREEN
  if (window == 0) {
    textAlign(CENTER);
    lives = 3;
    score = 0;
    time = 59;
   
    fill(255);
    textSize(125);
    text("TRASH", width/2, height/2 - 100);
    text("CATCH", width/2, height/2 + 50);
    textSize(30);
    fill(0, 200, 100);
    text("RECYCLE PLASTIC  |  SAVE THE WORLD", width/2, height/2 - 250);
    fill(0, 200, 255);
    textSize(40);
    text("Press ENTER to play", width/2, height/2 + 200);
    
    
    if (keyPressed) {
      if (key == RETURN || key == ENTER) {
        window = 1;
      }
    }
  }
  
  
  
  //INSTRUCTIONS
  else if (window == 1) {
    textAlign(CENTER);
    textSize(70);
    fill(255);
    text("INSTRUCTIONS", width/2, 100);
    
    textAlign(LEFT);
    textSize(30);
    
    fill(0, 0, 255);
    image(bin, 155, 160, 70, 90);
    fill(255);
    text("Use the mouse pointer to move the\nrecycling bin", 300, 190);
    
    fill(100);
    image(trash, 145, 290, 80, 70);
    fill(255);
    text("Recycle the plastic and save Earth from plastic", 300, 340);
    
    fill(255, 0, 0);
    image(bottle, 165, 390, 40, 90);
    fill(255);
    text("Avoid catching the metal bottles to reuse them", 300, 450);
    
    image(lifelost, 150, 515, 70, 70);
    fill(255);
    text("You have 3 lives", 300, 545);
    text("If you catch the wrong bottle, you lose a life", 300, 585);
    
    textAlign(CENTER);
    fill(255);
    text("Recycle as many bottles as you can before time runs out!", width/2, 690);
    fill(0, 200, 255);
    textSize(40);
    text("CLICK to start", width/2, 750);
    if (mousePressed) {
      window = 2;
      textSize(50);
      startTime = millis();
      time = 59;
    }
  }
    


  //GAME SCREEN
  else if (window == 2) {
    frameRate(50);
    fill(255);
    textAlign(CENTER);
    textSize(50);
    
    //MOUSE ANIMATION
    noCursor();
    image(bin, mouseX, mouseY, 60, 80);
    
    //TIME DISPLAY
    if (time>0) {
      secs = time - (millis() - startTime)/1000;
      mins = (time - (millis() - startTime)/1000)/60;
      if (secs < 11) {
        if (secs == 10) {
          fill(255, 0, 0);
          text(mins + ":" + secs, width - 70, 60);
        }
        else {
        fill(255, 0, 0);
        text(mins + ":0" + secs, width - 70, 60);
        }
      }
      else {
        fill(255);
        text(mins + ":" + secs, width - 70, 60);
      }
    }
        
    //SCORE DISPLAY
    textAlign(LEFT);
    fill(100);
    image(trash, 0, 10, 50, 50);
    textSize(30);
    fill(255);
    text("Bottles Recycled: " + score, 50, 60);
    textSize(25);
    text("Best Score: " + best, 10, 100);
    
    
    //LIVES DISPLAY
    if (lives == 2) {
      image(lifelost, width/2, 20, 60, 60);
    }
    if (lives == 1) {
      image(lifelost, width/2 + 100, 20, 60, 60);
      image(lifelost, width/2, 20, 60, 60);
    }
    
    
    //TRASH ANIMATION
    for(int i=0; i<5; i++) {
      if ((mouseX > myTrash[i].x) && (mouseX < (myTrash[i].x + 50)) && (mouseY > myTrash[i].y) && (mouseY < (myTrash[i].y + 100))){
        myTrash[i] = new Trash(random(50, width-100), random(height, height+500), random(6, 8));
        score = score + 10;
      }
      myTrash[i].destroy(mouseX, mouseY);
      myTrash[i].move();
      myTrash[i].display();
    }
    
    
    //METAL BOTTLE ANIMATION
    for(int j=0; j<3; j++) {
      if ((mouseX > myBottle[j].xpos) && (mouseX < (myBottle[j].xpos + 50)) && (mouseY > myBottle[j].ypos) && (mouseY < (myBottle[j].ypos + 100))){
        myBottle[j] = new Reusable(random(50, width-100), random(height, height+500), random(6, 8));
        
        //LIFE LOST ANIMATION
        int currentTime = millis();
        int time1 = currentTime - 1;
        int time2 = currentTime + 3;  
        textAlign(CENTER);
        lives = lives - 1;
        if ((currentTime > time1) && (currentTime < time2)) {
          frameRate(1);
          fill(170, 0, 0);
          rect(0, 0, width, height);
          fill(255);
          textSize(70);
          textAlign(CENTER);
          text("LIFE LOST", width/2, height/2);
        }
      }
      
      myBottle[j].noCatch(mouseX, mouseY);
      myBottle[j].movement();
      myBottle[j].show();
    }
      
    //WHEN 3 LIVES ARE LOST
    if (lives == 0) {
        window = 3;
    }
    
    //END GAME
    else if (secs == 0 || secs < 0 && secs < -3) {
      window = 3;
    }
  }
  
  
  //END SCREEN
  if (window == 3) {
    frameRate(50);
    
    image(trash, width/2 - 280, 130, 100, 90);
    image(bottle, width/2 + 200, 130, 50, 90);
    
    //best = score;
    if (score > best) {
      best = score;
    }
    
    textSize(50);
    fill(0, 200, 255);
    text("Your Score: " + score, width/2, 200);
    fill(255);
    textSize(30);
    text("Your Best: " + best, width/2, 250);
    
    
    //SCORES AND MESSAGE CONDITIONS
    if (0 < score && score < 450) {
      text("You're a beginner!", width/2, 350);
      text("You still have a lot to learn about recycling", width/2, 400);
      text("Why not start with using metal water bottles?", width/2, 450);
    }
    if (450 < score && score < 900) {
      text("You're an expert!", width/2, 350);
      text("Keep up the good work!", width/2, 400);
      text("A little recycling goes a long way", width/2, 450);
    }
    if (900 < score) {
      text("You're a master!", width/2, 350);
      text("You are saving the world from plastic trash!", width/2, 400);
      text("Now, help people around you to do the same", width/2, 450);
    }
    textSize(40);
    textAlign(CENTER);
    
    //RESTART OR END
    fill(0, 200, 255);
    text("Press P to beat your score \nor Q to take a break", width/2, 600);
    if (keyPressed) {
      if (key == 'P' || key == 'p') {
        window = 0;
      }
      if (key == 'Q' || key == 'q') {
        best = 0;
        exit();
      }
    }
  }    
}
    

  
