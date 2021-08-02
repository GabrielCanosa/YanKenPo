import 'dart:ui';

class Imagen {
  String urlImage;
  Color colorCenter;
  Color colorBorder;
  int playerSelectedOpt;

  Imagen(String urlImage, Color colorCenter, Color colorBorder,
      int playerSelectedOpt) {
    this.urlImage = urlImage;
    this.colorCenter = colorCenter;
    this.colorBorder = colorBorder;
    this.playerSelectedOpt = playerSelectedOpt;
  }
}
