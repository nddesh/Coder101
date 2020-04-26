class Trash {
  float x;
  float y;
  float yspeed;
  int score = 0;
  
  boolean mouse;
  
  Trash(float tempx, float tempy, float tempyspeed) {
    x = tempx;
    y = tempy;
    yspeed = -tempyspeed;
  }
    
  void display() {
    fill(100);
    image(trash, x, y, 70, 70);
  }
  
  void move() {
    y += yspeed;
    if ((y < 150) || (y > height+500)) {
      yspeed = -yspeed;
    }
  }
  
  void destroy(int mx, int my) {
    if ((mx > x && mx < (x + 50)) && (my > y && my < (y + 100))) {
      mouse = true;
      score = score + 10;
    }
    else {
      mouse = false;
    }
  }
}
 
  
