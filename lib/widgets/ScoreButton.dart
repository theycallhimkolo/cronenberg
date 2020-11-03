import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreButton extends StatelessWidget {
  Function target;
  int value;
  String label;

  ScoreButton(Function target, int value, [String label]) {
    this.target = target;
    this.value = value;
    if (label != null) {
      this.label = label;
    } else {
      this.label = value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
        child: FlatButton(
          color: Color(0x88c4c4c4),
          child: Text(label),
          onPressed: () {
            target(value);
          },
        ),
      ),
    );
  }
}
