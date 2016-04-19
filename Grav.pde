class Gravity {
  //Gravitational Constant
  final float G = .5;
  
  //min distance
  final float minDistance = 5;
  
  Gravity() {

  }
  
  //Using Fg = Gm1m2/r^2
  void applyGravity(Particle p1, Vector particles) {
    Vec3D force = new Vec3D(0,0,0);
    float f = 0;
    float r = 0;
    Particle p2; //Used for m2
    
    //Stop calculating particles that have already clumped to increase FPS
    if(p1.velocity.magnitude() > 0.001 || frameCount < 1000) {
      for(int i = 0; i < particles.size(); i++) {
        p2 = (Particle)particles.get(i);
        r = p1.position.distanceTo(p2.position);
        
        if(r > minDistance) {
          f = (G * p1.mass * p2.mass)/sq(r);
          
          force = p2.position.sub(p1.position);
          force.normalizeTo(f);
          
          p1.addForce(force);
         ((Particle)particles.get(i)).addForce(force.scaleSelf(-1));
        } else {
           p1.velocity.scaleSelf(.95);
           
        }
      
      }
    }
  
  }

}
