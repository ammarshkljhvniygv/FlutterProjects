import 'package:flutter/material.dart';

class BackgroundClipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 50.0;

    var path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 100);
    path.quadraticBezierTo(size.width * 0.5, size.height, 0, size.height - 100);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.8, size.width, 0);
    // path.lineTo(size.width, 0);

    // path.lineTo(size.width, size.height - 20);

    // path.quadraticBezierTo(size.width * 0.5, size.height, 0, size.height - 75);
    // path.lineTo(0, size.height - 20);

    /*path.quadraticBezierTo(size.width, size.height - 10, size.width,
        size.height - roundnessFactor + 10);*/

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
