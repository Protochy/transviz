import java.util.*;
List<PVector> coeff = new ArrayList<>();
List<Float> col = new ArrayList<>();
PImage inputImage;
void setup(){
  size(800,800,P2D);
  strokeWeight(8);
  smooth(8);
  frameRate(60);
  inputImage = loadImage("Lhu.png");
  
coeff.add(new PVector(241.85909090909092,-161.14210526315793));
coeff.add(new PVector(-75.2459112454705,25.177069830421246));
coeff.add(new PVector(-49.44626151221057,8.868441174008014));
coeff.add(new PVector(5.012112918834362,68.21483877121128));
coeff.add(new PVector(-3.5122550372856303,23.78773630354085));
coeff.add(new PVector(49.14740857250693,-14.933497825171598));
coeff.add(new PVector(13.876769352037947,-35.82380858701319));
coeff.add(new PVector(4.115311574840337,26.193927930582785));
coeff.add(new PVector(-23.41149622051659,-20.609746587018737));
coeff.add(new PVector(24.95396642724503,20.0258517208987));
coeff.add(new PVector(-8.985245136024258,0.8861308611927379));
coeff.add(new PVector(-2.584908486683795,24.90975572839036));
coeff.add(new PVector(7.944376737637498,0.11327664456198928));
coeff.add(new PVector(4.954578097603349,20.59672624835047));
coeff.add(new PVector(4.9042822758603055,4.599105635635374));
coeff.add(new PVector(-5.878074058207316,10.983018372454698));
coeff.add(new PVector(-1.1838546460304187,-3.8360965602685715));
coeff.add(new PVector(-3.356977870758564,0.26902203590226026));
coeff.add(new PVector(0.8748594315469735,-3.9814791089268247));
coeff.add(new PVector(-3.510024482368839,5.0634246700545615));
coeff.add(new PVector(-0.16815497830417883,-5.61812522774753));
coeff.add(new PVector(-6.610284751235765,5.763290130998069));
coeff.add(new PVector(0.03503300050837829,-8.071637286512278));
coeff.add(new PVector(-8.929248402122472,3.679593864977435));
coeff.add(new PVector(-2.792670207819912,-2.7972403599410804));
coeff.add(new PVector(-4.52106859925687,0.39203447226311455));
coeff.add(new PVector(-2.941831025873327,-1.5191523556047906));
coeff.add(new PVector(-3.891518590525513,-1.9786191321482796));
coeff.add(new PVector(-3.310023983577022,-0.5516487407676306));
coeff.add(new PVector(-4.606162461565029,-1.602991194298497));
coeff.add(new PVector(-2.2294687402644886,-0.8224310567786046));
coeff.add(new PVector(-3.1005642002243916,-2.0294079292875646));
coeff.add(new PVector(-1.8522683933133963,-2.4007404885232004));
coeff.add(new PVector(-0.3008384331897668,-2.0230228563108508));
coeff.add(new PVector(-1.9145094449172746,-2.057757536114173));
coeff.add(new PVector(-1.192698580607787,1.0594180354809548));
coeff.add(new PVector(-3.3076971332363403,-1.6954071928238605));
coeff.add(new PVector(-1.0370544184926345,-0.8869393621860935));
coeff.add(new PVector(-3.4180941739611423,0.46124778907502073));
coeff.add(new PVector(-0.6303429390956217,-1.3706503875199787));
coeff.add(new PVector(-1.7993441690171408,0.5203067301439572));
coeff.add(new PVector(-0.10633809590535549,0.3349263231860759));
coeff.add(new PVector(-2.7075428480808714,0.317675298890753));
coeff.add(new PVector(0.20670825424913752,-0.7224350138972024));
coeff.add(new PVector(-2.1147640981976465,1.389244094169131));
coeff.add(new PVector(0.3199523778396175,-0.49533689263757863));
coeff.add(new PVector(-0.30442434226317194,0.3249609659725116));
coeff.add(new PVector(0.5653148820270226,0.942060016313446));
coeff.add(new PVector(-1.81560951222641,-1.5534985027170147));
coeff.add(new PVector(-0.6679515132205229,1.7191801270996243));
coeff.add(new PVector(-2.4966199211504745,-0.4219460322759583));
coeff.add(new PVector(-0.9109016507947904,0.6844130702347077));
coeff.add(new PVector(-1.1661827689036302,1.2855427164697375));
coeff.add(new PVector(0.5375569397487998,1.5790540264768778));
coeff.add(new PVector(-0.6321699624704421,0.12568141214444625));
coeff.add(new PVector(-1.0433930192304814,1.6815255909498892));
coeff.add(new PVector(-1.4540323149484595,-0.16343545359433848));
coeff.add(new PVector(-1.676118420582167,0.2989650087457787));
coeff.add(new PVector(-0.8343546234700703,0.652212005657594));
coeff.add(new PVector(-0.2793332329977701,0.9736985558180917));
coeff.add(new PVector(0.5581704948371793,-1.1932421337480856));
coeff.add(new PVector(-1.1447598180402727,2.5481317984705476));
coeff.add(new PVector(-1.0283124282129683,-2.0902022969872216));
coeff.add(new PVector(-2.0338010719430986,1.9663609207429589));
coeff.add(new PVector(-1.067497827530418,-0.4082617940036515));
coeff.add(new PVector(-1.1470015950828063,0.5772045762777364));
coeff.add(new PVector(-0.3802094124518778,-0.5854671958634865));
coeff.add(new PVector(-1.2790112932982942,1.0604425675871187));
coeff.add(new PVector(-1.5457068865294348,-1.4263949855911786));
coeff.add(new PVector(-1.942673426104001,1.161215135017828));
coeff.add(new PVector(-1.6841510022250348,-0.2817022498135621));
coeff.add(new PVector(-1.2801521088840078,-0.6142745038031135));
coeff.add(new PVector(-0.33157141654917416,-0.03625614539122643));
coeff.add(new PVector(-0.4521665183619502,0.16033025686485053));
coeff.add(new PVector(-0.9401600859651061,-1.3511531557455083));
coeff.add(new PVector(-1.0058340661729523,0.9761717431769648));
coeff.add(new PVector(-2.2228358952952654,-0.7818207592701613));
coeff.add(new PVector(-1.019920421261534,-0.39644887124811384));
coeff.add(new PVector(-1.3648144745893795,0.5970522996821634));
coeff.add(new PVector(-0.2550253081810206,0.05695362644831448));
coeff.add(new PVector(-0.7983309400544403,-0.18563802132759405));
coeff.add(new PVector(-0.35481301824085715,0.2831938187968941));
coeff.add(new PVector(-1.9367753148834497,0.1762911941338912));
coeff.add(new PVector(-1.0089274278831437,-0.6685125265706123));
coeff.add(new PVector(-1.543380860573327,1.7838039069786962));
coeff.add(new PVector(-0.3484119958913734,-0.3905118905759177));
coeff.add(new PVector(-0.33744005908551383,0.33205904381682994));
coeff.add(new PVector(0.29144252873484694,0.5078864907312248));
coeff.add(new PVector(-0.4496576369277049,-0.42014606711481095));
coeff.add(new PVector(-0.9995219202157299,0.08971221925436203));
coeff.add(new PVector(-1.1353447393342515,0.8737951029662641));
coeff.add(new PVector(-1.1235635467725127,0.10082912331418911));
coeff.add(new PVector(-0.6220967942888133,0.4437644026490911));
coeff.add(new PVector(0.18302074579549998,0.61079957649705));
coeff.add(new PVector(-0.02120283756253475,-0.44989765602856224));
coeff.add(new PVector(-0.9173042302514868,0.19694825646812122));
coeff.add(new PVector(-0.840796254006888,0.4760797975351223));
coeff.add(new PVector(-1.2502686175448194,-0.43054925774986624));
coeff.add(new PVector(-0.1758147507398488,0.7243751840779178));

int n = coeff.size();
  for (int i = 0; i < n; ++i){
     // coeff.add(new PVector(100f/(1+0.3*i)*0.8414709848078965,100f/(1+0.3*i)*0.45969769413186023));
      col.add(255 - i*255f/(0.4*n));
     // col.add(random(255));
  }
}

float f(float x){
  return 0.66 + 15*pow(0.5*(sin((x-1.9)/1.3) + 1),1.3*1.3);
}

float inc = 0;
float scal = 1;
PVector last = new PVector(0,0);
void arrow(float x1, float y1, float x2, float y2) {
  float nprop = 5.0/100 * dist(x1,y1,x2,y2);
  strokeWeight(nprop);
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  float prop = 1.0/100 * dist(x1,y1,x2,y2);
  rotate(a);
  //println(a);
  //line(0, 0, -12, -16);
  //line(0, 0, 12, -16);

  triangle(0,0,prop*-12,prop*-16,prop*12,prop*-16);
  popMatrix();
  strokeWeight(5);
} 

List<PVector> pts = new ArrayList<>();
void draw(){
  
  List<PVector> vecs = new ArrayList<>();
  inc += 0.005;
  colorMode(HSB);
  background(0);
  translate(width/2,height/2);
  

  PVector head = new PVector(0,0);
  PVector tail = new PVector(0,0);
  vecs.add(tail.copy());
  int m = 0;
  int bruh = 0;
  for (PVector c: coeff){
    float offset = atan2(c.y,c.x);
    float mag = c.mag();
    head = tail.copy();
    tail.add(new PVector(mag*cos(m*inc + offset),-mag*sin(m*inc + offset)));
    vecs.add(tail.copy());
    if (m <= 0)
      m = 1-m;
    else
      m *= -1;
  }
  
  scal = f(inc);
  translate(-scal*tail.x,-scal*tail.y);
  scale(scal);
  image(inputImage,0,0);
  stroke(120,255,255,160);
  for (int i = 0; i < pts.size()-1; ++i){
    PVector p1 = pts.get(i);
    PVector p2 = pts.get(i+1);
    line(p1.x,p1.y,p2.x,p2.y);
  }
  
  for (int i = 0; i < vecs.size()-1; ++i){
    stroke(col.get(bruh),255,255);
    fill(col.get(bruh++),255,255);
    PVector hed = vecs.get(i);
    PVector tal = vecs.get(i+1);
    arrow(hed.x,hed.y,tal.x,tal.y);
  }
  pts.add(new PVector(tail.x,tail.y));
  println(pts.size());
  //stroke(col.get(bruh),255,255);
   // fill(col.get(bruh++),255,255);
    // arrow(head.x,head.y,tail.x,tail.y);
  
  
  
  
  last = tail.copy();
}
