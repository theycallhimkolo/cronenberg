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
  double scaleButton = 0.7;
  double buttonSize = 40.0; // TODO: calculate dynamic

  ButtonBoardState(
      Function(int value, [int mult]) substract, VoidCallback undo) {
    this.substract = substract;
    this.undo = undo;
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
          left: posLeft - getPosition().dx - buttonSize * scaleButton / 2,
          top: posTop - getPosition().dy - buttonSize * scaleButton / 2,
          child: Transform.translate(
              offset: Offset(0.0, -50),
              child: Image(
                image: AssetImage(
                  "assets/images/x2.png",
                ),
                height: buttonSize * scaleButton,
                width: buttonSize * scaleButton,
              )),
        ),
      if (this.dragActive)
        Positioned(
          left: posLeft - getPosition().dx - buttonSize * scaleButton / 2,
          top: posTop - getPosition().dy - buttonSize * scaleButton / 2,
          child: Transform.translate(
              offset: Offset(0.0, 50),
              child: Image(
                image: AssetImage("assets/images/x3.png"),
                height: buttonSize * scaleButton,
                width: buttonSize * scaleButton,
              )),
        )
    ]);
  }
}
