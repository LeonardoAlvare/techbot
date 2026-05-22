import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/core/widgets/appbar.dart';
import 'package:techbot/features/document/children/flashcard/ui/cubit/cubit.dart';
import 'package:techbot/features/document/children/flashcard/ui/page.dart';
import 'package:techbot/features/document/children/quiz/ui/cubit/cubit.dart';
import 'package:techbot/features/document/children/quiz/ui/page.dart';
import 'package:techbot/features/document/children/summary/ui/cubit/cubit.dart';
import 'package:techbot/features/document/children/summary/ui/page.dart';
import 'package:techbot/features/document/children/view_documet/ui/cubit/cubit.dart';
import 'package:techbot/features/document/children/view_documet/ui/page.dart';
import 'package:techbot/features/document/ui/cubit/cubit.dart';

class DocumentPage extends StatelessWidget {
  final String title;
  final int documentId;
  final DocumentCubit cubit;

  const DocumentPage({
    super.key,
    required this.title,
    required this.documentId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final pages = [
      ViewDocumentPage(
        cubit: getIt<ViewDocumentCubit>(),
        documentId: documentId,
      ),
      SummaryPage(cubit: getIt<SummaryCubit>(), documentId: documentId),
      FlashcardPage(cubit: getIt<FlashcardCubit>(), documentId: documentId),
      QuizPage(cubit: getIt<QuizCubit>(), documentId: documentId),
    ];

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<DocumentCubit, DocumentState>(
        builder: (context, state) {
          print('documentId: $documentId');
          return Scaffold(
            appBar: CustomAppBar(
              title: title,
              onBack: () => Navigator.pop(context),
              centerTitle: true,
            ),
            body: IndexedStack(index: state.model.index, children: pages),
            bottomNavigationBar: _StyledBottomNav(
              currentIndex: state.model.index,
              onTap: (index) =>
                  context.read<DocumentCubit>().changeIndex(index),
            ),
          );
        },
      ),
    );
  }
}

class _StyledBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _StyledBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.description_outlined,
              label: 'Documento',
              isActive: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: Icons.fact_check_outlined,
              label: 'Resumen',
              isActive: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavItem(
              icon: Icons.style_outlined,
              label: 'Flashcards',
              isActive: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavItem(
              icon: Icons.quiz_outlined,
              label: 'Quiz',
              isActive: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  static const _purple = Color(0xFF7B4FE0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? _purple : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? Colors.white : const Color(0xFF555555),
            ),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
