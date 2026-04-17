import 'package:flutter/material.dart';
import 'package:techbot/core/theme/colors.dart';

class SubjectCard extends StatelessWidget {
  final String name;
  final int documentCount;
  final VoidCallback? onTap;

  const SubjectCard({
    super.key,
    required this.name,
    required this.documentCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CustomColors.lavender, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: CustomColors.bgLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.menu_book_rounded,
                color: CustomColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(
                color: CustomColors.primaryStrong,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$documentCount Documentos',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
