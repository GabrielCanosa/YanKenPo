import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final initialRoutes = [
    {"ruta": "piedraPapelTijera", "texto": "Piedra - Papel - Tijera"},
    {
      "ruta": "piedraPapelTijeraLagartoSpock",
      "texto": "Piedra - Papel - Tijera - Lagarto - Spock"
    },
    {
      "ruta": "bombaNuclearZapatoCucaracha",
      "texto": "Bomba nuclear - Zapato - Cucaracha"
    },
    {"ruta": "fuegoAguaArbol", "texto": "Fuego - Agua - Arbol"},
    {"ruta": "elefantePiedraAguila", "texto": "Elefante - Ratón - Aguila"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cashita'),
      ),
      body: _listado(),
    );
  }

  _listado() {
    return FutureBuilder(
        initialData: initialRoutes,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            children: _listaItems(snapshot.data, context),
          );
        });
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        onTap: () {
          Navigator.pushNamed(context, opt['ruta']);
        },
      );
      opciones..add(widgetTemp)..add(Divider());
    });
    return opciones;
  }
}
