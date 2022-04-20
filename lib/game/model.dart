import 'dart:collection';
import 'package:bit_array/bit_array.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:tic_tac_toe/game/cell.dart';
import 'package:tic_tac_toe/game/game.dart';

class GameModel extends PropertyChangeNotifier<String> {
  final winVectors = List<BitArray>.of([
    // each row
    BitArray.parseBinary("000000111"),
    BitArray.parseBinary("000111000"),
    BitArray.parseBinary("111000000"),
    // each column
    BitArray.parseBinary("100100100"),
    BitArray.parseBinary("010010010"),
    BitArray.parseBinary("001001001"),
    // each diagonal
    BitArray.parseBinary("100010001"),
    BitArray.parseBinary("001010100"),
  ]);

  HashMap<int, CellContent> _gameState = HashMap();

  CellContent _player = CellContent.x;

  final void Function(GameResult result) callback;

  GameModel(this.callback);

  CellContent get player => _player;
  HashMap<int, CellContent> get gameState => _gameState;

  set player(CellContent value) {
    _player = value;
    notifyListeners("player");
  }

  set gameState(HashMap<int, CellContent> value) {
    _gameState = value;
    notifyListeners("gameState");
  }

  void resetGame() {
    gameState.forEach((key, value) {
      gameState[key] = CellContent.none;
    });
  }

  void nextPlayer() {
    switch (player) {
      case CellContent.x:
        player = CellContent.o;
        break;
      case CellContent.o:
        player = CellContent.x;
        break;
      default:
        break;
    }
  }

  CellContent? getCellContent(int idx) {
    return gameState[idx];
  }

  BitArray getPlayerVector() {
    BitArray arr = BitArray(9);

    arr.clearAll();
    gameState.forEach((idx, value) {
      if (player == value) {
        arr.setBit(idx);
      } else {
        arr.clearBit(idx);
      }
    });

    return arr;
  }

  cellClicked(int idx) {
    if (gameState[idx] == CellContent.none) {
      gameState[idx] = player;
      checkGameState();
      nextPlayer();
    }
  }

  void checkGameState() {
    var playerVector = getPlayerVector();
    for (var element in winVectors) {
      final result = playerVector & element;
      if (result == element) {
        callback.call(GameResult(player.gameEndReason));
        return;
      }
    }

    if (!gameState.containsValue(CellContent.none)) {
      //Game Over
      callback.call(GameResult(GameEndReason.gameOver));
      return;
    }
  }
}
