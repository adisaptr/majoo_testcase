import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final VoidCallback onPressed;
  final bool isSecondary;
  const CustomButton({
    Key? key,
    required this.text,
    this.height = 40,
    required this.onPressed,
    this.isSecondary = false,
  }) : super(key: key);

  Color _color(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final color = isSecondary ? Colors.transparent : primaryColor;
    return isSecondary
        ? primaryColor
        : color.computeLuminance() > 0.5
            ? Colors.black
            : Colors.white;
  }

  Color _colorButton(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return isSecondary ? Colors.transparent : primaryColor;
  }

  Widget _label(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(color: _color(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: _label(context),
      style: ElevatedButton.styleFrom(
          primary: _colorButton(context),
          fixedSize: Size(double.maxFinite, height),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
