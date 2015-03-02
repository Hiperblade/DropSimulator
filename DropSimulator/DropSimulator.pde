void setup() 
{
  size(800, 800, P3D);
  smooth();
  
  background(255);
}

int dimension = 300;
int step = 10;

float t = 0;
ArrayList<Drop> drops = new ArrayList<Drop>();

int drawType = 0;
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
      drawPoint(x, y, t);
    }
  }
  t++;
}

void keyPressed() {
  if(keyCode == 32) // barra spaziatrice
  {
    drawType = (drawType + 1) % 4;
  }
}

void drawPoint(float x, float y, float t)
{
  switch(drawType)
  {
    case 0:
      point(x, y, getZ(x, y, t));
      break;
    case 1:
      if((x < dimension - step) && (y < dimension - step))
      {
        line(x, y, getZ(x, y, t), x + step, y + step, getZ(x + step, y + step, t));
      }
      break;
    case 2:
      if(x < dimension - step)
      {
        line(x, y, getZ(x, y, t), x + step, y, getZ(x + step, y, t));
      }
      if(y < dimension - step)
      {
        line(x, y, getZ(x, y, t), x, y + step, getZ(x, y + step, t));
      }
      break;
    case 3:
      if((x < dimension - step) && (y < dimension - step))
      {
        line(x, y, getZ(x, y, t), x + step, y + step, getZ(x + step, y + step, t));
      }
      if((x < dimension - step) && (y > - dimension))
      {
        line(x, y, getZ(x, y, t), x + step, y - step, getZ(x + step, y - step, t));
      }
      break;
  }
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
