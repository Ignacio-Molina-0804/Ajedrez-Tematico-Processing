void calcularCasillasValidas(int idx) {
  casillasValidas.clear();
  Pieza p = piezas.get(idx);
  for (int f = 0; f < N; f++) {
    for (int c = 0; c < N; c++) {
      boolean propia = false;
      for (int i = 0; i < piezas.size(); i++) {
        Pieza otra = piezas.get(i);
        if (i != idx && otra.estado != 2 && otra.fila == f && otra.col == c && otra.blanca == p.blanca) {
          propia = true;
          break;
        }
      }
      if (!propia && p.puedeMoverA(f, c, piezas)) {
        casillasValidas.add(new PVector(c, f));
      }
    }
  }
}

boolean moverPieza(int idx, int filaDest, int colDest) {
  Pieza p = piezas.get(idx);
  if (filaDest < 0 || filaDest >= N || colDest < 0 || colDest >= N) return false;
  if (p.fila == filaDest && p.col == colDest) return false;
  for (int i = 0; i < piezas.size(); i++) {
    Pieza otra = piezas.get(i);
    if (i != idx && otra.estado != 2 && otra.fila == filaDest && otra.col == colDest && otra.blanca == p.blanca) {
      return false;
    }
  }
  int capturada = -1;
  for (int i = 0; i < piezas.size(); i++) {
    Pieza otra = piezas.get(i);
    if (i != idx && otra.estado != 2 && otra.fila == filaDest && otra.col == colDest && otra.blanca != p.blanca) {
      capturada = i;
      break;
    }
  }
  if (!p.puedeMoverA(filaDest, colDest, piezas)) return false;

  // Enroque
  if (p.tipo == 4 && abs(colDest - p.col) == 2 && filaDest == p.fila) {
    int fila = p.fila;
    if (colDest == 6) {
      for (int i = 0; i < piezas.size(); i++) {
        Pieza t = piezas.get(i);
        if (t.tipo == 0 && t.fila == fila && t.col == 7 && t.estado != 2 && t.blanca == p.blanca) {
          t.col = 5;
          break;
        }
      }
    }
    if (colDest == 2) {
      for (int i = 0; i < piezas.size(); i++) {
        Pieza t = piezas.get(i);
        if (t.tipo == 0 && t.fila == fila && t.col == 0 && t.estado != 2 && t.blanca == p.blanca) {
          t.col = 3;
          break;
        }
      }
    }
    reyMovido[p.blanca ? 0 : 1] = true;
  }
  if (p.tipo == 4) reyMovido[p.blanca ? 0 : 1] = true;
  if (p.tipo == 0) {
    if (p.col == 0) torreMovida[p.blanca ? 0 : 1][0] = true;
    if (p.col == 7) torreMovida[p.blanca ? 0 : 1][1] = true;
  }

  if (capturada != -1) {
    Pieza cap = piezas.get(capturada);
    cap.estado = 2;
    cap.col = 420/50 + (capturada % 4);
    cap.fila = 0 + (capturada / 4);
    if (p.blanca) {
      contadorBlancas++;
    } else {
      contadorNegras++;
    }
    sonido1.trigger();
  }
  p.moverA(filaDest, colDest);

  // Promoción de peón
  if (p.tipo == 8) {
    if ((p.blanca && filaDest == 0) || (!p.blanca && filaDest == 7)) {
      p.tipo = 4; // Promociona a reina (puedes cambiar el tipo si tienes otro valor para reina)
      p.img = loadImage("emperador.png"); // Cambia la imagen por la de la reina
    }
  }
  return true;
}