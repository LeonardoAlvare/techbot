import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/features/document/children/flashcard/ui/cubit/cubit.dart';
import 'package:techbot/features/document/widgets/button_add.dart';

class FlashcardPage extends StatelessWidget {
  final int documentId;
  final FlashcardCubit cubit;

  const FlashcardPage({
    super.key,
    required this.documentId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: BlocProvider.value(
        value: cubit..getFlashcards(documentId),
        child: _Content(documentId),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final int documentId;
  const _Content(this.documentId);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashcardCubit, FlashcardState>(
      builder: (context, state) {
        if (state is FlashcardLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is FlashcardError) {
          return Center(child: Text(state.message));
        }

        return Stack(
          children: [
            state.model.flashcards?.isNotEmpty == true
                ? ListView.separated(
                    itemCount: state.model.flashcards?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final flashcards = state.model.flashcards;
                      final flashcard = flashcards?[index];
                      final isLast = index == (flashcards?.length ?? 0) - 1;

                      final card = _Cards(
                        title: flashcard?.question ?? '',
                        content: flashcard?.answer ?? '',
                      );

                      return isLast
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 60),
                              child: card,
                            )
                          : card;
                    },
                  )
                : const Center(child: Text('No hay cartas cargadas')),
            Positioned(
              bottom: 0,
              right: 0,
              child: ButtonAdd(
                onPressed: () =>
                    context.read<FlashcardCubit>().createFlashcard(documentId),
                text: 'Nuevas Cartas',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Cards extends StatelessWidget {
  final String title;
  final String content;
  const _Cards({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: CustomColors.lavender.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: CustomColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(),
          Text(
            content,
            style: TextStyle(
              color: CustomColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
