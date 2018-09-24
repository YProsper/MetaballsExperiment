int N = 12;
int N2 = 8;

float step = TWO_PI/N;
float step2 = TWO_PI/N2;

float rayon = 250;
float rayon2 = 100;
PVector[] pos;
PVector[] pos2;

PVector c;
PVector c2;

float theta = 0;
float theta2 = 0;

PImage i;

void setup() {
  size(600, 600);
  
  pos = new PVector[N];
  for(int k=0; k<N; k++){
    pos[k] = new PVector();
    pos[k].x = rayon*cos(k*step) + width/2;
    pos[k].y = rayon*sin(k*step) + height/2;
  }
  
  pos2 = new PVector[N2];
  for(int k=0; k<N2; k++){
    pos2[k] = new PVector();
    pos2[k].x = rayon2*cos(k*step2) + width/2;
    pos2[k].y = rayon2*sin(k*step2) + height/2;
  }
  
  c = new PVector();
  c.x = rayon*cos(theta) + width/2;
  c.y = rayon*sin(theta) + height/2;
  
  c2 = new PVector();
  c2.x = rayon2*cos(theta2) + width/2;
  c2.y = rayon2*sin(theta2) + height/2;
  
  i = createImage(width, height, RGB);
  i.loadPixels();
  for(int x = 0; x<i.width; x++){
    for(int y = 0; y<i.height; y++){
      float sum = 0;
      for(PVector p : pos) {
        sum += 2000/dist(x, y, p.x, p.y);
      }
      
      for(PVector p : pos2) {
        sum += 1000/dist(x, y, p.x, p.y); //<>//
      }
      
      i.pixels[x+y*i.width] = color(sum);
    }
  }
  updatePixels();
}

void draw() {
  background(0);
  
  loadPixels();
  i.loadPixels();
  for(int x=0; x<width; x++){
    for(int y=0; y<height; y++) {
      float d = 2000/dist(x, y, c.x, c.y);
      float d2 = 1000/dist(x, y, c2.x, c2.y);
      color d3 = blendColor(i.pixels[x+y*i.width], color(d+d2), ADD);
      if (d3 > color(230) && d3<color(240)){ //<>//
        pixels[x+y*width] = d3;
      } else {
        pixels[x+y*width] = color(0);
      }
    }
  }
  i.updatePixels();
  updatePixels();
  theta += 0.01;
  c.x = rayon*cos(theta) + width/2;
  c.y = rayon*sin(theta) + height/2;
  
  theta2 -= 0.01;
  c2.x = rayon2*cos(theta2) + width/2;
  c2.y = rayon2*sin(theta2) + height/2;
}
