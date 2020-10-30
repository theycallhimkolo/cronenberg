import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final int startScore = 501;

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  var score = 501;

  void substractValue(int value) {
    setState(() {
      score -= value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget generateButton(var value) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: 1
            )
        ),
        child: FlatButton(
          color: Color(0x88c4c4c4),
          child: Text(value.toString()),
          onPressed: () {substractValue(value);},
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
            flex: 3,
            child: Container(
                color: Colors.green,
                child: Center (
                  child: Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [1, 2, 3, 4, 5].map((element) {
                return generateButton(element);
              }).toList(),
            ),
          ),Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [6 , 7, 8, 9, 10].map((element) {
                return generateButton(element);
              }).toList(),
            ),
          ),Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [11, 12, 13, 14, 15].map((element) {
                return generateButton(element);
              }).toList(),
            ),
          ),Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [16, 17, 18, 19, 20].map((element) {
                return generateButton(element);
              }).toList(),
            ),
          ),Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [25, 50, "Missed", "Undo"].map((element) {
                return generateButton(element);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
