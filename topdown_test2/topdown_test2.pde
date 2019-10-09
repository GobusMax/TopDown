int dirX, dirY;
float posX, posY;
float speed = 0.6;
PVector look;
boolean shoot;
PImage barrel, crate, background_test;
int lastTime;
void setup() {
  size(1000, 1000);
  look = new PVector();
  barrel = loadImage("barrel3.png");
  crate = loadImage("crate2.png");
  background_test = loadImage("background_test2.jpg");

  lastTime = millis();
  frameRate(1000);
  background_test.resize(64*2, 64*2);
  noCursor();
  //noSmooth();
}
void draw() {
  int deltaTime = millis() - lastTime;
  lastTime += deltaTime; 

  background(0, 127, 0);

  //for (int i = -background_test.width; i < width+background_test.width; i += background_test.width) {
  //  for (int j = -background_test.height; j < height+width; j += background_test.height) {
  //    image(background_test, -posX%background_test.width+i, -posY%background_test.height+j);
  //  }
  //}
  for (int i=0; i<=width; i+=100) {
    line( (-posX%100+i), 0, (-posX%100+i), height); //X-GRID
  }  
  for (int i=0; i<=height; i+=100) {
    line( 0, (-posY%100+i), width, (-posY%100+i)); //Y-GRID
  }
  posX += dirX*speed*deltaTime; 
  posY += dirY*speed*deltaTime; 

  if (posX >= width-20) {
    posX = width-20;
  }
  if (posY >= height-20) {
    posY = width-20;
  }
  if (posY <= 20-height) {
    posY = 20-height;
  }
  if (posX <= 20-width) {
    posX = 20-width;
  }
  rect(1.5*width-posX, 0, 10, height); 
  rect(-0.5*width-posX-10, 0, 10, height); 
  rect(0, 1.5*height-posY, width, 10); 
  rect(0, -0.5*height-posY-10, width, 10); 


  println("X: "+posX); 
  println("Y: "+posY); 
  println(frameRate);
  println(mouseX);


  //line(mouseX-20, mouseY, mouseX-10, mouseY);
  //line(mouseX, mouseY-20, mouseX, mouseY+20);

  if (shoot) {
    stroke(255, 255, 0); 
    look.set(mouseX-width/2, mouseY-height/2); 
    look.setMag(1000); 
    line(width/2, height/2, width/2+look.x, height/2+look.y); 
    stroke(0);
  }


  //OBJECTS
  circle(-posX, -posY, 10); 
  circle(-posX+100, -posY+100, 25); 
  circle(-posX-100, -posY-100, 15); 
  image(barrel, -posX+200, -posY+200); 

  stroke(255, 0, 0); 
  line(width/2, height/2, mouseX, mouseY); 
  stroke(0); 
  strokeWeight(10); 
  look.set(mouseX-width/2, mouseY-height/2); 
  look.setMag(50); 
  line(width/2, height/2, width/2+look.x, height/2+look.y); 
  strokeWeight(1); 
  circle(width/2, height/2, 40);

  //CROSSHAIR
  drawCrosshair();
}






void keyPressed() {
  if (keyCode == LEFT || key == 'a') {
    dirX--; 
    if (dirX < -1) dirX = -1;
  } else if (keyCode == RIGHT || key == 'd') {
    dirX++; 
    if (dirX > 1) dirX = 1;
  } else if (keyCode == UP || key == 'w') {
    dirY--; 
    if (dirY < -1) dirY = -1;
  } else if (keyCode == DOWN || key == 's') {
    dirY++; 
    if (dirY > 1) dirY = 1;
  }
}

void keyReleased() {
  if (keyCode == LEFT || key == 'a') {
    dirX++; 
    if (dirX > 1) dirX = 1;
  } else if (keyCode == RIGHT || key == 'd') {
    dirX--; 
    if (dirX < -1) dirX = -1;
  } else if (keyCode == UP || key == 'w') {
    dirY++; 
    if (dirY > 1) dirY = 1;
  } else if (keyCode == DOWN || key == 's') {
    dirY--; 
    if (dirY < -1) dirY = -1;
  }
}
void mousePressed() {
  shoot = true;
}
void mouseReleased() {
  shoot = false;
}

void drawCrosshair(){
  strokeWeight(2);
  line(mouseX-20, mouseY, mouseX-5, mouseY);
  line(mouseX+20, mouseY, mouseX+5, mouseY);
  line(mouseX, mouseY-20, mouseX, mouseY-5);
  line(mouseX, mouseY+20, mouseX, mouseY+5);
  strokeWeight(1);
}
