class Player extends General {
  private PVector moveDir;
  private PVector lookDir;
  private float speed;
  private final float SPEED_INIT = 0.2;
  private final PVector screenPos = new PVector(width/2, height/2);
  private final int size = height/20;
  private Weapon w;


  Player() {
    pos = new PVector();
    moveDir = new PVector();
    lookDir = new PVector();
    speed = SPEED_INIT;
  }
  Player(float posX, float posY) {
    pos = new PVector(posX, posY);
    moveDir = new PVector(0, 0);
    lookDir = new PVector(0, 0);
    speed = SPEED_INIT;
  }
  void move() {
    PVector moveVel = moveDir.normalize(null);
    pos.x += moveVel.x*speed*deltaTime;
    pos.y += moveVel.y*speed*deltaTime;
  }

  void drawP() {
    circle(width/2, height/2, size);
  }
  void lookDirUpdate(int x, int y) {
    lookDir.set(x-screenPos.x, y-screenPos.y);
  }
  void moveStart() {
    if (keyCode == LEFT || key == 'a') {
      moveDir.x--;
      if (moveDir.x < -1) moveDir.x = -1;
    } else if (keyCode == RIGHT || key == 'd') {
     moveDir.x++;
      if (moveDir.x > 1) moveDir.x = 1;
    } else if (keyCode == UP || key == 'w') {
      moveDir.y--;
      if (moveDir.y < -1) moveDir.y = -1;
    } else if (keyCode == DOWN || key == 's') {
      moveDir.y++;
      if (moveDir.y > 1) moveDir.y = 1;
    }
  }
  void moveStop() {
    if (keyCode == LEFT || key == 'a') {
      moveDir.x++;
      if (moveDir.x > 1) moveDir.x = 1;
    } else if (keyCode == RIGHT || key == 'd') {
      moveDir.x--;
      if (moveDir.x < -1) moveDir.x = -1;
    } else if (keyCode == UP || key == 'w') {
      moveDir.y++;
      if (moveDir.y > 1) moveDir.y = 1;
    } else if (keyCode == DOWN || key == 's') {
      moveDir.y--;
      if (moveDir.y < -1) moveDir.y = -1;
    }
  }

  void shoot() {
    w.shoot();
  }
  void collide(Prop[] props) {
    for (int i=0; i < props.length; i++) {
      text(PVector.dist(this.pos, props[i].pos), 100, 50+100*i);
      if ((props[i].hb.isC && PVector.dist(this.pos, props[i].pos) < this.size/2+props[i].hb.radius) || (!props[i].hb.isC && (this.pos.x+this.size/2 > props[i].pos.x-props[i].hb.radius && this.pos.x-this.size/2 < props[i].pos.x+props[i].hb.radius) && (this.pos.y+this.size/2 > props[i].pos.y-props[i].hb.radius && this.pos.y-this.size/2 < props[i].pos.y+props[i].hb.radius))) {
        text("hit", 300, 300);
        //pos.x += -moveDir.x*speed*deltaTime;
        //pos.y += -moveDir.y*speed*deltaTime;
        pos.add(PVector.sub(pos,props[i].pos).normalize().mult(speed*deltaTime));
      }
    }
  }
}
