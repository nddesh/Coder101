class Reusable {
  float xpos;
  float ypos;
  float y_speed;
  int lives = 3;
  
  boolean mouse1;
  
  Reusable(float tempxpos, float tempypos, float tempy_speed) {
    xpos = tempxpos;
    ypos = tempypos;
    y_speed = tempy_speed;
  }
    
  void show() {
    fill(255, 0, 0);
    image(bottle, xpos, ypos, 40, 90);
  }
  
  void movement() {
    ypos -= y_speed;
    if ((ypos < 150) || (ypos > height+500)) {
      y_speed = -y_speed;
    }
  }
  
  void noCatch(int msX, int msY) {
    if ((msX > xpos && msX < (xpos + 50)) && (msY > ypos && msY < (ypos + 100))) {
      mouse1 = true;
      lives = lives - 1;
    }
    else {
      mouse1 = false;
    }
  }
}
 
  
