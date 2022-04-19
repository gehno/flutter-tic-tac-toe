import 'package:tic_tac_toe/game/painter.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class GameCell extends StatefulWidget {
  final int index;
  final CellContent? Function(int idx) getCellContent;
  final Function(int idx) cellClicked;

  const GameCell(this.index, this.getCellContent, this.cellClicked, {Key? key})
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
  Paint getPaint(BuildContext context) {
    return Paint()
      ..color = Theme.of(context).canvasColor
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

  Widget getWidget(BuildContext context) {
    switch (this) {
      case CellContent.x:
        return CustomPaint(
          size: const Size.square(100),
          painter: XPainter(getPaint(context)),
        );
      case CellContent.o:
        return CustomPaint(
          size: const Size.square(100),
          painter: OPainter(getPaint(context)),
        );
      default:
        return const Text("");
    }
  }
}

class CellState extends State<GameCell> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: widget.getCellContent(widget.index)!.getWidget(context),
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
