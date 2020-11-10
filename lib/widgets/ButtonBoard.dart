import 'package:cronenberg/widgets/ScoreButton.dart';
import 'package:cronenberg/widgets/UndoButton.dart';
import 'package:flutter/cupertino.dart';

class ButtonBoard extends StatefulWidget {
  Function(int value, [int mult]) substract;
  VoidCallback undo;

  ButtonBoard(Function(int value, [int mult]) substract, VoidCallback undo) {
    this.substract = substract;
    this.undo = undo;
  }

  @override
  ButtonBoardState createState() => ButtonBoardState(substract, undo);
}

class ButtonBoardState extends State<ButtonBoard> {
  Function(int value, [int mult]) substract;
  VoidCallback undo;
  bool dragActive = false;
  double posLeft = 0;
  double posTop = 0;
  GlobalKey _scoreBoard = GlobalKey();

  // The following value represent the size of the double and tripple floating buttons
  double buttonSize = 60.0; // TODO: calculate dynamic
  double minScale = 0.3;
  double maxScale = 1.0;
  double scaleButtonX2;
  double scaleButtonX3;

  ButtonBoardState(
      Function(int value, [int mult]) substract, VoidCallback undo) {
    this.substract = substract;
    this.undo = undo;
    this.scaleButtonX2 = this.minScale;
    this.scaleButtonX3 = this.minScale;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buttonRow(List<int> values) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: values.map((element) {
          return ScoreButton(this, element);
        }).toList(),
      ),
    );
  }

  Offset getPosition() {
    try {
      final RenderBox renderBoxContainer =
          _scoreBoard.currentContext.findRenderObject();
      return renderBoxContainer.localToGlobal(Offset.zero);
    } catch (e) {
      return Offset(0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(key: _scoreBoard, children: [
      Column(children: [
        buttonRow([1, 2, 3, 4, 5]),
        buttonRow([6, 7, 8, 9, 10]),
        buttonRow([11, 12, 13, 14, 15]),
        buttonRow([16, 17, 18, 19, 20]),
        Expanded(
          flex: 1,
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ScoreButton(this, 25),
            ScoreButton(this, 50),
            ScoreButton(this, 0, "Missed"),
            UndoButton(undo),
          ]),
        )
      ]),
      if (this.dragActive)
        Positioned(
          left: posLeft - getPosition().dx - buttonSize * scaleButtonX2 / 2,
          top: posTop - getPosition().dy - buttonSize * scaleButtonX2 / 2,
          child: Transform.translate(
              offset: Offset(0.0, -50),
              child: Image(
                image: AssetImage(
                  "assets/images/x2.png",
                ),
                height: buttonSize * scaleButtonX2,
                width: buttonSize * scaleButtonX2,
              )),
        ),
      if (this.dragActive)
        Positioned(
          left: posLeft - getPosition().dx - buttonSize * scaleButtonX3 / 2,
          top: posTop - getPosition().dy - buttonSize * scaleButtonX3 / 2,
          child: Transform.translate(
              offset: Offset(0.0, 50),
              child: Image(
                image: AssetImage("assets/images/x3.png"),
                height: buttonSize * scaleButtonX3,
                width: buttonSize * scaleButtonX3,
              )),
        )
    ]);
  }
}
