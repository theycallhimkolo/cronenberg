import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreButton extends StatefulWidget{
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
  ScoreButtonState createState() => ScoreButtonState(target, value, label);
}

class ScoreButtonState extends State<ScoreButton> {
  Function target;
  int value;
  String label;

  GlobalKey _positionButton = GlobalKey();

  bool dragActive = false;
  double y = 0;

  ScoreButtonState(Function target, int value, String label) {
    this.target = target;
    this.value = value;
    this.label = label;
  }

  @override
  void initState() {
    super.initState();
  }

  setDragActive(bool val) {
    setState(() {
      this.dragActive = val;
    });
  }

  double getHeight() {
    try {
      final RenderBox renderBoxContainer = _positionButton.currentContext.findRenderObject();
    return renderBoxContainer.size.height;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onVerticalDragStart: (details) {
          this.setDragActive(true);
        },
        onVerticalDragUpdate: (details) {
          y += details.primaryDelta;
          print(y);
        },
        onVerticalDragEnd: (details) {
          this.setDragActive(false);
          if (y > this.getHeight()) {
            target(this.value, 3);
          } else if (y < this.getHeight() * -1) {
            target(this.value, 2);
          }
          y = 0;
        },
        child: Stack(
          children: [
            Container(
              key: _positionButton,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1)),
              child: Transform.translate(
                offset: Offset(0.0, min(y, this.getHeight())),
                child: FlatButton(
                    color: Color(0x88c4c4c4),
                    child: Text(label),
                    onPressed: () {
                      target(value);
                    }),
              ),
            ),
            if (this.dragActive) Transform.translate(
              offset: Offset(0.0, -25),
              child: Text("Double")
              ),
            if (this.dragActive) Transform.translate(
              offset: Offset(0.0, 50),
              child: Text("Triple")
              ),
          ],
        ),
      ),
    );
  }
}
