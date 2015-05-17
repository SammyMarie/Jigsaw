import TUIO.*;

TuioProcessing tuioClient;
TuioObject tobj;
boolean[] flag;
boolean finished = false;
int[] xPos = {
  21, 177, 286, 506, 608, 21, 133, 330, 454, 653, 
  21, 177, 286, 497, 608, 21, 133, 335, 446, 662};
int[] yPos = {
  35, 35, 35, 35, 35, 127, 173, 138, 188, 140, 330, 
  280, 328, 280, 330, 427, 473, 441, 486, 434};
PImage bkg;
PImage welcome;
PImage next;
PImage[] towerBridge;
PFont myFont;
Timer oneSecond;
int seconds = 0;
int minutes = 0;
int score = 0;
boolean isFinished = false;

void setup() {
  size(1024, 768);
  tuioClient  = new TuioProcessing(this);
  bkg = loadImage("board.gif");
  welcome = loadImage("welcome-page.png");
  next = loadImage("next-game.gif");
  towerBridge = new PImage[20];
  flag = new boolean[1000];
  myFont = createFont("arial", 12, false);



  for (int i = 0; i < 20; i++) {
    
    int j = i + 1;
    towerBridge[i] = loadImage("Tower-Bridge/image-" + j +".png");  
    //flag[i]=true;
//    println(towerBridge);
  }
}

void draw() {
  background(bkg);
  image(welcome, 200, 40);
  
  if (oneSecond != null) {
    if (oneSecond.isFinished() && minutes >= 0) {
      
      seconds--;
      oneSecond.start();
    }
  }
  if (seconds == -1) {
    
    seconds = 59;
    minutes--;
  }
  textFont(myFont, 36); 
  if (seconds >= 10 && minutes >= 0) {
    
    text(minutes + ":" + seconds, 900, 63);
    println(minutes);
  } else if (minutes < 0) {

    text("00:00", 900, 63);
  } else {
    text(minutes +":0" + seconds, 900, 63);
  }

  if (minutes <= 0 && seconds == 0) {
    for (int i = 0; i < 20; i++) {
      
      flag[i] = false; 
    }
    isFinished = true;
  }
  
  if (isFinished)
  {
//    text("Please, \nTry Again", 830, 500);
  }

  textFont(myFont, 60);
  text(score, 900, 150);

  for (int i = 0; i < 20; i++) {
    if (flag[i]) {
      image(towerBridge[i], xPos[i], yPos[i]);
    } 
  }
  if (finished) {
    image(next, 830, 500);
    textFont(myFont, 12);
    text("Name: The Tower Bridge", 850, 230);
    text("Location: London England", 850, 245);
    text("The Tower Bridge is ", 850, 300);
    text("a suspension bridge in", 850, 315);
    text("London England over the ", 850, 330);
    text("the River Thames. ", 850, 345);
    text("Construction started in ", 850, 360);
    text("1886 and took eight years", 850, 375);
    text("to complete. The bridge was ", 850, 390);
    text("officially opened on 30th", 850, 405);
    text("June 1894.", 850, 420);
  
  }
}
void updateTuioObject (TuioObject tobj) {
}

void addTuioObject(TuioObject tobj_) { 
  int count = 0;
  score = 0;
  tobj = tobj_;
  if (tobj_.getSymbolID() == 35) {
    welcome = new PImage();
    minutes = 1;
    seconds = 0;
    oneSecond = new Timer(71990);
    oneSecond.start();
    
    isFinished = false;
    
  } else {
    flag[tobj_.getSymbolID()]= true;


    for (int i = 0; i < 20; i++) {
      if (flag[i]) {
        
        count++;
        score +=  2;
      }
    }
    if (count == 20) {
      
      finished = true;
    } 
  } 
}
void removeTuioObject(TuioObject tobj) {
}
void addTuioCursor(TuioCursor tcur) {
}
void updateTuioCursor (TuioCursor tcur) {
}
void removeTuioCursor(TuioCursor tcur) {
}
void refresh(TuioTime timestamp) {
}

