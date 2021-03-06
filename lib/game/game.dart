import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:tic_tac_toe/game/cell.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game/model.dart';

import '../util/util.dart';

class GameScreen extends StatefulWidget {
  late final GameModel model;

  final void Function(GameResult result) callback;

  GameScreen(this.callback, {Key? key}) : super(key: key) {
    model = GameModel(callback);
  }

  @override
  State<StatefulWidget> createState() {
    return GameScreenState();
  }
}

class GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PropertyChangeProvider<GameModel, String>(
          value: widget.model,
          child: const PlayerListener(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size.square(500)),
                child: GridView.count(
                  childAspectRatio: 1,
                  primary: true,
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: _createCells(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _createCells() {
    var list = List.generate(
        9,
        (i) =>
            GameCell(i, widget.model.getCellContent, widget.model.cellClicked));
    for (var element in list) {
      widget.model.gameState[element.index] = CellContent.none;
    }
    return list;
  }
}

class PlayerListener extends StatelessWidget {
  const PlayerListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<GameModel, String>(
        properties: const ["player"],
        builder: (context, model, properties) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                getUiText(context).player,
              ),
              Transform.scale(
                scale: 0.3,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox.square(
                    dimension: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        model!.nextPlayer();
                      },
                      child: model!.player.widget,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

enum GameEndReason {
  gameOver,
  xWin,
  oWin,
}

class GameResult {
  final GameEndReason gameEndReason;
  GameResult(this.gameEndReason);

  Widget getTitle(BuildContext context) {
    switch (gameEndReason) {
      case GameEndReason.xWin:
      case GameEndReason.oWin:
        return Text(getUiText(context).win);
      default:
        return Text(getUiText(context).draw);
    }
  }

  Widget getContent(BuildContext context) {
    switch (gameEndReason) {
      case GameEndReason.xWin:
        return Text(
            "${getUiText(context).player} X ${getUiText(context).isTheWinner}");
      case GameEndReason.oWin:
        return Text(
            "${getUiText(context).player} O ${getUiText(context).isTheWinner}");
      default:
        return Text(getUiText(context).gameOver);
    }
  }

  Widget getDialog(BuildContext context) {
    return AlertDialog(
      title: getTitle(context),
      content: getContent(context),
    );
  }
}
