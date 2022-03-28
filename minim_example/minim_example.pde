import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer notRickRoll;
int rotation = 0;

void setup() {
  size(800, 600, P2D);

  minim = new Minim(this);

  notRickRoll =minim.loadFile("Never Gonna Give You Up.mp3");
  notRickRoll.loop();
}

void draw() {
  notRickRoll.play();
  background(255);
  stroke(0);

  for (int i = 0; i <= 360; i ++) {
    
    rotate(i);
    rect( width/2, i, notRickRoll.left.level()*width*random(-1, 1), 25);
    rect( width/2, i+1, notRickRoll.right.level()*width*random(-1, 1), 25);
  }
}
