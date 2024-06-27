import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:gto/config/config.dart';
import 'package:gto/widget/celda.dart';

class Controles extends StatefulWidget {
  const Controles({super.key});

  @override
  State<Controles> createState() => ControlesState();
}

class ControlesState extends State<Controles> {
  estados inicial = estados.cruz;
  int contador = 0;
  bool juegoTerminado = false;

  @override
  Widget build(BuildContext context) {
    double ancho, alto;
    ancho = MediaQuery.of(context).size.width;
    alto = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          width: ancho,
          height: ancho,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Celda(inicial: tablero[0], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(0)),
                    Celda(inicial: tablero[1], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(1)),
                    Celda(inicial: tablero[2], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(2))
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Celda(inicial: tablero[3], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(3)),
                    Celda(inicial: tablero[4], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(4)),
                    Celda(inicial: tablero[5], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(5))
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Celda(inicial: tablero[6], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(6)),
                    Celda(inicial: tablero[7], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(7)),
                    Celda(inicial: tablero[8], alto: ancho / 3, ancho: ancho / 3, press: () => pressi(8))
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Victorias Cruz: $victoriasCruz"),
              Text("Victorias Círculo: $victoriasCirculo"),
              Text("Empates: $empates"),
            ],
          ),
        ),
      ],
    );
  }

  void pressi(int index) {
    if (juegoTerminado) return; // No permitir más movimientos si el juego terminó

    debugPrint("Presionado");
    if (tablero[index] == estados.vacio) {
      tablero[index] = inicial;
      inicial = inicial == estados.cruz ? estados.circulo : estados.cruz;
      setState(() {});

      if (++contador >= 5) {
        // Verificar si alguien ganó
        if (verificarGanador()) {
          juegoTerminado = true;
          String ganador = inicial == estados.cruz ? "Círculo" : "Cruz";
          if (ganador == "Cruz") {
            victoriasCruz++;
          } else {
            victoriasCirculo++;
          }
          mostrarDialogoGanador("Ganador: $ganador");
        } else if (contador == 9) {
          // Verificar si fue empate
          juegoTerminado = true;
          empates++;
          mostrarDialogoGanador("Empate");
        }
      }
    }
  }

  bool verificarGanador() {
    // Filas
    for (int i = 0; i < tablero.length; i += 3) {
      if (Iguales(i, i + 1, i + 2)) return true;
    }
    // Columnas
    for (int i = 0; i < 3; i++) {
      if (Iguales(i, i + 3, i + 6)) return true;
    }
    // Diagonales
    if (Iguales(0, 4, 8)) return true;
    if (Iguales(2, 4, 6)) return true;

    return false;
  }

  bool Iguales(int a, int b, int c) {
    if (tablero[a] != estados.vacio && tablero[a] == tablero[b] && tablero[b] == tablero[c]) {
      resultados[tablero[a]] = true;
      return true;
    }
    return false;
  }

  void mostrarDialogoGanador(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Juego Terminado"),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text("Continuar"),
              onPressed: () {
                reiniciarJuego();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Salir"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Cerrar la aplicación
              },
            ),
          ],
        );
      },
    );
  }

  void reiniciarJuego([bool reiniciarContadores = false]) {
    setState(() {
      inicial = estados.cruz;
      contador = 0;
      juegoTerminado = false;
      for (int i = 0; i < tablero.length; i++) {
        tablero[i] = estados.vacio;
      }
    });
  }
}
