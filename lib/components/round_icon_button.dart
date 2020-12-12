import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({
    @required this.icon,
    @required this.onPress,
    @required this.color,
  });

  final IconData icon;
  final Function onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      onPressed: onPress,
      shape: CircleBorder(),
      fillColor: color,
      constraints: BoxConstraints.tightFor(
        width: 72.0,
        height: 72.0,
      ),
      child: Icon(icon),
    );
  }
}
