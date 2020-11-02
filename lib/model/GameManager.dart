import 'package:cronenberg/model/PlayerManager.dart';

class GameManager {
  List<PlayerManager> players;
  int activePlayerIndex;

  GameManager(List<String> playernames, int score) {
    this.activePlayerIndex = 0;
    this.players = [];
    for (String name in playernames) {
      this.players.add(new PlayerManager(name, score));
    }
  }

  PlayerManager activePlayer() {
    return this.players[this.activePlayerIndex];
  }

  PlayerManager getPlayer(int i) {
    return this.players[i];
  }

  nextPlayer() {
    if (this.activePlayerIndex == this.players.length - 1) {
      this.activePlayerIndex = 0;
    } else {
      this.activePlayerIndex++;
    }
  }

  previousPlayer() {
    if (this.activePlayerIndex == 0) {
      this.activePlayerIndex = this.players.length - 1;
    } else {
      this.activePlayerIndex--;
    }
  }

  List<int> nextPlayerOrder() {
    List<int> order = [];
    for (int i = this.activePlayerIndex + 1; i < this.players.length; i++) {
      order.add(i);
    }
    for (int i = 0; i < this.activePlayerIndex; i++) {
      order.add(i);
    }
    return order;
  }
}
