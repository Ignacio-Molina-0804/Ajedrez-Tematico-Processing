void tablero() {
  for (int f = 0; f < N; f++) {
    for (int c = 0; c < N; c++) {
      if ((f + c) % 2 == 0) fill(255);
      else fill(0);
      rect(c * 50, f * 50, 50, 50);
    }
  }
  fill(30, 60, 120);
  rect(400, 0, 200, 400);
}