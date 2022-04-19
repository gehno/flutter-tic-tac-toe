import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PainterWithPaint extends CustomPainter {
  final Paint _paint;

  PainterWithPaint(this._paint);
}

class XPainter extends PainterWithPaint {
  XPainter(Paint paint) : super(paint);

  @override
  void paint(Canvas canvas, Size size) {
    Offset leftTop = const Offset(0, 0);
    Offset rightBot = Offset(size.width, size.height);
    Offset rightTop = Offset(size.width, 0);
    Offset leftBot = Offset(0, size.height);
    canvas.drawLine(leftTop, rightBot, _paint);
    canvas.drawLine(rightTop, leftBot, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OPainter extends PainterWithPaint {
  OPainter(Paint paint) : super(paint);

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(offset, size.shortestSide / 2, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
