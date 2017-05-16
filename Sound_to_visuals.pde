import ddf.minim.analysis.*;
import ddf.minim.*;
import javax.sound.sampled.*;

Minim minim;  
FFT fftLin;
AudioInput in;
Mixer.Info[] mixerInfo;
Mixer.Info myMixer;

String mixerName = "DUOCAPTURE [plughw:2,0]";
static int SCREEN_WIDTH = 1200;
static int SCREEN_HEIGHT = 800;

int count=0;

ArrayList circles = new ArrayList();

void setup()
{
  size(1200, 800);
  smooth();
  minim = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();

  for(int i = 0; i < mixerInfo.length; i++)
  {
    println(mixerInfo[i].getName());
    if(mixerInfo[i].getName().equals(mixerName)){
      //myMixer = mixerInfo[i];
    }
  } 
  
  Mixer mixer = AudioSystem.getMixer(myMixer);
  minim.setInputMixer(mixer);
    
  in = minim.getLineIn(Minim.STEREO, 2048);
  fftLin = new FFT( in.bufferSize(), in.sampleRate() );
  fftLin.linAverages( 30 );
  
}



void draw()
{
  background(0);
  translate(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
  count++;
  if(count%29 == 0)
  {
    getInput();
    count = 0;  
  }
  
  //println("Count: "+count);
  
  for(int i=0; i<circles.size(); i++)
  {
    Circle c = (Circle) circles.get(i);
    c.update();
    c.display();
    if(c.radius >= width+300)
    {
      circles.remove(i);
      //println("Deleting an Object!");
    }
  }
  
}




void getInput()
{
  float sum = 0;
  float avg = 0;
  

  for(int i=0; i<29; i++)
  {
      fftLin.forward(in.mix);
      sum += fftLin.getBand(i);
  }

  avg = sum/29;
  sum=0;
  
  circles.add(new Circle(0, 0, false, avg));
  
}