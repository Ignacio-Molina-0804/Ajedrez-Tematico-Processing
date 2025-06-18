# ♟️ Ajedrez Temático en Processing

¡Bienvenido a tu propio ajedrez temático en Processing!  
Este proyecto te permite jugar ajedrez clásico con piezas personalizadas (por ejemplo, de Star Wars), efectos visuales y de sonido, y reglas reales de ajedrez.

---

## 🚀 ¿Cómo jugar?

- **Selecciona una pieza:**  
  Haz clic en una pieza de tu color (según el turno actual).

- **Mueve la pieza:**  
  Haz clic en una de las casillas verdes resaltadas para mover la pieza allí.

- **Captura:**  
  Si mueves tu pieza a una casilla ocupada por una pieza rival, la capturas y sumas una moneda (amarilla para blancas, roja para negras).

- **Turnos:**  
  El turno se alterna automáticamente entre blancas y negras. El turno actual se muestra arriba del tablero.

- **Promoción de peón:**  
  Cuando un peón llega al extremo opuesto, ¡se convierte automáticamente en reina!

- **Enroque:**  
  Puedes enrocar si el rey y la torre no se han movido y no hay piezas entre ellos.

- **Jaque y Jaque Mate:**  
  Si el rey está amenazado, verás "¡Jaque!" en el panel derecho.  
  Si no hay movimientos legales y el rey está en jaque, verás "¡Jaque Mate!" y el juego se detiene.

---

## 🖼️ Interfaz y Visuales

- **Tablero:**  
  8x8, con colores clásicos y zona lateral para información.

- **Resaltado de movimientos:**  
  Las casillas válidas se muestran en verde semitransparente.

- **Rey en jaque:**  
  El rey amenazado se resalta con un borde rojo.

- **Panel derecho:**  
  - Contadores de monedas capturadas por cada bando.
  - Mensajes de turno, jaque y jaque mate.

---

## 📁 Estructura de archivos

```
Ajedrez-Tematico-JavaScript/
│
├── Ajedrez.pde         // Principal: variables y flujo general
├── tablero.pde         // Dibujo del tablero
├── piezas.pde          // Dibujo de piezas y resaltado de rey
├── ui.pde              // Interfaz: contadores, turno, mensajes, resaltado
├── movimiento.pde      // Selección, movimiento y promoción
├── reglas.pde          // Reglas de ajedrez: movimientos, enroque, jaque
└── data/
    ├── piloto.png
    ├── boba.png
    ├── guardia.png
    ├── vader.png
    ├── emperador.png
    ├── storm.png
    ├── yoda.png
    ├── chew.png
    ├── han.png
    ├── kenobi.png
    ├── luke.png
    ├── artu.png
    ├── monedaj.png      // Moneda amarilla (captura blanca)
    ├── monedas.png      // Moneda roja (captura negra)
    └── grito r2.mp3     // Sonido de captura
```

---

## 🛠️ Requisitos

- [Processing](https://processing.org/) instalado.
- Librería [Minim](http://code.compartmental.net/tools/minim/) para sonido  
  (instala desde el gestor de librerías de Processing, necesaria al 100% debido que si no la tienes el programa no funcionara).

---

## ✨ Personalización

- Cambia las imágenes de las piezas en la carpeta `data` y edita el array `piezasNombres` en `Ajedrez.pde`.
- Puedes usar cualquier temática: Star Wars, Marvel, Harry Potter, etc.
- Cambia los sonidos por tus favoritos.

---

## 👨‍💻 Créditos

Desarrollado por Nacho  
Mejorado con ayuda de **GitHub Copilot**

---

¡Disfruta tu ajedrez temático y que la fuerza te acompañe! 🚀
