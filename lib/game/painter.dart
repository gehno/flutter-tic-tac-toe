import 'dart:math';

import 'package:flutter/material.dart';

abstract class PainterWithPaint extends CustomPainter {
  final BuildContext _context;
  PainterWithPaint(this._context);

  Paint get _paint {
    return Paint()
      ..color = Theme.of(_context).canvasColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
  }
}

class XPainter extends PainterWithPaint {
  final double _fraction;
  XPainter(BuildContext context, this._fraction) : super(context);

  @override
  void paint(Canvas canvas, Size size) {
    double leftFraction, rightFraction;

    if (_fraction < .5) {
      leftFraction = _fraction / .5;
      rightFraction = 1;
    } else {
      leftFraction = 1.0;
      rightFraction = 1 - ((_fraction - 0.5) / .5);
    }

    Offset leftTop = const Offset(0, 0);
    Offset rightBot =
        Offset(size.width * leftFraction, size.height * leftFraction);

    Offset rightTop = Offset(
        size.width - size.width * rightFraction, size.height * rightFraction);
    Offset leftBot = Offset(0, size.height);
    canvas.drawLine(leftTop, rightBot, _paint);
    canvas.drawLine(rightTop, leftBot, _paint);
  }

  @override
  bool shouldRepaint(covariant XPainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }
}

class OPainter extends PainterWithPaint {
  final double _fraction;
  OPainter(BuildContext context, this._fraction) : super(context);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = const Offset(0,0) & size;

    canvas.drawArc(rect, -pi / 2, 2 * pi * _fraction, false, _paint);
  }

  @override
  bool shouldRepaint(covariant OPainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }
}
