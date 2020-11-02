import 'package:cronenberg/model/PlayerState.dart';

class PlayerQueue {
  List<PlayerState> players;
  int activePlayerIndex;

  PlayerQueue(List<String> playernames, int startScore) {
    this.activePlayerIndex = 0;
    this.players = new List();
    for (String name in playernames) {
      this.players.add(new PlayerState(name, startScore));
    }
  }

  PlayerState activePlayer() {
    return this.players[this.activePlayerIndex];
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

  nextPlayerOrder() {
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
