class Prop extends General {
  public Hitbox hb;
  private PImage img;

  Prop(float posX, float posY, PImage image,boolean tIsC) {
    pos = new PVector(posX, posY);
    img = image;
    hb = new Hitbox(image.width/2,tIsC);
  }


  void show(PVector playerPos) {
    image(img, pos.x-playerPos.x+width/2, pos.y-playerPos.y+height/2);
  }
}
