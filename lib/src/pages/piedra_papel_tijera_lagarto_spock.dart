import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:math';
import 'dart:io';

import 'package:piedra_papel_tijera/src/classes/image.dart';

class PiedraPapelTijeraLagartoSpockPage extends StatefulWidget {
  @override
  _PiedraPapelTijeraLagartoSpockPageState createState() =>
      _PiedraPapelTijeraLagartoSpockPageState();
}

class _PiedraPapelTijeraLagartoSpockPageState
    extends State<PiedraPapelTijeraLagartoSpockPage> {
  CountDownController _controller = CountDownController();
  final _random = new Random();
  static const piedra = 1;
  static const papel = 2;
  static const tijera = 3;
  static const lagarto = 4;
  static const spock = 5;
  String contentDialog = '';
  int computerSelectedOption = null;
  int playerSelectedOption = null;
  bool playerHasChoosen = false;
  String urlMachinesChoice = 'assets/Images/interrogation.png';
  Imagen imgPiedra =
      new Imagen('assets/Images/piedra.png', Colors.white, Colors.red, 1);
  Imagen imgPapel =
      new Imagen('assets/Images/papel.png', Colors.white, Colors.orange, 2);
  Imagen imgTijera = new Imagen(
      'assets/Images/tijera.png', Colors.white, Colors.yellowAccent, 3);
  Imagen imgLagarto =
      new Imagen('assets/Images/lagarto.png', Colors.white, Colors.green, 4);
  Imagen imgSpock =
      new Imagen('assets/Images/spock.png', Colors.white, Colors.blue, 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Piedra - Papel - Tijera - Lagarto - Spock'),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
              radius: 0.3,
              colors: <Color>[Colors.white10, Colors.white10],
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
                    _returnImagen(imgPiedra.urlImage, imgPiedra.colorCenter,
                        imgPiedra.colorBorder, imgPiedra.playerSelectedOpt),
                    _returnImagen(imgPapel.urlImage, imgPapel.colorCenter,
                        imgPapel.colorBorder, imgPapel.playerSelectedOpt),
                    _returnImagen(imgTijera.urlImage, imgTijera.colorCenter,
                        imgTijera.colorBorder, imgTijera.playerSelectedOpt),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _returnImagen(imgLagarto.urlImage, imgLagarto.colorCenter,
                        imgLagarto.colorBorder, imgLagarto.playerSelectedOpt),
                    _returnImagen(imgSpock.urlImage, imgSpock.colorCenter,
                        imgSpock.colorBorder, imgSpock.playerSelectedOpt)
                  ],
                )
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
            child: Image.asset(urlImage, width: 110, height: 110)),
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
    computerSelectedOption = random(1, 6);
    switch (computerSelectedOption) {
      case piedra:
        urlMachinesChoice = 'assets/Images/piedra.png';
        break;
      case papel:
        urlMachinesChoice = 'assets/Images/papel.png';
        break;
      case tijera:
        urlMachinesChoice = 'assets/Images/tijera.png';
        break;
      case lagarto:
        urlMachinesChoice = 'assets/Images/lagarto.png';
        break;
      case spock:
        urlMachinesChoice = 'assets/Images/spock.png';
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
      fillColor: Colors.pink[400],
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
        contentDialog = 'Papel envuelve piedra';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 1 && playerSelectedOption == 3) {
        text = 'PERDISTE';
        contentDialog = 'Piedra aplasta tijera';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 1 && playerSelectedOption == 4) {
        text = 'PERDISTE';
        contentDialog = 'Piedra aplasta lagarto';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 1 && playerSelectedOption == 5) {
        text = 'GANASTE';
        contentDialog = 'Spock vaporiza piedra';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 2 && playerSelectedOption == 1) {
        text = 'PERDISTE';
        contentDialog = 'Papel envuelve piedra';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 2 && playerSelectedOption == 3) {
        text = 'GANASTE';
        contentDialog = 'Tijera corta papel';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 2 && playerSelectedOption == 4) {
        text = 'GANASTE';
        contentDialog = 'Lagarto devora papel';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 2 && playerSelectedOption == 5) {
        text = 'PERDISTE';
        contentDialog = 'Papel desautoriza Spock';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 3 && playerSelectedOption == 1) {
        text = 'GANASTE';
        contentDialog = 'Piedra aplasta papel';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 3 && playerSelectedOption == 2) {
        text = 'PERDISTE';
        contentDialog = 'Tijera corta papel';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 3 && playerSelectedOption == 4) {
        text = 'PERDISTE';
        contentDialog = 'Tijera decapita lagarto';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 3 && playerSelectedOption == 5) {
        text = 'GANASTE';
        contentDialog = 'Spock rompe tijera';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 4 && playerSelectedOption == 1) {
        text = 'GANASTE';
        contentDialog = 'Piedra aplasta lagarto';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 4 && playerSelectedOption == 2) {
        text = 'PERDISTE';
        contentDialog = 'Lagarto devora papel';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 4 && playerSelectedOption == 3) {
        text = 'GANASTE';
        contentDialog = 'Tijera decapita lagarto';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 4 && playerSelectedOption == 5) {
        text = 'PERDISTE';
        contentDialog = 'Lagarto envenena Spock';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 5 && playerSelectedOption == 1) {
        text = 'PERDISTE';
        contentDialog = 'Spock vaporiza piedra';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 5 && playerSelectedOption == 2) {
        text = 'GANASTE';
        contentDialog = 'Papel desautoriza a Spock';
        colorText = Colors.green[900];
      } else if (computerSelectedOption == 5 && playerSelectedOption == 3) {
        text = 'PERDISTE';
        contentDialog = 'Spock rompe tijera';
        colorText = Colors.red[900];
      } else if (computerSelectedOption == 5 && playerSelectedOption == 4) {
        text = 'GANASTE';
        contentDialog = 'Lagarto envenena Spock';
        colorText = Colors.green[900];
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
    imgPiedra =
        new Imagen('assets/Images/piedra.png', Colors.white, Colors.red, 1);
    imgPapel =
        new Imagen('assets/Images/papel.png', Colors.white, Colors.blue, 2);
    imgTijera = new Imagen(
        'assets/Images/tijera.png', Colors.white, Colors.yellowAccent, 3);
    imgLagarto =
        new Imagen('assets/Images/lagarto.png', Colors.white, Colors.green, 4);
    imgSpock =
        new Imagen('assets/Images/spock.png', Colors.white, Colors.blue, 5);
    _controller.restart();
  }

  _changeImagesNotSelected() {
    if (playerSelectedOption == 1) {
      imgPapel = new Imagen(
          'assets/Images/papel.png', Colors.grey[700], Colors.grey[700], 2);
      imgTijera = new Imagen(
          'assets/Images/tijera.png', Colors.grey[700], Colors.grey[700], 3);
      imgLagarto = new Imagen(
          'assets/Images/lagarto.png', Colors.grey[700], Colors.grey[700], 4);
      imgSpock = new Imagen(
          'assets/Images/spock.png', Colors.grey[700], Colors.grey[700], 5);
    } else if (playerSelectedOption == 2) {
      imgPiedra = new Imagen(
          'assets/Images/piedra.png', Colors.grey[700], Colors.grey[700], 1);
      imgTijera = new Imagen(
          'assets/Images/tijera.png', Colors.grey[700], Colors.grey[700], 3);
      imgLagarto = new Imagen(
          'assets/Images/lagarto.png', Colors.grey[700], Colors.grey[700], 4);
      imgSpock = new Imagen(
          'assets/Images/spock.png', Colors.grey[700], Colors.grey[700], 5);
    } else if (playerSelectedOption == 3) {
      imgPiedra = new Imagen(
          'assets/Images/piedra.png', Colors.grey[700], Colors.grey[700], 1);
      imgPapel = new Imagen(
          'assets/Images/papel.png', Colors.grey[700], Colors.grey[700], 2);
      imgLagarto = new Imagen(
          'assets/Images/lagarto.png', Colors.grey[700], Colors.grey[700], 4);
      imgSpock = new Imagen(
          'assets/Images/spock.png', Colors.grey[700], Colors.grey[700], 5);
    } else if (playerSelectedOption == 4) {
      imgPiedra = new Imagen(
          'assets/Images/piedra.png', Colors.grey[700], Colors.grey[700], 1);
      imgPapel = new Imagen(
          'assets/Images/papel.png', Colors.grey[700], Colors.grey[700], 2);
      imgTijera = new Imagen(
          'assets/Images/tijera.png', Colors.grey[700], Colors.grey[700], 3);
      imgSpock = new Imagen(
          'assets/Images/spock.png', Colors.grey[700], Colors.grey[700], 5);
    } else {
      imgPiedra = new Imagen(
          'assets/Images/piedra.png', Colors.grey[700], Colors.grey[700], 1);
      imgPapel = new Imagen(
          'assets/Images/papel.png', Colors.grey[700], Colors.grey[700], 2);
      imgTijera = new Imagen(
          'assets/Images/tijera.png', Colors.grey[700], Colors.grey[700], 3);
      imgLagarto = new Imagen(
          'assets/Images/lagarto.png', Colors.grey[700], Colors.grey[700], 4);
    }
  }
}
