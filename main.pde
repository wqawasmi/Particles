/* Stellar Cloud by Waleed Qawasmi (wqawasmi)
 * Originally intended to simulate an interstellar cloud clumping together
 * but it just ended up looking cool so I rolled with it.
 * Also my first attempt at Processing, so excuse any slop.
 * Feel free to do as you wish with the code, just leave this header :P
 *
 * Email: w.qawasmi@rutgers.edu
 */

import peasy.*;
import toxi.geom.*;
import java.util.Vector;

PeasyCam cam;
float spawnRadius;
int offset;

//Forces
float gravity; 
float friction;
Gravity grav;

//World vars
Vector world;
int numParticles;

void setup() {
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 100);
  grav = new Gravity();
  world = new Vector();
  
  offset = 0;
  spawnRadius = 300;
  numParticles = 700;
  
  for(int i = 0; i < numParticles/2; i++) {
    world.add(new Particle());
  }
  
  offset = 300;
  for(int i = numParticles/2; i < numParticles; i++) {
    world.add(new Particle());
  }
}

void draw() {
  background(18);
  hint(DISABLE_DEPTH_TEST);
  
  for(int i = 0; i < numParticles; i++) {
    Particle temp = (Particle)world.get(i);
    temp.update();
    temp.draw();
    grav.applyGravity((Particle)world.get(i), world);
  }
  
  println("FPS: " + frameRate + " Frame Count: " + frameCount);
  
  //saveFrame("frame-####.tif");
  
  //if(frameCount > 1600)
  //  noLoop();
}
