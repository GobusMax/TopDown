PVector look;
boolean shoot;
int lastTime;
int deltaTime;
final int GRIDSIZE = 100;
Weapon test;
Player player1;
Prop[] testProps = new Prop[2];
PImage backgroundTest;
void setup() {
  size(1280, 720);
  imageMode(CENTER);

  look = new PVector();
  testProps[0] = new Prop(200, 200, loadImage("barrel3.png"), true);
  testProps[1] = new Prop(250, 250, loadImage("crate2.png"), false);
  backgroundTest = loadImage("background_test2.jpg");
  player1 = new Player();
  lastTime = millis();


  noCursor();
  //DEBUG
  frameRate(1000);
}
void draw() {

  //DELTATIME
  CalcDeltaTime();


  //BACKGROUND
  background(0, 100, 0);

  //GRID
  //for (int i = -backgroundTest.height/2; i< height + 2*backgroundTest.height; i+= backgroundTest.height) {
  //  for (int j = -backgroundTest.width/2; j<width + backgroundTest.width; j+= backgroundTest.width) {
  //    image(backgroundTest, j-player1.pos.x%backgroundTest.width, i-player1.pos.y%backgroundTest.height);
  //  }
  //}
  drawGrid(player1.pos.x, player1.pos.y);


  player1.move();
  player1.collide(testProps);
  player1.lookDirUpdate(mouseX, mouseY);

  //WALLS
  if (player1.pos.x >= width-20) {
    player1.pos.x = width-20;
  }
  if (player1.pos.y >= height-20) {
    player1.pos.y = height-20;
  }
  if (player1.pos.y <= 20-height) {
    player1.pos.y = 20-height;
  }
  if (player1.pos.x <= 20-width) {
    player1.pos.x = 20-width;
  }
  rect(1.5*width-player1.pos.x, 0, 10, height);
  rect(-0.5*width-player1.pos.x-10, 0, 10, height);
  rect(0, 1.5*height-player1.pos.y, width, 10);
  rect(0, -0.5*height-player1.pos.y-10, width, 10);


  if (shoot) {
    stroke(255, 255, 0);
    look.set(mouseX-width/2, mouseY-height/2);
    look.setMag(500);
    line(width/2, height/2, width/2+look.x, height/2+look.y);
    stroke(0);
  }


  //OBJECTS
  testProps[0].show(player1.pos);
  testProps[1].show(player1.pos);

  circle(-player1.pos.x, -player1.pos.y, 10);
  circle(-player1.pos.x+100, -player1.pos.y+100, 25);
  circle(-player1.pos.x-100, -player1.pos.y-100, 15);

  stroke(255, 0, 0);
  line(player1.screenPos.x, player1.screenPos.y, player1.screenPos.x + player1.lookDir.x, player1.screenPos.y + player1.lookDir.y);
  //line(width/2,height/2,mouseX,mouseY);
  stroke(0);
  strokeWeight(10);
  look.set(mouseX-width/2, mouseY-height/2);
  look.setMag(50);
  line(width/2, height/2, width/2+look.x, height/2+look.y);
  strokeWeight(1); 



  player1.drawP();

  //CROSSHAIR
  drawCrosshair( player1.screenPos.x + player1.lookDir.x, player1.screenPos.y + player1.lookDir.y);





  //DEBUG
  //println("X: "+player1.pos.x);
  //println("Y: "+player1.pos.y);
  //println("deltaTime:" + deltaTime);
  text("frameRate:" +frameRate,100,100);
}


void keyPressed() {
  player1.moveStart();
}

void keyReleased() {
  player1.moveStop();
}
void mousePressed() {
  shoot = true;
}
void mouseReleased() {
  shoot = false;
}
void CalcDeltaTime() {
  deltaTime = millis() - lastTime;
  lastTime += deltaTime;
}


void drawCrosshair(float x, float y) {
  strokeWeight(2);
  line(x-20, y, x-5, y);
  line(x+20, y, x+5, y);
  line(x, y-20, x, y-5);
  line(x, y+20, x, y+5);
  strokeWeight(1);
}
void drawGrid(float x, float y) {
  for (int i=0; i<=width+GRIDSIZE; i+=GRIDSIZE) {
    line( (i-x%GRIDSIZE), 0, (i-x%GRIDSIZE), height);//X-GRID
  }  
  for (int i=0; i<=height+GRIDSIZE; i+=GRIDSIZE) {
    line( 0, (i-y%GRIDSIZE), width, (i-y%GRIDSIZE));//Y-GRID
  }
}
