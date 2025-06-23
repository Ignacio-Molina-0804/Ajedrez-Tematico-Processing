import ddf.minim.*;

Minim soundengine;
AudioSample sonido1;

final int N = 8;
final int PIEZAS = 32;

ArrayList<Pieza> piezas = new ArrayList<Pieza>();

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
  // Negras mayores
  piezas.add(new Pieza(0, false, 0, 0, loadImage("piloto.png")));
  piezas.add(new Pieza(1, false, 0, 1, loadImage("boba.png")));
  piezas.add(new Pieza(2, false, 0, 2, loadImage("guardia.png")));
  piezas.add(new Pieza(3, false, 0, 3, loadImage("vader.png")));
  piezas.add(new Pieza(4, false, 0, 4, loadImage("emperador.png")));
  piezas.add(new Pieza(2, false, 0, 5, loadImage("guardia.png")));
  piezas.add(new Pieza(1, false, 0, 6, loadImage("boba.png")));
  piezas.add(new Pieza(0, false, 0, 7, loadImage("piloto.png")));
  // Peones negros
  for (int i = 0; i < 8; i++) piezas.add(new Pieza(8, false, 1, i, loadImage("storm.png")));
  // Blancas mayores
  piezas.add(new Pieza(0, true, 7, 0, loadImage("yoda.png")));
  piezas.add(new Pieza(1, true, 7, 1, loadImage("chew.png")));
  piezas.add(new Pieza(2, true, 7, 2, loadImage("han.png")));
  piezas.add(new Pieza(3, true, 7, 3, loadImage("kenobi.png")));
  piezas.add(new Pieza(4, true, 7, 4, loadImage("luke.png")));
  piezas.add(new Pieza(2, true, 7, 5, loadImage("han.png")));
  piezas.add(new Pieza(1, true, 7, 6, loadImage("chew.png")));
  piezas.add(new Pieza(0, true, 7, 7, loadImage("yoda.png")));
  // Peones blancos
  for (int i = 0; i < 8; i++) piezas.add(new Pieza(8, true, 6, i, loadImage("artu.png")));

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