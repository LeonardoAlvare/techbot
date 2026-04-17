import 'package:flutter/material.dart';
import 'package:techbot/core/theme/colors.dart';

class BackgroundAuth extends StatelessWidget {
  const BackgroundAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, CustomColors.lavender],
        ),
      ),
    );
  }
}
