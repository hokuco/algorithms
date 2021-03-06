ArrayList<balloon>balloons=new ArrayList();
PVector gravity = new PVector(0, 0.2);
PVector lift =new PVector(0, -0.21); 

void setup() {
  fullScreen();
  for(int i=0;i<100;i++)balloons.add(new balloon(new PVector(random(0,width), random(0,height))));
}
void draw() {
  float angle= map(noise(frameCount/100.0), 0, 1, 0, 4*PI);
  PVector wind = new PVector(0, -1).rotate(angle);
  background(245);
  for (balloon Balloon : balloons) {
    Balloon.applyForce(gravity);
    Balloon.applyForce(lift);
    Balloon.applyForce(wind);
    Balloon.update();
  }
  line(width/2, height/2, width/2+wind.x*100, height/2+wind.y*500);
  point(width/2+wind.x*100, height/2+wind.y*500);
}
class balloon {
  PVector location, velocity, acceleration;
  float mass, diameter;
  balloon(PVector start) {
    diameter=random(20, 30);
    mass=diameter/10;
    location=start.copy();
    velocity=new PVector(0, 0);
    acceleration= new PVector(0, 0);
  }
  void applyForce(PVector force) {
    PVector a = force.copy().div(mass);
    acceleration.add(a.copy());
  }
  void update() {
    velocity.add(acceleration);
    velocity.limit(3);
    location.add(velocity);
    acceleration.mult(0);
    fill(255, 0, 0);
    ellipse(location.x, location.y, diameter, diameter);
    if (location.x<0)location.x=width;
    if (location.x>width)location.x=0;
    if (location.y<=0) {
      velocity.x = 0.1*velocity.x;
      velocity.y = -0.5*velocity.y;
    }
    if (location.y > height) {
      location.y=height;
      velocity.y=-0.5*velocity.y;
    }
  }
}
