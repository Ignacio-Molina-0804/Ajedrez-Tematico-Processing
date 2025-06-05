void dibujarPiezas() {
  for (int i = 0; i < PIEZAS; i++) {
    if (piezasEstado[i] != 2) {
      float x = piezasCol[i] * 50;
      float y = piezasFila[i] * 50;
      // Resalta el rey en jaque
      if (tipoPieza[i] == 4 && reyEnJaque(esBlanca[i])) {
        stroke(255,0,0);
        strokeWeight(4);
        noFill();
        rect(x+2, y+2, 46, 46);
        noStroke();
      }
      if (piezasEstado[i] == 1) {
        stroke(0, 200, 255);
        strokeWeight(3);
        noFill();
        rect(x+3, y+3, 44, 44);
        noStroke();
      }
      image(piezasImg[i], x, y, 50, 50);
    }
  }
}