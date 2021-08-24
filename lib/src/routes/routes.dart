import 'package:flutter/material.dart';
import 'package:piedra_papel_tijera/src/pages/elefante_raton_aguila.dart';
import 'package:piedra_papel_tijera/src/pages/home_page.dart';
import 'package:piedra_papel_tijera/src/pages/masinformacion.dart';
import 'package:piedra_papel_tijera/src/pages/piedra_papel_tijera.dart';
import 'package:piedra_papel_tijera/src/pages/piedra_papel_tijera_lagarto_spock.dart';
import 'package:piedra_papel_tijera/src/pages/bombanuclear_zapato_cucaracha.dart';
import 'package:piedra_papel_tijera/src/pages/fuego_agua_arbol.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'piedraPapelTijera': (BuildContext context) => PiedraPapelTijeraPage(),
    'piedraPapelTijeraLagartoSpock': (BuildContext context) =>
        PiedraPapelTijeraLagartoSpockPage(),
    'bombaNuclearZapatoCucaracha': (BuildContext context) =>
        BombaNuclearZapatoCucarachaPage(),
    'fuegoAguaArbol': (BuildContext context) => FuegoAguaArbolPage(),
    'elefantePiedraAguila': (BuildContext context) => ElefanteRatonAguila(),
    'otros': (BuildContext context) => Masinformacion()
  };
}
