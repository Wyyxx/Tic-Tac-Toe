library config.globals;

export 'package:flutter/cupertino.dart';
export 'package:flutter/material.dart' hide RefreshCallback;


export 'package:gto/pantallas/app.dart';
export 'package:gto/pantallas/controles.dart';
export 'package:gto/pantallas/home.dart';
export 'package:gto/widget/celda.dart';



enum estados { vacio, cruz, circulo }

List<estados> tablero = List.filled(9, estados.vacio);
Map<estados, bool> resultados = {estados.cruz: false, estados.circulo: false};

int victoriasCruz = 0;
int victoriasCirculo = 0;
int empates = 0;
