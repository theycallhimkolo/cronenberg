import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UndoButton extends StatelessWidget {
  VoidCallback target;

  UndoButton(VoidCallback target) {
    this.target = target;
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
          child: Text("Undo"),
          onPressed: () {
            target();
          },
        ),
      ),
    );
  }
}
