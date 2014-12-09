
import ddf.minim.*;
import ddf.minim.effects.*;
import processing.serial.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
AudioSource signal;
AudioPlayer song;
Serial myPort; 
FFT fft;
int outputa, outputb, outputc;


void setup()
{
  size(1024, 100, P2D);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);
  signal = (AudioSource) in;
  //song = minim.loadFile("song.mp3");

  //song.play();

 
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 19200);
  //fft = new FFT(song.bufferSize(), song.sampleRate());
  fft = new FFT(in.bufferSize(), in.sampleRate());
}

void draw()
{
  background(0);
  fft.forward(in.mix);
  
  stroke(#FFFFFF);
  
  float a = fft.getFreq(70);
  float b = fft.getFreq(210);
  float c = fft.getFreq(500);
  outputa = int(a);
  outputb = int(b);
  outputc = int(c);

  if (outputa > 40)
    outputa = 255;
  else 
    outputa = 0;

  for(int i = 0; i < signal.bufferSize()/3; i++)
  {
    
    line(i, height, i, height - outputa);
    line(i+342, height, i+342, height - outputb);
    line(i+684, height, i+684, height - outputc);
   //Serial.print(output, BIN); 
    //println(output);    
  }
   myPort.write(outputa);   
   //myPort.write(outputb);   
   //myPort.write(outputc);   
}

void stop()
{
  in.close();
  signal.close();
  //song.close();
  minim.stop();
  super.stop();
}
