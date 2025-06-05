import ddf.minim.*;

Minim soundengine;
AudioSample sonido1;

// Arrays para piezas
PImage[] piezasImg = new PImage[32];
float[] piezasX = new float[32];
float[] piezasY = new float[32];
int[] piezasEstado = new int[32]; // 0 = seleccionable, 1 = bloqueada, 2 = capturada

// Nombres de imágenes en orden de piezas
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

int contadorNegras = 0; // Contador de monedas rojas para piezas negras
int contadorBlancas = 0; // Contador de monedas amarillas para piezas blancas

void setup() {
  size(600, 400);
  // Cargar imágenes
  for (int i = 0; i < piezasImg.length; i++) {
    piezasImg[i] = loadImage(piezasNombres[i]);
  }
  // Posiciones iniciales
  float[] xInit = {
    0,50,100,150,200,250,300,350, 0,50,100,150,200,250,300,350,
    0,50,100,150,200,250,300,350, 0,50,100,150,200,250,300,350
  };
  float[] yInit = {
    0,0,0,0,0,0,0,0, 50,50,50,50,50,50,50,50,
    350,350,350,350,350,350,350,350, 300,300,300,300,300,300,300,300
  };
  for (int i = 0; i < piezasX.length; i++) {
    piezasX[i] = xInit[i];
    piezasY[i] = yInit[i];
    piezasEstado[i] = 0;
  }
  // Sonido
  soundengine = new Minim(this);
  sonido1 = soundengine.loadSample("grito r2.mp3", 1024);
}

void draw() {
  tablero();
  dibujarPiezas();
  moverPiezas();
  capturarPiezas();
}

// Dibuja el tablero
void tablero() {
  for (int a = 0; a < 8; a++) {
    for (int b = 0; b < 8; b++) {
      if ((a + b) % 2 == 0) fill(255);
      else fill(0);
      rect(b * 50, a * 50, 50, 50);
    }
  }
  fill(#AFAAAA);
  rect(400, 0, 200, 400);
}

// Dibuja todas las piezas
void dibujarPiezas() {
  for (int i = 0; i < piezasImg.length; i++) {
    image(piezasImg[i], piezasX[i], piezasY[i], 50, 50);
  }
}

// Movimiento de piezas con mouse
void moverPiezas() {
  if (!mousePressed) {
    for (int i = 0; i < piezasEstado.length; i++) piezasEstado[i] = 0;
  }
  for (int i = 0; i < piezasX.length; i++) {
    if (piezasEstado[i] == 0 && mousePressed &&
        mouseX > piezasX[i] && mouseX < piezasX[i] + 50 &&
        mouseY > piezasY[i] && mouseY < piezasY[i] + 50) {
      piezasX[i] = mouseX - 25;
      piezasY[i] = mouseY - 25;
      for (int j = 0; j < piezasEstado.length; j++) if (j != i) piezasEstado[j] = 1;
    }
  }
}

// Lógica básica de captura (puedes mejorarla según tus reglas)
void capturarPiezas() {
  for (int i = 0; i < piezasX.length; i++) {
    for (int j = 0; j < piezasX.length; j++) {
      if (i != j && piezasEstado[i] == 0 && piezasEstado[j] == 1 &&
          dist(piezasX[i], piezasY[i], piezasX[j], piezasY[j]) < 40) {
        // Blancas (16-31) solo pueden comer negras (0-15)
        if (i >= 16 && j < 16) {
          piezasX[j] = 420 + (j % 4) * 40;
          piezasY[j] = 20 + (j / 4) * 40;
          piezasImg[j] = loadImage("monedaj.png"); // moneda amarilla
          sonido1.trigger();
          piezasEstado[j] = 2;
          contadorBlancas++; // Suma al contador de blancas
        }
        // Negras (0-15) solo pueden comer blancas (16-31)
        else if (i < 16 && j >= 16) {
          piezasX[j] = 420 + (j % 4) * 40;
          piezasY[j] = 20 + (j / 4) * 40;
          piezasImg[j] = loadImage("monedas.png"); // moneda roja
          sonido1.trigger();
          piezasEstado[j] = 2;
          contadorNegras++; // Suma al contador de negras
        }
      }
    }
  }
  // Mostrar los contadores en pantalla
  fill(255,0,0);
  textSize(24);
  text("Negras: " + contadorNegras, 420, 380);
  fill(255, 204, 0);
  text("Blancas: " + contadorBlancas, 420, 350);
}