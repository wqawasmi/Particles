class Particle {
  //Vector qualities
  Vec3D position;
  Vec3D velocity;
  Vec3D force;
  Vec3D acceleration;
  
  //Scalar qualities
  float mass;
  
  //Default constructor
  Particle() {
    mass = 1; //Default mass
    velocity = new Vec3D(0,0,0);
    force = new Vec3D(0,0,0);
    randomizePos();
  }
  
  //Particle(mass)
  Particle(float _mass) {
    velocity = new Vec3D(0,0,0);
    force = new Vec3D(0,0,0);
    randomizePos();
    mass = _mass;
  }
  
  //Particle(mass, position, velocity, force)
  Particle(float _mass, Vec3D _pos, Vec3D _vel, Vec3D _force) {
    mass = _mass;
    position = _pos;
    velocity = _vel;
    force = _force;
  }
  
  //Reset position by randomizing new starting point
  void randomizePos() {
   position = Vec3D.randomVector();
   position.scaleSelf(random(0, spawnRadius));
   position.x += offset;
   acceleration = new Vec3D(0,0,0);   
  }
  
  //Draw point at position
  void draw() {
    strokeWeight(2);
    
    //generate color as a function of radius
    float dist = position.distanceTo(new Vec3D(0,0,0));
    int c;
    
    if(dist < spawnRadius/2.5) { 
     float blue = map(abs(dist), 0, spawnRadius/2.5, 0, 255);
     c = color(255, 0, blue);
    } else {
     float white = map(abs(dist), spawnRadius/2.5, spawnRadius, 225, 255);
     c = (int)white;
    }
    
    stroke(c);
    smooth();
    point(position.x, position.y, position.z);
    //line(position.x, position.y, position.z, position.x + .1, position.y + .1, position.z + .1);
  }
  
  //Overwrite current force with new one
  void applyForce(Vec3D _force) {
    force = _force;
  }
  
  void addForce(Vec3D _force) {
    force.addSelf(_force);
  }

  //Accel = Force/Mass, reset acceleration to zero after every frame
  void update() {
    //applyAttractiveForce();
    acceleration.x = force.x/mass;
    acceleration.y = force.y/mass;
    acceleration.z = force.z/mass;
    
    velocity.addSelf(acceleration);
    position.addSelf(velocity);
    
    acceleration = new Vec3D(0,0,0);
    force = new Vec3D(0,0,0);
  }
    
}
