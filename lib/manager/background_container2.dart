import 'package:flutter/material.dart';

class BackgroundClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 50.0;

    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, size.height * 0.3);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    /*path.quadraticBezierTo(size.width, size.height - 10, size.width,
        size.height - roundnessFactor + 10);*/

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
