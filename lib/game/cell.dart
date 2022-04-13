import 'package:tic_tac_toe/game/home.dart';
import 'package:tic_tac_toe/game/painter.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class GameCell extends StatefulWidget {
  final int index;
  final CellContent? Function(int idx) getCellContent;
  final Function(int idx) cellClicked;

  GameCell(this.index, this.getCellContent, this.cellClicked, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CellState();
  }
}

enum CellContent {
  none,
  x,
  o,
}

extension CellContentExt on CellContent {
  Paint get paint {
    return Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
  }

  GameEndReason get gameEndReason {
    switch (this) {
      case CellContent.x:
        return GameEndReason.xWin;
      case CellContent.o:
        return GameEndReason.oWin;
      default:
        return GameEndReason.gameOver;
    }
  }

  Widget get widget {
    switch (this) {
      case CellContent.x:
        return CustomPaint(
          size: const Size.square(100),
          painter: XPainter(paint),
        );
      case CellContent.o:
        return CustomPaint(
          size: const Size.square(100),
          painter: OPainter(paint),
        );
      default:
        return const Text("");
    }
  }
}

class CellState extends State<GameCell> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.blue.shade200)),
      child: widget.getCellContent(widget.index)!.widget,
      onPressed: () => {
        setState(
          () {
            widget.cellClicked(widget.index);
          },
        ),
      },
    );
  }
}
