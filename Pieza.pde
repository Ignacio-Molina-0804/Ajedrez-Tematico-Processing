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

  void moverA(int nuevaFila, int nuevaCol) {
    this.fila = nuevaFila;
    this.col = nuevaCol;
  }

  // Devuelve true si la pieza puede moverse a la posición dada (sin validar jaque)
  boolean puedeMoverA(int filaDest, int colDest, ArrayList<Pieza> piezas) {
    int df = filaDest - fila;
    int dc = colDest - col;
    switch (tipo) {
      case 0: // Torre
        return (fila == filaDest || col == colDest) && caminoLibre(fila, col, filaDest, colDest, piezas);
      case 1: // Caballo
        return (abs(df) == 2 && abs(dc) == 1) || (abs(df) == 1 && abs(dc) == 2);
      case 2: // Alfil
        return abs(df) == abs(dc) && caminoLibre(fila, col, filaDest, colDest, piezas);
      case 3: // Reina
        return ((fila == filaDest || col == colDest) || (abs(df) == abs(dc))) && caminoLibre(fila, col, filaDest, colDest, piezas);
      case 4: // Rey
        return max(abs(df), abs(dc)) == 1;
      case 8: // Peón
        int dir = blanca ? -1 : 1;
        if (dc == 0 && df == dir && !hayPiezaEn(filaDest, colDest, piezas)) return true;
        if (dc == 0 && df == 2*dir && ((blanca && fila == 6) || (!blanca && fila == 1)) &&
            !hayPiezaEn(fila + dir, col, piezas) && !hayPiezaEn(filaDest, colDest, piezas)) return true;
        if (abs(dc) == 1 && df == dir && hayPiezaRivalEn(filaDest, colDest, blanca, piezas)) return true;
        break;
    }
    return false;
  }

  // Métodos auxiliares para movimiento
  boolean hayPiezaEn(int fila, int col, ArrayList<Pieza> piezas) {
    for (Pieza p : piezas) {
      if (p.estado != 2 && p.fila == fila && p.col == col) return true;
    }
    return false;
  }

  boolean hayPiezaRivalEn(int fila, int col, boolean soyBlanca, ArrayList<Pieza> piezas) {
    for (Pieza p : piezas) {
      if (p.estado != 2 && p.fila == fila && p.col == col && p.blanca != soyBlanca) return true;
    }
    return false;
  }

  boolean caminoLibre(int f0, int c0, int f1, int c1, ArrayList<Pieza> piezas) {
    int df = Integer.signum(f1 - f0);
    int dc = Integer.signum(c1 - c0);
    int pasos = max(abs(f1 - f0), abs(c1 - c0));
    for (int i = 1; i < pasos; i++) {
      int ff = f0 + df * i;
      int cc = c0 + dc * i;
      if (hayPiezaEn(ff, cc, piezas)) return false;
    }
    return true;
  }
}