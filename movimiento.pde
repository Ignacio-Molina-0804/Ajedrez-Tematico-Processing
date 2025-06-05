void calcularCasillasValidas(int idx) {
  casillasValidas.clear();
  for (int f = 0; f < N; f++) {
    for (int c = 0; c < N; c++) {
      boolean propia = false;
      for (int i = 0; i < PIEZAS; i++) {
        if (i != idx && piezasEstado[i] != 2 && piezasFila[i] == f && piezasCol[i] == c && esBlanca[i] == esBlanca[idx]) {
          propia = true;
          break;
        }
      }
      if (!propia && movimientoValido(idx, f, c)) {
        int oldF = piezasFila[idx], oldC = piezasCol[idx];
        int capturada = -1;
        for (int j = 0; j < PIEZAS; j++) {
          if (j != idx && piezasEstado[j] == 0 && piezasFila[j] == f && piezasCol[j] == c && esBlanca[j] != esBlanca[idx]) {
            capturada = j;
            piezasEstado[j] = 2;
            break;
          }
        }
        piezasFila[idx] = f; piezasCol[idx] = c;
        boolean enJaque = reyEnJaque(esBlanca[idx]);
        piezasFila[idx] = oldF; piezasCol[idx] = oldC;
        if (capturada != -1) piezasEstado[capturada] = 0;
        if (!enJaque) casillasValidas.add(new PVector(c, f));
      }
    }
  }
}

boolean moverPieza(int idx, int filaDest, int colDest) {
  // No mover fuera del tablero
  if (filaDest < 0 || filaDest >= N || colDest < 0 || colDest >= N) return false;
  // No mover a la misma casilla
  if (piezasFila[idx] == filaDest && piezasCol[idx] == colDest) return false;
  // No mover a casilla propia
  for (int i = 0; i < PIEZAS; i++) {
    if (i != idx && piezasEstado[i] != 2 && piezasFila[i] == filaDest && piezasCol[i] == colDest && esBlanca[i] == esBlanca[idx]) {
      return false;
    }
  }
  int capturada = -1;
  for (int i = 0; i < PIEZAS; i++) {
    if (i != idx && piezasEstado[i] != 2 && piezasFila[i] == filaDest && piezasCol[i] == colDest && esBlanca[i] != esBlanca[idx]) {
      capturada = i;
      break;
    }
  }
  if (!movimientoValido(idx, filaDest, colDest)) return false;

  // Enroque
  if (tipoPieza[idx] == 4 && abs(colDest - piezasCol[idx]) == 2 && filaDest == piezasFila[idx]) {
    int fila = piezasFila[idx];
    if (colDest == 6) {
      for (int i = 0; i < PIEZAS; i++) {
        if (tipoPieza[i] == 0 && piezasCol[i] == 7 && piezasFila[i] == fila && piezasEstado[i] == 0 && esBlanca[i] == esBlanca[idx]) {
          piezasCol[i] = 5;
          break;
        }
      }
      torreMovida[esBlanca[idx] ? 0 : 1][1] = true;
    }
    if (colDest == 2) {
      for (int i = 0; i < PIEZAS; i++) {
        if (tipoPieza[i] == 0 && piezasCol[i] == 0 && piezasFila[i] == fila && piezasEstado[i] == 0 && esBlanca[i] == esBlanca[idx]) {
          piezasCol[i] = 3;
          break;
        }
      }
      torreMovida[esBlanca[idx] ? 0 : 1][0] = true;
    }
    reyMovido[esBlanca[idx] ? 0 : 1] = true;
  }
  if (tipoPieza[idx] == 4) reyMovido[esBlanca[idx] ? 0 : 1] = true;
  if (tipoPieza[idx] == 0) {
    if (piezasCol[idx] == 0) torreMovida[esBlanca[idx] ? 0 : 1][0] = true;
    if (piezasCol[idx] == 7) torreMovida[esBlanca[idx] ? 0 : 1][1] = true;
  }

  if (capturada != -1) {
    piezasEstado[capturada] = 2;
    piezasCol[capturada] = 420/50 + (capturada % 4);
    piezasFila[capturada] = 0 + (capturada / 4);
    if (esBlanca[idx]) {
      piezasImg[capturada] = loadImage("monedaj.png");
      contadorBlancas++;
    } else {
      piezasImg[capturada] = loadImage("monedas.png");
      contadorNegras++;
    }
    sonido1.trigger();
  }
  piezasFila[idx] = filaDest;
  piezasCol[idx] = colDest;

  // Promoción de peón
  if (tipoPieza[idx] == 8) {
    if ((esBlanca[idx] && filaDest == 0) || (!esBlanca[idx] && filaDest == 7)) {
      tipoPieza[idx] = 3;
      if (esBlanca[idx]) {
        piezasImg[idx] = loadImage("luke.png");
      } else {
        piezasImg[idx] = loadImage("emperador.png");
      }
    }
  }
  return true;
}