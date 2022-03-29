import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer notRickRoll;
FFT fftLin;

float spectrumScale = 10;



void setup() {
  size(1200, 600, P2D);
  rectMode(CENTER);
  minim = new Minim(this);

  notRickRoll = minim.loadFile("Never Gonna Give You Up.mp3", 1024);
  notRickRoll.loop();

  fftLin = new FFT(notRickRoll.bufferSize(), notRickRoll.sampleRate());
  fftLin.linAverages(128);
}

void draw() {
  //notRickRoll.play();
  background(0);
  stroke(0);

  fftLin.forward( notRickRoll.mix );

  
  //int w = int( width/fftLin.avgSize());
  //for (int i = 0; i < fftLin.avgSize(); i++) {
  //  rect(i*w, height/2, i*w + w, height/2 - fftLin.getAvg(i)*spectrumScale);
  //}


  for (int i = 2; i < fftLin.avgSize(); i++) {
    float angle = i * (TWO_PI/fftLin.avgSize());
    float distance = 270;
    float posX = cos(angle * (PI / 180)) * distance;
    float posY = sin(angle * (PI / 180)) * distance;
    println(fftLin.getAvg(i)*spectrumScale);
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle + PI);
    //rect(posX, posY, posX+int( width/fftLin.avgSize()), posY - fftLin.getAvg(i)*spectrumScale);
    //rect(posX+fftLin.getAvg(i)*spectrumScale/2, posY, fftLin.getAvg(i)*spectrumScale+5, int(width/fftLin.avgSize()*0.75), 20);
    rect(posX+sqrt(fftLin.getBand(i))*spectrumScale/2, posY, sqrt(fftLin.getBand(i))*spectrumScale+5, int(width/fftLin.avgSize()*0.75), 20);
    popMatrix();
  }
}
