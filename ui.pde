void mostrarContadores() {
  fill(255,0,0);
  textSize(24);
  text("Negras: " + contadorNegras, 420, 380);
  fill(255,204,0);
  text("Blancas: " + contadorBlancas, 420, 350);
}

void mostrarTurno() {
  textSize(28);
  textAlign(CENTER, CENTER);
  if (turnoBlancas) {
    fill(255, 204, 0);
    text("Turno: Blancas", 500, 20);
  } else {
    fill(255, 0, 0);
    text("Turno: Negras", 500, 20);
  }
  textAlign(LEFT, BASELINE);
}

void resaltarCasillasValidas() {
  noStroke();
  fill(0, 255, 0, 100);
  for (PVector casilla : casillasValidas) {
    rect(casilla.x * 50, casilla.y * 50, 50, 50);
  }
}

void mostrarJaqueYMate() {
  textSize(32);
  textAlign(LEFT, CENTER);
  if (finDePartida) {
    fill(255, 0, 0);
    text("¡Jaque Mate!", 420, 200); // Costado derecho
  } else if (reyEnJaque(turnoBlancas)) {
    fill(255, 0, 0);
    text("¡Jaque!", 420, 160); // Costado derecho
  }
  textAlign(LEFT, BASELINE);
}