boolean movimientoValido(int idx, int filaDest, int colDest) {
  int f0 = piezasFila[idx], c0 = piezasCol[idx];
  int tipo = tipoPieza[idx];
  boolean blanca = esBlanca[idx];
  int df = filaDest - f0, dc = colDest - c0;
  if (tipo == 8) {
    int dir = blanca ? -1 : 1;
    if (dc == 0 && df == dir && !hayPiezaEn(filaDest, colDest)) return true;
    if (dc == 0 && df == 2*dir && ((blanca && f0 == 6) || (!blanca && f0 == 1)) && !hayPiezaEn(f0+dir, c0) && !hayPiezaEn(filaDest, colDest)) return true;
    if (abs(dc) == 1 && df == dir && hayPiezaRivalEn(filaDest, colDest, blanca)) return true;
    return false;
  }
  if (tipo == 0) {
    if (f0 == filaDest && c0 != colDest && caminoLibre(f0, c0, filaDest, colDest)) return true;
    if (c0 == colDest && f0 != filaDest && caminoLibre(f0, c0, filaDest, colDest)) return true;
    return false;
  }
  if (tipo == 1) {
    if ((abs(df) == 2 && abs(dc) == 1) || (abs(df) == 1 && abs(dc) == 2)) return true;
    return false;
  }
  if (tipo == 2) {
    if (abs(df) == abs(dc) && caminoLibre(f0, c0, filaDest, colDest)) return true;
    return false;
  }
  if (tipo == 3) {
    if ((f0 == filaDest || c0 == colDest || abs(df) == abs(dc)) && caminoLibre(f0, c0, filaDest, colDest)) return true;
    return false;
  }
  if (tipo == 4) {
    if (!reyMovido[blanca ? 0 : 1] && f0 == filaDest && abs(dc) == 2 && df == 0) {
      if (dc == 2 && !torreMovida[blanca ? 0 : 1][1] &&
          !hayPiezaEn(f0, c0+1) && !hayPiezaEn(f0, c0+2)) return true;
      if (dc == -2 && !torreMovida[blanca ? 0 : 1][0] &&
          !hayPiezaEn(f0, c0-1) && !hayPiezaEn(f0, c0-2) && !hayPiezaEn(f0, c0-3)) return true;
    }
    if (abs(df) <= 1 && abs(dc) <= 1) return true;
    return false;
  }
  return false;
}

boolean hayPiezaEn(int fila, int col) {
  for (int i = 0; i < PIEZAS; i++) {
    if (piezasEstado[i] != 2 && piezasFila[i] == fila && piezasCol[i] == col) return true;
  }
  return false;
}

boolean hayPiezaRivalEn(int fila, int col, boolean blanca) {
  for (int i = 0; i < PIEZAS; i++) {
    if (piezasEstado[i] != 2 && piezasFila[i] == fila && piezasCol[i] == col && esBlanca[i] != blanca) return true;
  }
  return false;
}

boolean caminoLibre(int f0, int c0, int f1, int c1) {
  int df = Integer.signum(f1 - f0);
  int dc = Integer.signum(c1 - c0);
  int pasos = max(abs(f1 - f0), abs(c1 - c0));
  for (int i = 1; i < pasos; i++) {
    int ff = f0 + df * i;
    int cc = c0 + dc * i;
    if (hayPiezaEn(ff, cc)) return false;
  }
  return true;
}

boolean reyEnJaque(boolean blancas) {
  int reyIdx = -1;
  for (int i = 0; i < PIEZAS; i++) {
    if (tipoPieza[i] == 4 && esBlanca[i] == blancas && piezasEstado[i] == 0) {
      reyIdx = i;
      break;
    }
  }
  if (reyIdx == -1) return false;
  int rf = piezasFila[reyIdx], rc = piezasCol[reyIdx];
  for (int i = 0; i < PIEZAS; i++) {
    if (esBlanca[i] != blancas && piezasEstado[i] == 0) {
      if (movimientoValido(i, rf, rc)) return true;
    }
  }
  return false;
}

boolean hayJaqueMate(boolean blancas) {
  if (!reyEnJaque(blancas)) return false;
  for (int i = 0; i < PIEZAS; i++) {
    if (esBlanca[i] == blancas && piezasEstado[i] == 0) {
      int f0 = piezasFila[i], c0 = piezasCol[i];
      for (int f = 0; f < N; f++) for (int c = 0; c < N; c++) {
        if (movimientoValido(i, f, c)) {
          int oldF = piezasFila[i], oldC = piezasCol[i];
          int capturada = -1;
          for (int j = 0; j < PIEZAS; j++) {
            if (j != i && piezasEstado[j] == 0 && piezasFila[j] == f && piezasCol[j] == c && esBlanca[j] != blancas) {
              capturada = j;
              piezasEstado[j] = 2;
              break;
            }
          }
          piezasFila[i] = f; piezasCol[i] = c;
          boolean enJaque = reyEnJaque(blancas);
          piezasFila[i] = oldF; piezasCol[i] = oldC;
          if (capturada != -1) piezasEstado[capturada] = 0;
          if (!enJaque) return false;
        }
      }
    }
  }
  return true;
}