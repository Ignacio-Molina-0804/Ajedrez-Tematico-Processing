boolean movimientoValido(int idx, int filaDest, int colDest) {
  Pieza p = piezas.get(idx);
  int f0 = p.fila, c0 = p.col;
  int tipo = p.tipo;
  boolean blanca = p.blanca;
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
  for (int i = 0; i < piezas.size(); i++) {
    Pieza p = piezas.get(i);
    if (p.estado != 2 && p.fila == fila && p.col == col) return true;
  }
  return false;
}

boolean hayPiezaRivalEn(int fila, int col, boolean blanca) {
  for (int i = 0; i < piezas.size(); i++) {
    Pieza p = piezas.get(i);
    if (p.estado != 2 && p.fila == fila && p.col == col && p.blanca != blanca) return true;
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
  for (int i = 0; i < piezas.size(); i++) {
    Pieza p = piezas.get(i);
    if (p.tipo == 4 && p.blanca == blancas && p.estado != 2) {
      reyIdx = i;
      break;
    }
  }
  if (reyIdx == -1) return false;
  int rf = piezas.get(reyIdx).fila, rc = piezas.get(reyIdx).col;
  for (int i = 0; i < piezas.size(); i++) {
    Pieza p = piezas.get(i);
    if (p.blanca != blancas && p.estado != 2 && p.puedeMoverA(rf, rc, piezas)) {
      return true;
    }
  }
  return false;
}

boolean hayJaqueMate(boolean blancas) {
  if (!reyEnJaque(blancas)) return false;
  for (int i = 0; i < piezas.size(); i++) {
    Pieza p = piezas.get(i);
    if (p.blanca == blancas && p.estado != 2) {
      int f0 = p.fila, c0 = p.col;
      for (int f = 0; f < N; f++) {
        for (int c = 0; c < N; c++) {
          if (p.puedeMoverA(f, c, piezas)) {
            // Simular el movimiento
            int oldFila = p.fila, oldCol = p.col;
            int oldEstado = p.estado;
            int capturada = -1;
            for (int j = 0; j < piezas.size(); j++) {
              Pieza otra = piezas.get(j);
              if (otra.estado != 2 && otra.fila == f && otra.col == c && otra.blanca != p.blanca) {
                capturada = j;
                break;
              }
            }
            int oldEstadoCapturada = -1;
            if (capturada != -1) {
              oldEstadoCapturada = piezas.get(capturada).estado;
              piezas.get(capturada).estado = 2;
            }
            p.fila = f; p.col = c;
            boolean jaque = reyEnJaque(blancas);
            // Deshacer simulación
            p.fila = oldFila; p.col = oldCol; p.estado = oldEstado;
            if (capturada != -1) {
              piezas.get(capturada).estado = oldEstadoCapturada;
            }
            if (!jaque) return false;
          }
        }
      }
    }
  }
  return true;
}