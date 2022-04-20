import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game/painter.dart';

abstract class AnimatedFractionWidget extends StatefulWidget {
  const AnimatedFractionWidget({
    Key? key,
  }) : super(key: key);
}

abstract class AnimatedFractionWidgetState<T extends AnimatedFractionWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;

  double get fraction => _fraction;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = animation.value;
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class XWidget extends AnimatedFractionWidget {
  const XWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<XWidget> createState() => _XWidgetState();
}

class _XWidgetState extends AnimatedFractionWidgetState<XWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(100),
      painter: XPainter(context, fraction),
    );
  }
}

class OWidget extends AnimatedFractionWidget {
  const OWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OWidget> createState() => _OWidgetState();
}

class _OWidgetState extends AnimatedFractionWidgetState<OWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(100),
      painter: OPainter(context, fraction),
    );
  }
}
