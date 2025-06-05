// ###################################################
// SYSTEM SETTINGS

String ASPECT_RATIO = "16:9"; // Options: "1:1", "9:16", "16:9", "4:5"

int DURATION = 831; // in Frames

String INPUTFOLDER = "example_169"; // The folder inside "input"

int RESOLUTION = 4; // 1 is low, 5 is high


// ###################################################
// SYSTEM SETTINGS END

String inputPath = "../input/" + INPUTFOLDER + "/";
PImage img;
color white = #ffffff;

PGraphics pg;

color black = #000000;
color accent = #00ff00;
float third = 0.333333333;

int count = 0;

String sketchName;
int tilesX, tilesY, w, h;

void settings() {

  if (ASPECT_RATIO == "1:1") {
    w = 2048;
    h = 2048;
    tilesX = 4;
    tilesY = 4;
  } else if (ASPECT_RATIO == "9:16") {
    w = 1080;
    h = 1920;
    tilesX = 9;
    tilesY = 16;
  } else if (ASPECT_RATIO == "16:9") {
    w = 1920;
    h = 1080;
    tilesX = 16;
    tilesY = 9;
  } else if (ASPECT_RATIO == "4:5") {
    w = 2048;
    h = 2560;
    tilesX = 4;
    tilesY = 5;
  } else {
    println("invalid ASPECT_RATIO");
  }

  tilesX = tilesX * (int) Math.pow(2, RESOLUTION - 1);
  tilesY = tilesY * (int) Math.pow(2, RESOLUTION - 1);
  size(w, h);
}


void setup() {
  println(tilesX,tilesY);
}

void draw() {

  if (frameCount >= DURATION) {
    exit();
  };

  img = loadImage(inputPath + frameCount + ".png");
  img.resize(width, height);

  background(accent);

  noStroke();

  for (int x = 0; x < tilesX; x++) {
    for (int y = 0; y < tilesY; y++) {

      float w = width/tilesX;
      float h = height/tilesY;

      int px = int(x*w);
      int py = int(y*h);
      color c = img.get(px, py);
      float b = brightness(c);

      int selector = int(map(b, 0, 255, 0, 7));

      fill(black);

      push();
      translate(x*w, y*h);

      // w = w + 1;
      // h = h + 1;

      drawTile(selector, w, h);

      pop();
    }
  }

  saveFrame("../singleFrames/" + INPUTFOLDER + "/" + nf(frameCount, 4) + ".png");
  
  println(frameCount);
}


void drawTile(int selector, float w, float h) {
  switch(selector) {
  case 0:
    fill(black);
    rect(0, 0, w, h);
    break;
  case 1:
    fill(black);
    rect(0, 0, w*0.5, h*0.5);
    rect(w*0.5, h*0.5, w*0.5, h*0.5);
    break;
  case 2:
    fill(black);
    rect(0, 0, w*0.25, h*0.25);
    rect(w*0.5, 0, w*0.25, h*0.25);

    rect(w*0.25, h*0.25, w*0.25, h*0.25);
    rect(w*0.75, h*0.25, w*0.25, h*0.25);

    rect(0, h*0.5, w*0.25, h*0.25);
    rect(w*0.5, h*0.5, w*0.25, h*0.25);

    rect(w*0.25, h*0.75, w*0.25, h*0.25);
    rect(w*0.75, h*0.75, w*0.25, h*0.25);
    break;

  case 3:
    // nothing here
    break;

  case 4:
    fill(white);
    rect(0, 0, w*0.25, h*0.25);
    rect(w*0.5, 0, w*0.25, h*0.25);

    rect(w*0.25, h*0.25, w*0.25, h*0.25);
    rect(w*0.75, h*0.25, w*0.25, h*0.25);

    rect(0, h*0.5, w*0.25, h*0.25);
    rect(w*0.5, h*0.5, w*0.25, h*0.25);

    rect(w*0.25, h*0.75, w*0.25, h*0.25);
    rect(w*0.75, h*0.75, w*0.25, h*0.25);
    break;
  case 5:
    fill(white);
    rect(0, 0, w*0.5, h*0.5);
    rect(w*0.5, h*0.5, w*0.5, h*0.5);
    break;
  case 6:
    fill(white);
    rect(0, 0, w, h);
    break;
  case 7:
    fill(white);
    rect(0, 0, w, h);
    break;
  }
}
