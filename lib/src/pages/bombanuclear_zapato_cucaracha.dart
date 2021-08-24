import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:math';
import 'dart:io';

import 'package:piedra_papel_tijera/src/classes/image.dart';

class BombaNuclearZapatoCucarachaPage extends StatefulWidget {
  @override
  _BombaNuclearZapatoCucarachaPageState createState() =>
      _BombaNuclearZapatoCucarachaPageState();
}

class _BombaNuclearZapatoCucarachaPageState
    extends State<BombaNuclearZapatoCucarachaPage> {
  CountDownController _controller = CountDownController();
  final _random = new Random();
  static const bombanuclear = 1;
  static const cucaracha = 2;
  static const zapato = 3;
  int computerSelectedOption = null;
  int playerSelectedOption = null;
  bool playerHasChoosen = false;
  String urlMachinesChoice = 'assets/Images/interrogation.png';
  Imagen imgBombaNuclear =
      new Imagen('assets/Images/bombanuclear.png', Colors.white, Colors.red, 1);
  Imagen imgCucaracha = new Imagen(
      'assets/Images/cucaracha.png', Colors.white, Colors.green[800], 2);
  Imagen imgZapato = new Imagen(
      'assets/Images/zapato.png', Colors.white, Colors.yellowAccent, 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bomba nuclear - Cucaracha - Zapato'),
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
                          imgBombaNuclear.urlImage,
                          imgBombaNuclear.colorCenter,
                          imgBombaNuclear.colorBorder,
                          imgBombaNuclear.playerSelectedOpt),
                    ),
                    Expanded(
                      child: _returnImagen(
                          imgCucaracha.urlImage,
                          imgCucaracha.colorCenter,
                          imgCucaracha.colorBorder,
                          imgCucaracha.playerSelectedOpt),
                    ),
                    Expanded(
                        child: _returnImagen(
                            imgZapato.urlImage,
                            imgZapato.colorCenter,
                            imgZapato.colorBorder,
                            imgZapato.playerSelectedOpt)),
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
      case bombanuclear:
        urlMachinesChoice = 'assets/Images/bombanuclear.png';
        break;
      case cucaracha:
        urlMachinesChoice = 'assets/Images/cucaracha.png';
        break;
      case zapato:
        urlMachinesChoice = 'assets/Images/zapato.png';
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
      fillColor: Colors.blue,
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
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 1 && playerSelectedOption == 3) {
        text = 'PERDISTE';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 2 && playerSelectedOption == 1) {
        text = 'PERDISTE';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 2 && playerSelectedOption == 3) {
        text = 'GANASTE';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 3 && playerSelectedOption == 1) {
        text = 'GANASTE';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 3 && playerSelectedOption == 2) {
        text = 'PERDISTE';
        colorText = Colors.red[900];
      }

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: Center(child: Text(text)),
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
    urlMachinesChoice = 'assets/Images/interrogation.png';
    imgBombaNuclear = new Imagen(
        'assets/Images/bombanuclear.png', Colors.white, Colors.red, 1);
    imgCucaracha =
        new Imagen('assets/Images/cucaracha.png', Colors.white, Colors.blue, 2);
    imgZapato = new Imagen(
        'assets/Images/zapato.png', Colors.white, Colors.yellowAccent, 3);
    _controller.restart();
  }

  _changeImagesNotSelected() {
    if (playerSelectedOption == 1) {
      imgCucaracha = new Imagen(
          'assets/Images/cucaracha.png', Colors.grey[700], Colors.grey[700], 2);
      imgZapato = new Imagen(
          'assets/Images/zapato.png', Colors.grey[700], Colors.grey[700], 3);
    } else if (playerSelectedOption == 2) {
      imgBombaNuclear = new Imagen('assets/Images/bombanuclear.png',
          Colors.grey[700], Colors.grey[700], 1);
      imgZapato = new Imagen(
          'assets/Images/zapato.png', Colors.grey[700], Colors.grey[700], 3);
    } else {
      imgBombaNuclear = new Imagen('assets/Images/bombanuclear.png',
          Colors.grey[700], Colors.grey[700], 1);
      imgCucaracha = new Imagen(
          'assets/Images/cucaracha.png', Colors.grey[700], Colors.grey[700], 2);
    }
  }
}
