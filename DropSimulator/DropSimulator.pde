void setup() 
{
  size(800, 800, P3D);
  smooth();
  
  background(255);
}

int dimension = 300;
int step = 5;

float t = 0;
ArrayList<Drop> drops = new ArrayList<Drop>();

int lastDropTime = millis();

void draw()
{
  if(mousePressed && millis() > lastDropTime + 100)
  {
    drops.add(new Drop(mouseX - (width/2), mouseY - (height/2), t));
    lastDropTime = millis();
  }
  
  for(int i = drops.size() - 1; i >= 0; i--)
  {
    if(drops.get(i).isDead(t))
    {
      drops.remove(i);
    }
  }
  
  translate(width/2, height/2, 0);
  rotateX(PI/8);
  
  background(255);
  for(int x = -dimension; x < dimension; x += step)
  {
    for(int y = -dimension; y < dimension; y += step)
    {
      point(x, y, getZ(x, y, t));
    }
  }
  t++;
}

float getZ(float x, float y, float time)
{
  float ret = 0;
  for(int i = 0; i < drops.size(); i++)
  {
    ret += drops.get(i).getZ(x, y, t);
  }
  return ret;
}
