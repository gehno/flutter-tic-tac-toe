import 'dart:math';
import 'package:flutter/material.dart';

abstract class PainterWithPaint extends CustomPainter {
  final BuildContext _context;

  MaskFilter backgroundBlur =
      MaskFilter.blur(BlurStyle.normal, Shadow.convertRadiusToSigma(5));
  PainterWithPaint(this._context);

  Color get primaryColor => Theme.of(_context).canvasColor;
  Color get backgroundColor => Theme.of(_context).backgroundColor;

  Paint getPaint(
    Color color, [
    MaskFilter? maskFilter,
  ]) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = maskFilter
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

    canvas.drawLine(leftTop.translate(5, 5), rightBot.translate(5, 5),
        getPaint(backgroundColor, backgroundBlur));

    if (_fraction > .5) {
      canvas.drawLine(rightTop.translate(5, 5), leftBot.translate(5, 5),
          getPaint(backgroundColor, backgroundBlur));
    }

    canvas.drawLine(leftTop, rightBot, getPaint(primaryColor));

    if (_fraction > .5) {
      canvas.drawLine(rightTop, leftBot, getPaint(primaryColor));
    }
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
    var rect = const Offset(0, 0) & size;

        canvas.drawArc(
        rect.translate(5, 5), -pi / 2, 2 * pi * _fraction, false, getPaint(backgroundColor,backgroundBlur));

    canvas.drawArc(
        rect, -pi / 2, 2 * pi * _fraction, false, getPaint(primaryColor));
  }

  @override
  bool shouldRepaint(covariant OPainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }
}
