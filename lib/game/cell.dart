import 'package:flutter/material.dart';
import 'animated_fraction_widget.dart';
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
        return const XWidget();
      case CellContent.o:
        return const OWidget();
      default:
        return const Text("");
    }
  }
}

class CellState extends State<GameCell> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
