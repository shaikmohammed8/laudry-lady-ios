import 'package:flutter/material.dart';

class CustomPain extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 2 - 10);
    path.lineTo(size.width - 10, size.height / 2);
    path.lineTo(size.width, size.height / 2 + 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height / 2 + 10);
    path.lineTo(10, size.height / 2);
    path.lineTo(0, size.height / 2 - 10);

    //path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
