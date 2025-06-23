void dibujarPiezas() {
  for (int i = 0; i < piezas.size(); i++) {
    Pieza p = piezas.get(i);
    if (p.estado != 2) {
      float x = p.col * 50;
      float y = p.fila * 50;
      // Resalta el rey en jaque
      if (p.tipo == 4 && reyEnJaque(p.blanca)) {
        stroke(255,0,0);
        strokeWeight(4);
        noFill();
        rect(x+2, y+2, 46, 46);
        noStroke();
      }
      if (p.estado == 1) {
        stroke(0, 200, 255);
        strokeWeight(3);
        noFill();
        rect(x+3, y+3, 44, 44);
        noStroke();
      }
      p.dibujar();
    }
  }
}