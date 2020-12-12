import 'package:flutter/material.dart';

class RectangularIconButton extends StatelessWidget {
  RectangularIconButton(
      {@required this.text,
      @required this.icon,
      @required this.onPress,
      @required this.color});

  final String text;
  final IconData icon;
  final Function onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      onPressed: onPress,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.all(10.0),
      fillColor: color,
      constraints: BoxConstraints.tightFor(
        width: 84.0,
        height: 64.0,
      ),
      child: Column(
        children: <Widget>[
          Icon(icon),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
