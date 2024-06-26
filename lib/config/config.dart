library config.globals;

enum estados { vacio, cruz, circulo }

List<estados> tablero = List.filled(9, estados.vacio);
Map<estados, bool> resultados = {estados.cruz: false, estados.circulo: false};

int victoriasCruz = 0;
int victoriasCirculo = 0;
int empates = 0;
