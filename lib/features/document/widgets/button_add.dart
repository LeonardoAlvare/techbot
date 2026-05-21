import 'package:flutter/material.dart';
import 'package:techbot/core/theme/colors.dart';

class ButtonAdd extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const ButtonAdd({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        elevation: 4,
        shadowColor: CustomColors.primary.withOpacity(0.4),
      ),
    );
  }
}
