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
      if (val) {
        Offset o = getPosition();
        Size s = getSize();
        this.parent.posLeft = o.dx + s.width / 2;
        this.parent.posTop = o.dy + s.height / 2;
      } else {
        this.parent.posLeft = 0;
        this.parent.posTop = 0;
      }
    });
  }

  Size getSize() {
    try {
      final RenderBox renderBoxContainer =
          _positionButton.currentContext.findRenderObject();
      return renderBoxContainer.size;
    } catch (e) {
      return Size(0, 0);
    }
  }

  Offset getPosition() {
    try {
      final RenderBox renderBoxContainer =
          _positionButton.currentContext.findRenderObject();
      return renderBoxContainer.localToGlobal(Offset.zero);
    } catch (e) {
      return Offset(0, 0);
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
          double scale =
              1 - (this.getSize().height - y.abs()) / this.getSize().height;
          if (scale > this.parent.maxScale) {
            scale = this.parent.maxScale;
          }
          if (scale < this.parent.minScale) {
            scale = this.parent.minScale;
          }
          this.parent.setState(() {
            if (y > 0.0) {
              this.parent.scaleButtonX3 = scale;
            } else {
              this.parent.scaleButtonX2 = scale;
            }
          });
        },
        onVerticalDragEnd: (details) {
          this.setDragActive(false);
          if (y > this.getSize().height) {
            this.parent.substract(this.value, 3);
          } else if (y < this.getSize().height * -1) {
            this.parent.substract(this.value, 2);
          }
          this.parent.setState(() {
            this.parent.scaleButtonX3 = this.parent.minScale;
            this.parent.scaleButtonX2 = this.parent.minScale;
          });
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
