import ddf.minim.*;

Minim soundengine;
AudioSample sonido1;

final int N = 8;
final int PIEZAS = 32;

ArrayList<Pieza> piezas = new ArrayList<Pieza>();
String[] piezasNombres = {
  // Negras mayores
  "piloto.png", "boba.png", "guardia.png", "vader.png", "emperador.png", "guardia.png", "boba.png", "piloto.png",
  // Peones negros
  "storm.png", "storm.png", "storm.png", "storm.png", "storm.png", "storm.png", "storm.png", "storm.png",
  // Blancas mayores
  "yoda.png", "chew.png", "han.png", "kenobi.png", "luke.png", "han.png", "chew.png", "yoda.png",
  // Peones blancos
  "artu.png", "artu.png", "artu.png", "artu.png", "artu.png", "artu.png", "artu.png", "artu.png"
};
int[] tipoPiezaArr = {
  0,1,2,3,4,2,1,0, 8,8,8,8,8,8,8,8,
  0,1,2,3,4,2,1,0, 8,8,8,8,8,8,8,8
};
boolean[] esBlancaArr = {
  false,false,false,false,false,false,false,false, false,false,false,false,false,false,false,false,
  true,true,true,true,true,true,true,true, true,true,true,true,true,true,true,true
};

int seleccionada = -1;
boolean turnoBlancas = true;

int contadorNegras = 0;
int contadorBlancas = 0;

ArrayList<PVector> casillasValidas = new ArrayList<PVector>();

boolean[] reyMovido = {false, false};
boolean[][] torreMovida = {{false, false}, {false, false}};

boolean finDePartida = false;

void setup() {
  size(600, 400);
  for (int i = 0; i < PIEZAS; i++) {
    int fila = (i < 8) ? 0 : (i < 16) ? 1 : (i < 24) ? 7 : 6;
    int col = i % 8;
    PImage img = loadImage(piezasNombres[i]);
    piezas.add(new Pieza(tipoPiezaArr[i], esBlancaArr[i], fila, col, img));
  }
  soundengine = new Minim(this);
  sonido1 = soundengine.loadSample("grito r2.mp3", 1024);
}

void draw() {
  background(200);
  tablero();
  resaltarCasillasValidas();
  dibujarPiezas();
  mostrarContadores();
  mostrarTurno();
  mostrarJaqueYMate();
}

void mousePressed() {
  if (finDePartida) return;
  int col = mouseX / 50;
  int fila = mouseY / 50;
  if (col < 0 || col >= N || fila < 0 || fila >= N) return;
  if (seleccionada == -1) {
    for (int i = 0; i < piezas.size(); i++) {
      Pieza p = piezas.get(i);
      if (p.estado == 0 && p.col == col && p.fila == fila && p.blanca == turnoBlancas) {
        seleccionada = i;
        p.estado = 1;
        calcularCasillasValidas(i);
        break;
      }
    }
  } else {
    if (moverPieza(seleccionada, fila, col)) {
      turnoBlancas = !turnoBlancas;
      piezas.get(seleccionada).estado = 0;
      seleccionada = -1;
      casillasValidas.clear();
      if (hayJaqueMate(turnoBlancas)) finDePartida = true;
    } else {
      piezas.get(seleccionada).estado = 0;
      seleccionada = -1;
      casillasValidas.clear();
    }
  }
}