import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techbot/core/theme/colors.dart';

class Toast extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final ToastGravity gravity;
  final int timeInSecForIosWeb;
  final double fontSize;

  const Toast({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.gravity = ToastGravity.BOTTOM,
    this.timeInSecForIosWeb = 2,
    this.fontSize = 14,
  });

  /// Muestra el toast usando fluttertoast
  static void show({
    required BuildContext context,
    required String text,
    Color? backgroundColor,
    Color? textColor,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 2,
    double fontSize = 14,
  }) {
    final fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor ?? CustomColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      toastDuration: Duration(seconds: timeInSecForIosWeb),
      gravity: gravity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
