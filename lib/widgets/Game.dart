import 'package:flutter/material.dart';
import 'package:cronenberg/model/GameManager.dart';
import 'package:cronenberg/widgets/ButtonBoard.dart';

class Game extends StatefulWidget {
  int startScore;
  List<String> players;
  bool doubleOut;

  Game(int startScore, List<String> players, bool doubleOut) {
    this.startScore = startScore;
    this.players = players;
    this.doubleOut = doubleOut;
  }

  @override
  GameState createState() => GameState(startScore, players, doubleOut);
}

class GameState extends State<Game> {
  int score;
  GameManager gameState;
  bool doubleOut;

  GameState(int startScore, List<String> players, bool doubleOut) {
    this.score = startScore;
    this.doubleOut = doubleOut;
    this.gameState = new GameManager(players, this.score);
  }

  void substractValue(int value, [int mult = 1]) {
    setState(() {
      value = value * mult;
      print('Scored value $value');
      if (value > this.gameState.activePlayer().score) {
        print('Value is bigger than left score, so its unvalid');
        this.gameState.activePlayer().stack.add(0);
      } else {
        if (this.gameState.activePlayer().score - value == 0 &&
            (!doubleOut || (doubleOut && mult == 2))) {
          print("Player wins");
          this.gameState.activePlayer().score -= value;
          this.gameState.activePlayer().stack.add(value);
        } else if ((doubleOut &&
                this.gameState.activePlayer().score - value > 1) ||
            (!doubleOut && this.gameState.activePlayer().score - value > 0)) {
          this.gameState.activePlayer().score -= value;
          this.gameState.activePlayer().stack.add(value);
        } else {
          print("You must end with a double out");
          this.gameState.activePlayer().stack.add(0);
        }
      }
      if (this.gameState.activePlayer().stack.length % 3 == 0) {
        this.gameState.nextPlayer();
      }
    });
  }

  void undoLastValue() {
    setState(() {
      if (this.gameState.activePlayer().stack.length > 0) {
        int value = this.gameState.activePlayer().stack.removeLast();
        print('Undo value $value');
        this.gameState.activePlayer().score += value;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget generateButton(int value, [String label]) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
        child: FlatButton(
          color: Color(0x88c4c4c4),
          child: Text(label != null ? label : value.toString()),
          onPressed: () {
            substractValue(value);
          },
        ),
      ),
    );
  }

  Widget generateUndoButton() {
    return Expanded(
      flex: 1,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
        child: FlatButton(
          color: Color(0x88c4c4c4),
          child: Text("Undo"),
          onPressed: () {
            undoLastValue();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Active Game"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Row(
                children: this.gameState.nextPlayerOrder().map((index) {
                  return Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(this.gameState.getPlayer(index).name),
                          Text(
                              this.gameState.getPlayer(index).score.toString()),
                        ],
                      ));
                }).toList(),
              )),
          Expanded(
            flex: 3,
            child: Row(children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.green,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      this.gameState.activePlayer().name,
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      this
                                          .gameState
                                          .activePlayer()
                                          .score
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(children: [
                            Expanded(
                                flex: 1,
                                child:
                                    Container(child: Center(child: Text("1")))),
                            Expanded(
                                flex: 1,
                                child:
                                    Container(child: Center(child: Text("2")))),
                            Expanded(
                                flex: 1,
                                child:
                                    Container(child: Center(child: Text("3"))))
                          ]))
                    ],
                  ))
            ]),
          ),
          Expanded(
            flex: 5,
            child: ButtonBoard(substractValue, undoLastValue),
          )
        ],
      ),
    );
  }
}
