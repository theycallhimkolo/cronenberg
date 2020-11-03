import 'package:cronenberg/widgets/ScoreButton.dart';
import 'package:cronenberg/widgets/UndoButton.dart';
import 'package:flutter/cupertino.dart';

class ButtonBoard extends StatelessWidget {
  Function(int value, [int mult]) substract;
  VoidCallback undo;

  ButtonBoard(Function(int value, [int mult]) substract, VoidCallback undo) {
    this.substract = substract;
    this.undo = undo;
  }

  Widget buttonRow(List<int> values) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: values.map((element) {
          return ScoreButton(substract, element);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buttonRow([1, 2, 3, 4, 5]),
      buttonRow([6, 7, 8, 9, 10]),
      buttonRow([6, 7, 8, 9, 10]),
      buttonRow([16, 17, 18, 19, 20]),
      Expanded(
        flex: 1,
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          ScoreButton(substract, 25),
          ScoreButton(substract, 50),
          ScoreButton(substract, 0, "Missed"),
          UndoButton(undo),
        ]),
      )
    ]);
  }
}
