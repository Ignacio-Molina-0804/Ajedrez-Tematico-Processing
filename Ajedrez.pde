import ddf.minim.*;

Minim soundengine;
AudioSample sonido1;

int a=0;
int b=0;
//jedi
PImage luke; //rey
PImage kenobi; //reina 
PImage r21; //peon
PImage r22;
PImage r23;
PImage r24;
PImage r25;
PImage r26;
PImage r27;
PImage r28;
PImage chew1; //caballo
PImage chew2;
PImage han1; //alfil
PImage han2; 
PImage yoda1; //torre
PImage yoda2;
//sith
PImage emp; //rey 
PImage vader; //reina
PImage storm1; //peon
PImage storm2;
PImage storm3;
PImage storm4;
PImage storm5;
PImage storm6;
PImage storm7;
PImage storm8;
PImage boba1; //caballo
PImage boba2;
PImage guardia1; //alfil
PImage guardia2;
PImage piloto1; //torre
PImage piloto2;

void setup(){
 size(600,400);
 luke= loadImage("luke.png");
 kenobi= loadImage("kenobi.png");
 r21= loadImage("artu.png");
 r22= loadImage("artu.png");
 r23= loadImage("artu.png");
 r24= loadImage("artu.png");
 r25= loadImage("artu.png");
 r26= loadImage("artu.png");
 r27= loadImage("artu.png");
 r28= loadImage("artu.png");
 chew1= loadImage("chew.png");
 chew2= loadImage("chew.png");
 han1= loadImage("han.png");
 han2= loadImage("han.png");
 yoda1= loadImage("yoda.png");
 yoda2= loadImage("yoda.png");
 emp= loadImage("emperador.png");
 vader= loadImage("vader.png");
 storm1= loadImage("storm.png");
 storm2= loadImage("storm.png");
 storm3= loadImage("storm.png");
 storm4= loadImage("storm.png");
 storm5= loadImage("storm.png");
 storm6= loadImage("storm.png");
 storm7= loadImage("storm.png");
 storm8= loadImage("storm.png");
 boba1= loadImage("boba.png");
 boba2= loadImage("boba.png");
 guardia1= loadImage("guardia.png");
 guardia2= loadImage("guardia.png");
 piloto1= loadImage("piloto.png");
 piloto2= loadImage("piloto.png");
  
  soundengine = new Minim(this);
  sonido1 = soundengine.loadSample("grito r2.mp3", 1024);
 


}

void draw(){
  tablero();
   piezas();
  movimiento();
 comerj();
 comers();
  
}
