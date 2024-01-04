import 'package:flutter/material.dart';

class BackgroundClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 50.0;

    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, 0);
    path.quadraticBezierTo(
        size.width * 0.45, size.height * 0.8, size.width, size.height - 100);
    // path.lineTo(size.width, size.height - 20);

    path.quadraticBezierTo(size.width * 0.5, size.height, 0, size.height - 100);
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
