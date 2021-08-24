import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Masinformacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String urlTwitter = 'https://twitter.com/HyenaSoftware';
    final String urlInstagram = 'https://www.instagram.com/hyena.games/';
    final String urlTiktok = 'https://vm.tiktok.com/ZMJEw2Aj7/';

    return Scaffold(
        body: Container(
            child: Column(children: [
      Padding(padding: EdgeInsets.only(top: 70)),
      Image.asset("assets/Images/logo fondo transparente.png"),
      Padding(padding: EdgeInsets.only(top: 50)),
      RaisedButton(
          onPressed: () async {
            await launch(urlInstagram);
          },
          child: Row(children: [
            Image.asset("assets/Images/instagram.png"),
            Text("@hyena.games")
          ])),
      Padding(padding: EdgeInsets.only(top: 30)),
      RaisedButton(
          onPressed: () async {
            await launch(urlTwitter);
          },
          child: Row(children: [
            Image.asset("assets/Images/twitter.png"),
            Text("@hyenasoftware")
          ])),
      Padding(padding: EdgeInsets.only(top: 30)),
      RaisedButton(
          onPressed: () async {
            await launch(urlTiktok);
          },
          child: Row(children: [
            Image.asset("assets/Images/tiktok.png"),
            Text("@hyenagames")
          ]))
    ])));
  }
}
