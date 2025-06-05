import ddf.minim.*;

Minim soundengine;
AudioSample sonido1;

final int N = 8; // Tamaño del tablero
final int PIEZAS = 32;

PImage[] piezasImg = new PImage[PIEZAS];
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

int[] tipoPieza = {
  0,1,2,3,4,2,1,0, 8,8,8,8,8,8,8,8,
  0,1,2,3,4,2,1,0, 8,8,8,8,8,8,8,8
};
boolean[] esBlanca = {
  false,false,false,false,false,false,false,false, false,false,false,false,false,false,false,false,
  true,true,true,true,true,true,true,true, true,true,true,true,true,true,true,true
};

int[] piezasFila = new int[PIEZAS];
int[] piezasCol = new int[PIEZAS];
int[] piezasEstado = new int[PIEZAS]; // 0=normal, 1=seleccionada, 2=capturada

int seleccionada = -1; // Índice de la pieza seleccionada
boolean turnoBlancas = true;

int contadorNegras = 0;
int contadorBlancas = 0;

ArrayList<PVector> casillasValidas = new ArrayList<PVector>();

boolean[] reyMovido = {false, false}; // [blancas, negras]
boolean[][] torreMovida = {{false, false}, {false, false}}; // [blancas/0-negras][izq/der]

boolean finDePartida = false;

void setup() {
  size(600, 400);
  for (int i = 0; i < PIEZAS; i++) piezasImg[i] = loadImage(piezasNombres[i]);
  for (int i = 0; i < 8; i++) {
    piezasFila[i] = 0; piezasCol[i] = i;
    piezasFila[i+8] = 1; piezasCol[i+8] = i;
    piezasFila[i+16] = 7; piezasCol[i+16] = i;
    piezasFila[i+24] = 6; piezasCol[i+24] = i;
    piezasEstado[i] = 0;
    piezasEstado[i+8] = 0;
    piezasEstado[i+16] = 0;
    piezasEstado[i+24] = 0;
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
    // Seleccionar pieza propia
    for (int i = 0; i < PIEZAS; i++) {
      if (piezasEstado[i] == 0 && piezasCol[i] == col && piezasFila[i] == fila && esBlanca[i] == turnoBlancas) {
        seleccionada = i;
        piezasEstado[i] = 1;
        calcularCasillasValidas(i);
        break;
      }
    }
  } else {
    // Intentar mover
    if (moverPieza(seleccionada, fila, col)) {
      turnoBlancas = !turnoBlancas;
      piezasEstado[seleccionada] = 0;
      seleccionada = -1;
      casillasValidas.clear();
      if (hayJaqueMate(turnoBlancas)) finDePartida = true;
    }
    else {
      piezasEstado[seleccionada] = 0;
      seleccionada = -1;
      casillasValidas.clear();
    }
  }
}