import 'package:flutter/material.dart';
import 'package:rollr/constants.dart';

class ResultIconButton extends StatelessWidget {
  final Results result;

  ResultIconButton({@required this.result});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        print("Nothing to do, may be a callback to delete this execution");
      },
      elevation: 6.0,
      shape: CircleBorder(),
      fillColor: resultColorList[result],
      constraints: BoxConstraints.tightFor(
        width: 36.0,
        height: 36.0,
      ),
      child: Icon(
        resultIconList[result],
        color: Colors.white,
      ),
    );
  }
}
