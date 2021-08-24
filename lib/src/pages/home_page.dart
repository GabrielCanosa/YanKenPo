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
    {"ruta": "elefantePiedraAguila", "texto": "Elefante - Ratón - Aguila"},
    {"ruta": "otros", "texto": "Más info..."}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('¡Elige un juego!')),
      ),
      body: CustomPaint(
        child: _listado(),
        painter: _CustomPainter(),
      ),
    );
  }

  _listado() {
    return FutureBuilder(
        initialData: initialRoutes,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            padding: EdgeInsets.all(5.0),
            children: _listaItems(snapshot.data, context),
          );
        });
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      final widgetTemp = Card(
          elevation: 2,
          child: ListTile(
            title: Center(child: Text(opt['texto'])),
            onTap: () {
              Navigator.pushNamed(context, opt['ruta']);
            },
          ));
      opciones..add(widgetTemp);
    });
    return opciones;
  }
}

class _CustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradiente = new LinearGradient(
        colors: [Colors.red, Colors.blue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    final Rect rect =
        new Rect.fromCircle(center: Offset(200.0, 100.0), radius: 180);

    final paint = Paint()..shader = gradiente.createShader(rect);

    paint.color = Colors.blue[300];
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = Path();

    path.lineTo(0, size.height * 0.62);
    path.lineTo(size.width, size.height * 0.62);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }
}
