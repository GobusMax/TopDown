class Weapon {
  float firerate;
  boolean auto;

  Weapon(){}
  void shoot() {
    
  }
  float calcDist(int objRadius, PVector objPos, PVector rayPos, boolean isCircle) {
    float minDist = Float.MAX_VALUE;
    PVector diff = PVector.sub(rayPos, objPos);
    if (isCircle) {
      minDist = PVector.dist(rayPos, objPos)-objRadius;
    } else {
      if (abs(rayPos.x-objPos.x) < objRadius ) {
        minDist = abs(diff.y)-objRadius;
      } else if (abs(rayPos.y-objPos.y) < objRadius ) {
        minDist = abs(diff.x)-objRadius;
      } else {
        //minDist = min(PVector.dist(rayPos, new PVector(objPos.x-radius, objPos.y-radius)), PVector.dist(rayPos, new PVector(objPos.x+radius, objPos.y-radius)), PVector.dist(rayPos, new PVector(objPos.x-radius, objPos.y+radius)));
        //minDist = min(minDist, PVector.dist(rayPos, new PVector(objPos.x+radius, objPos.y+radius)));
        minDist = sqrt(sq(abs(diff.x)-objRadius)+sq(abs(diff.y)-objRadius));
      }
    }
    return minDist;
  }
  int calcHit(PVector[] objects, boolean[] isCircle, PVector startPos, PVector rayDir, int radiusTEST) {
    PVector rayState = PVector.fromAngle(rayDir.heading());
    int closest = -1;
    while (rayState.mag() < rayDir.mag()) {
      float dist = Float.MAX_VALUE;
      for (int i = 0; i < objects.length; i++) {
        float newDist = min(calcDist(radiusTEST, objects[i], PVector.add(rayState, startPos), isCircle[i]), dist);
        if (newDist < dist) {
          dist = newDist;
          closest = i;
        }
      }
      noFill();
      circle(rayState.x+startPos.x, rayState.y+startPos.y, 2*dist);
      fill(255);
      //println(dist);
      if (dist < 0.0001) {
        //println("HIT!!");
        println(objects[closest]);
        fill(0, 255, 0);
        circle(rayState.x+startPos.x, rayState.y+startPos.y, 5);
        noFill();
        return closest;
      }
      rayState.setMag(rayState.mag()+dist);
    }

    return -1;
  }
}
