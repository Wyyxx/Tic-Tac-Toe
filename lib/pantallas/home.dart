import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io'; // Importar para usar exit(0) en iOS
import 'controles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ControlesState> _controlesKey = GlobalKey<ControlesState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Reiniciar') {
                _showConfirmDialog(context, "¿Desea reiniciar el juego?");
              } else if (value == 'Salir') {
                _showConfirmDialog(context, "¿Desea salir?");
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Reiniciar', 'Salir'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Image.asset("imagenes/board.png"),
            Controles(key: _controlesKey),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _showConfirmDialog(context, "¿Desea reiniciar el juego?");
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _showConfirmDialog(context, "¿Desea salir?");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Sí"),
              onPressed: () {
                Navigator.of(context).pop();
                if (mensaje.contains("reiniciar")) {
                  _controlesKey.currentState?.reiniciarJuego(true);
                } else if (mensaje.contains("salir")) {
                  _salirDeLaAplicacion();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _salirDeLaAplicacion() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0); // No recomendado para la aprobación en App Store
    }
  }
}
