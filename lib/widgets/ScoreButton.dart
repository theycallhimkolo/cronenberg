import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cronenberg/widgets/ButtonBoard.dart';

class ScoreButton extends StatefulWidget {
  ButtonBoardState parent;
  int value;
  String label;

  ScoreButton(ButtonBoardState parent, int value, [String label]) {
    this.parent = parent;
    this.value = value;
    if (label != null) {
      this.label = label;
    } else {
      this.label = value.toString();
    }
  }

  @override
  ScoreButtonState createState() => ScoreButtonState(parent, value, label);
}

class ScoreButtonState extends State<ScoreButton> {
  int value;
  String label;
  ButtonBoardState parent;

  GlobalKey _positionButton = GlobalKey();

  double y = 0;

  ScoreButtonState(ButtonBoardState parent, int value, String label) {
    this.parent = parent;
    this.value = value;
    this.label = label;
  }

  @override
  void initState() {
    super.initState();
  }

  setDragActive(bool val) {
    this.parent.setState(() {
      this.parent.dragActive = val;
    });
  }

  double getHeight() {
    try {
      final RenderBox renderBoxContainer =
          _positionButton.currentContext.findRenderObject();
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
        },
        onVerticalDragEnd: (details) {
          this.setDragActive(false);
          if (y > this.getHeight()) {
            this.parent.substract(this.value, 3);
          } else if (y < this.getHeight() * -1) {
            this.parent.substract(this.value, 2);
          }
          y = 0;
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                key: _positionButton,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1)),
                child: FlatButton(
                    color: Color(0x88c4c4c4),
                    child: Text(label),
                    onPressed: () {
                      this.parent.substract(value);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
