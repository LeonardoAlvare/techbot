import 'package:flutter/material.dart';

class CTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;

  const CTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.fontSize = 13.0,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
