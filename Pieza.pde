class Pieza {
  int tipo;         // 0=torre, 1=..., 8=peón
  boolean blanca;
  int fila, col;
  int estado;       // 0=normal, 1=seleccionada, 2=capturada
  PImage img;

  Pieza(int tipo, boolean blanca, int fila, int col, PImage img) {
    this.tipo = tipo;
    this.blanca = blanca;
    this.fila = fila;
    this.col = col;
    this.estado = 0;
    this.img = img;
  }

  void dibujar() {
    if (estado != 2) {
      image(img, col * 50, fila * 50, 50, 50);
    }
  }
}