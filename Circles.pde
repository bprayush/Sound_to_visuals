class Circle
{
  int x, y;
  float radius;
  color c;
  boolean transparencyOn;
  int transparency;
  
  Circle(int x, int y, boolean transparencyOn, float inValue)
  {
    this.x = x;
    this.y = y;
    this.transparencyOn = transparencyOn;
    c = color(inValue*5,inValue*5,inValue*5);
    transparency = 255;
    println("Color: "+255*inValue);
  }
  
  void update()
  {
    radius+=2;
    if (transparencyOn && radius >= 50 && transparency > 0) 
    { 
      transparency--; 
    }
  }
  
  void display() {
    noStroke();
    fill(c,transparency);
    ellipse(x,y,radius,radius);
  }
  
}