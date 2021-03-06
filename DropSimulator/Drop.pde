public class Drop
{
  float period = 30;
  float maxHeight = 60;
  float maxTime = 100;
  
  int positionX = 0;
  int positionY = 0;
  float time = 0;
  
  Drop(int positionX, int positionY, float creationTime)
  {
    this.positionX = positionX;
    this.positionY = positionY;
    this.time = creationTime;
  }
 
  float getZ(float x, float y, float currentTime)
  {
    float t = currentTime - this.time;
    if(t > maxTime)
    {
        return 0;
    }
    
    float value = sqrt(pow(x - positionX, 2) + pow(y - positionY, 2)) - t;
    float wave = int(value / period);
    wave = abs(wave - (t / period) * 2);
    
    // max * attenuazione onda * attenuazione temporale
    float temporalAttenuation = t / maxTime;
    float logaritmicModifier = 1 + 10 * temporalAttenuation; // da 1 a 11
    float waveAttenuation = log(wave + 1) / log(logaritmicModifier);
    if(waveAttenuation > 1)
    {
      return 0;
    }  
    
    float max = maxHeight * (1 - waveAttenuation) * (1 - temporalAttenuation);
    if(max > 0)
    {
      return max * sin(value * PI / period);
    }
    return 0;
  }
  
  boolean isDead(float currentTime)
  {
    return currentTime > (time + maxTime);
  }
}
