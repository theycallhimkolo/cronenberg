import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreButton extends StatelessWidget {
  Function target;
  int value;
  String label;
  int position;
  GlobalKey _positionButton = GlobalKey();

  double y = 0;
  bool dragging = true;

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
      child: GestureDetector(
        onVerticalDragStart: (details) {},
        onVerticalDragUpdate: (details) {
          y += details.primaryDelta;
        },
        onVerticalDragEnd: (details) {
          final RenderBox renderBoxContainer =
              _positionButton.currentContext.findRenderObject();
          double height = renderBoxContainer.size.height;
          if (y > height) {
            target(value, 3);
          } else if (y < height * -1) {
            target(value, 2);
          }
          y = 0;
        },
        child: Container(
          key: _positionButton,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
          child: FlatButton(
              color: Color(0x88c4c4c4),
              child: Text(label),
              onPressed: () {
                target(value);
              }),
        ),
      ),
    );
  }
}
