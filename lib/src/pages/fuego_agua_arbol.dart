import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:math';

import 'package:piedra_papel_tijera/src/classes/image.dart';

class FuegoAguaArbolPage extends StatefulWidget {
  @override
  _FuegoAguaArbolPageState createState() => _FuegoAguaArbolPageState();
}

class _FuegoAguaArbolPageState extends State<FuegoAguaArbolPage> {
  CountDownController _controller = CountDownController();
  final _random = new Random();
  static const arbol = 1;
  static const fuego = 2;
  static const agua = 3;
  String contentDialog = '';
  int computerSelectedOption = null;
  int playerSelectedOption = null;
  bool playerHasChoosen = false;
  String urlMachinesChoice = 'assets/Images/interrogation.png';
  Imagen imgArbol =
      new Imagen('assets/Images/arbol.png', Colors.white, Colors.green[800], 1);
  Imagen imgFuego =
      new Imagen('assets/Images/fuego.png', Colors.white, Colors.red, 2);
  Imagen imgAgua =
      new Imagen('assets/Images/agua.png', Colors.white, Colors.blue, 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fuego Agua Arbol'),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
              radius: 0.3,
              colors: <Color>[Colors.grey[700], Colors.white10],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _machinesTurn(
                    urlMachinesChoice, Colors.white, Colors.purple[400]),
                _circularCountdown(),
                Row(
                  children: [
                    Expanded(
                      child: _returnImagen(
                          imgArbol.urlImage,
                          imgArbol.colorCenter,
                          imgArbol.colorBorder,
                          imgArbol.playerSelectedOpt),
                    ),
                    Expanded(
                      child: _returnImagen(
                          imgFuego.urlImage,
                          imgFuego.colorCenter,
                          imgFuego.colorBorder,
                          imgFuego.playerSelectedOpt),
                    ),
                    Expanded(
                        child: _returnImagen(
                            imgAgua.urlImage,
                            imgAgua.colorCenter,
                            imgAgua.colorBorder,
                            imgAgua.playerSelectedOpt)),
                  ],
                ),
              ],
            )));
  }

  _returnImagen(String urlImage, Color colorCenter, Color colorBorder,
      int playerSelectedOpt) {
    return Material(
      child: GestureDetector(
        onTap: () {
          setState(() {
            playerHasChoosen = true;
            playerSelectedOption = playerSelectedOpt;
            _controller.pause();
            _changeImagesNotSelected();
            _computerSelectOption();
            _result();
          });
        },
        child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 1.1,
                  colors: <Color>[colorCenter, colorBorder],
                ),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.black)),
            margin: EdgeInsets.all(2.0),
            child: Image.asset(urlImage, width: 100, height: 110)),
      ),
    );
  }

  _machinesTurn(String urlImage, Color colorCenter, Color colorBorder) {
    return Material(
      child: GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 1.1,
                  colors: <Color>[colorCenter, colorBorder],
                ),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.black)),
            margin: EdgeInsets.all(10.0),
            child: Image.asset(urlImage, width: 120, height: 110)),
      ),
    );
  }

  _computerSelectOption() {
    computerSelectedOption = random(1, 4);
    switch (computerSelectedOption) {
      case arbol:
        urlMachinesChoice = 'assets/Images/arbol.png';
        break;
      case fuego:
        urlMachinesChoice = 'assets/Images/fuego.png';
        break;
      case agua:
        urlMachinesChoice = 'assets/Images/agua.png';
        break;
    }
  }

  int random(int min, int max) => min + _random.nextInt(max - min);

  _circularCountdown() {
    return CircularCountDownTimer(
      duration: 5,
      initialDuration: 0,
      controller: _controller,
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 3,
      ringColor: Colors.white,
      ringGradient: null,
      fillColor: Colors.yellowAccent,
      fillGradient: null,
      backgroundColor: Colors.white,
      backgroundGradient: RadialGradient(
        radius: 2.5,
        colors: <Color>[Colors.white, Colors.black],
      ),
      strokeWidth: 5.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: 40.0, color: Colors.black, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {},
      onComplete: () {
        _controller.pause();
        _result();
      },
    );
  }

  _result() {
    String text = '';
    Color colorText;

    if (playerHasChoosen) {
      if (computerSelectedOption == playerSelectedOption) {
        text = 'EMPATE';
        colorText = Colors.black;
      }

      if (computerSelectedOption == 1 && playerSelectedOption == 2) {
        text = 'GANASTE';
        contentDialog = 'Fuego quema árbol';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 1 && playerSelectedOption == 3) {
        text = 'PERDISTE';
        contentDialog = 'Agua riega árbol';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 2 && playerSelectedOption == 1) {
        text = 'PERDISTE';
        contentDialog = 'Fuego quema árbol';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 2 && playerSelectedOption == 3) {
        text = 'GANASTE';
        contentDialog = 'Agua apaga fuego';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 3 && playerSelectedOption == 1) {
        text = 'GANASTE';
        contentDialog = 'Agua riega árbol';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 3 && playerSelectedOption == 2) {
        text = 'PERDISTE';
        contentDialog = 'Agua apaga fuego';
        colorText = Colors.red[900];
      }

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: Center(child: Text(text)),
              content: Text(contentDialog),
              titleTextStyle: TextStyle(
                  color: colorText, fontWeight: FontWeight.bold, fontSize: 30),
              actions: [
                FlatButton(
                    onPressed: (() {
                      setState(() {
                        Navigator.of(context).pop();
                        _restartGame();
                      });
                    }),
                    child: Text('Ok'))
              ],
              elevation: 24.0),
          barrierDismissible: false);
    } else {
      _restartGame();
    }
  }

  _restartGame() {
    computerSelectedOption = null;
    playerSelectedOption = null;
    playerHasChoosen = false;
    contentDialog = '';
    urlMachinesChoice = 'assets/Images/interrogation.png';
    imgArbol =
        new Imagen('assets/Images/arbol.png', Colors.white, Colors.red, 1);
    imgFuego =
        new Imagen('assets/Images/fuego.png', Colors.white, Colors.blue, 2);
    imgAgua = new Imagen(
        'assets/Images/agua.png', Colors.white, Colors.yellowAccent, 3);
    _controller.restart();
  }

  _changeImagesNotSelected() {
    if (playerSelectedOption == 1) {
      imgFuego = new Imagen(
          'assets/Images/fuego.png', Colors.grey[700], Colors.grey[700], 2);
      imgAgua = new Imagen(
          'assets/Images/agua.png', Colors.grey[700], Colors.grey[700], 3);
    } else if (playerSelectedOption == 2) {
      imgArbol = new Imagen(
          'assets/Images/arbol.png', Colors.grey[700], Colors.grey[700], 1);
      imgAgua = new Imagen(
          'assets/Images/agua.png', Colors.grey[700], Colors.grey[700], 3);
    } else {
      imgArbol = new Imagen(
          'assets/Images/arbol.png', Colors.grey[700], Colors.grey[700], 1);
      imgFuego = new Imagen(
          'assets/Images/fuego.png', Colors.grey[700], Colors.grey[700], 2);
    }
  }
}
