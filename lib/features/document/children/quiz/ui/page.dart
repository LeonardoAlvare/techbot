import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/features/document/children/quiz/ui/cubit/cubit.dart';

class QuizPage extends StatelessWidget {
  final int documentId;
  final QuizCubit cubit;
  const QuizPage({super.key, required this.documentId, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: BlocProvider.value(
        value: cubit..getQuiz(documentId),
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
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is QuizLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is QuizError) {
          return Center(child: Text(state.message));
        }

        if (state.model.quiz == null) {
          return Stack(
            children: [
              const Center(child: Text('No hay quiz disponible')),
              Positioned(
                bottom: 0,
                right: 0,
                child: _NewQuizButton(documentId: documentId),
              ),
            ],
          );
        }

        if (state.model.isFinished) {
          return Stack(
            children: [
              _ResultsView(model: state.model),
              Positioned(
                bottom: 0,
                right: 0,
                child: _NewQuizButton(documentId: documentId),
              ),
            ],
          );
        }

        return _QuizView(model: state.model);
      },
    );
  }
}

// ─────────────────────────────────────────────
// Botón nuevo quiz
// ─────────────────────────────────────────────

class _NewQuizButton extends StatelessWidget {
  final int documentId;
  const _NewQuizButton({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.read<QuizCubit>().createQuiz(documentId),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Nuevo Quiz',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
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

// ─────────────────────────────────────────────
// Vista del quiz en curso
// ─────────────────────────────────────────────

class _QuizView extends StatelessWidget {
  final Model model;
  const _QuizView({required this.model});

  @override
  Widget build(BuildContext context) {
    final questions = model.quiz!.questions!;
    final question = questions[model.currentIndex];
    final totalQuestions = questions.length;
    final progress = (model.currentIndex + 1) / totalQuestions;
    final isLast = model.isLastQuestion;
    final answered = model.currentQuestionAnswered;
    final isCorrect = model.currentAnswerIsCorrect;

    return Column(
      children: [
        // ── Progreso ─────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pregunta ${model.currentIndex + 1} de $totalQuestions',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Text(
              '${(progress * 100).toInt()}% completado',
              style: TextStyle(fontSize: 13, color: Colors.grey[500]),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.primary),
          ),
        ),
        const SizedBox(height: 24),

        // ── Pregunta y opciones ──────────────
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.quiz!.title != null)
                    Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            model.quiz!.title!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[500],
                              letterSpacing: 0.8,
                            ),
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 14),
                  Text(
                    question.questionText ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Opciones
                  ...?question.options?.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    const labels = ['A', 'B', 'C', 'D', 'E'];
                    final label = labels[index % labels.length];
                    final selected =
                        model.currentSelectedOption == option.optionText;
                    final isCorrectOption =
                        option.optionText == question.correctOption;

                    return _OptionTile(
                      label: label,
                      optionText: option.optionText ?? '',
                      selected: selected,
                      answered: answered,
                      isCorrectOption: isCorrectOption,
                      onTap: answered
                          ? null
                          : () => context.read<QuizCubit>().selectAnswer(
                              question.id!,
                              option.optionText!,
                            ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),

        // ── Botón siguiente / enviar ─────────
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: answered
                ? () {
                    if (isLast) {
                      context.read<QuizCubit>().submitQuiz(model.quiz!.id!, 0);
                    } else {
                      context.read<QuizCubit>().nextQuestion();
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: answered && isCorrect == false
                  ? Colors.red[400]
                  : CustomColors.primary,
              disabledBackgroundColor: Colors.grey[200],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: answered ? 4 : 0,
              shadowColor: CustomColors.primary.withOpacity(0.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLast ? 'Enviar Quiz' : 'Siguiente Pregunta',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: answered ? Colors.white : Colors.grey[400],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isLast ? Icons.send_rounded : Icons.arrow_forward_rounded,
                  size: 18,
                  color: answered ? Colors.white : Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Tile de opción con feedback visual
// ─────────────────────────────────────────────

class _OptionTile extends StatelessWidget {
  final String label;
  final String optionText;
  final bool selected;
  final bool answered;
  final bool isCorrectOption;
  final VoidCallback? onTap;

  const _OptionTile({
    required this.label,
    required this.optionText,
    required this.selected,
    required this.answered,
    required this.isCorrectOption,
    required this.onTap,
  });

  // Color del borde y fondo según el estado
  Color _borderColor() {
    if (!answered) {
      return selected ? CustomColors.primary : Colors.grey[300]!;
    }
    if (selected && isCorrectOption) return Colors.green;
    if (selected && !isCorrectOption) return Colors.red;
    if (!selected && isCorrectOption) return CustomColors.primary;
    return Colors.grey[300]!;
  }

  Color _backgroundColor() {
    if (!answered) {
      return selected
          ? CustomColors.primary.withOpacity(0.08)
          : Colors.transparent;
    }
    if (selected && isCorrectOption) return Colors.green.withOpacity(0.08);
    if (selected && !isCorrectOption) return Colors.red.withOpacity(0.08);
    if (!selected && isCorrectOption)
      return CustomColors.primary.withOpacity(0.08);
    return Colors.transparent;
  }

  Color _circleColor() {
    if (!answered) {
      return selected ? CustomColors.primary : Colors.grey[100]!;
    }
    if (selected && isCorrectOption) return Colors.green;
    if (selected && !isCorrectOption) return Colors.red;
    if (!selected && isCorrectOption) return CustomColors.primary;
    return Colors.grey[100]!;
  }

  Color _labelColor() {
    if (!answered) {
      return selected ? Colors.white : Colors.grey[600]!;
    }
    if (selected || isCorrectOption) return Colors.white;
    return Colors.grey[600]!;
  }

  Color _textColor() {
    if (!answered) {
      return selected ? CustomColors.primary : Colors.black87;
    }
    if (selected && isCorrectOption) return Colors.green;
    if (selected && !isCorrectOption) return Colors.red;
    if (!selected && isCorrectOption) return CustomColors.primary;
    return Colors.black87;
  }

  IconData? _trailingIcon() {
    if (!answered) return selected ? Icons.check_circle : null;
    if (selected && isCorrectOption) return Icons.check_circle;
    if (selected && !isCorrectOption) return Icons.cancel;
    if (!selected && isCorrectOption) return Icons.check_circle;
    return null;
  }

  Color? _trailingColor() {
    if (!answered) return selected ? CustomColors.primary : null;
    if (selected && isCorrectOption) return Colors.green;
    if (selected && !isCorrectOption) return Colors.red;
    if (!selected && isCorrectOption) return CustomColors.primary;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: _backgroundColor(),
          border: Border.all(
            color: _borderColor(),
            width: selected || (answered && isCorrectOption) ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _circleColor(),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _labelColor(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: (selected || (answered && isCorrectOption))
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: _textColor(),
                ),
              ),
            ),
            if (_trailingIcon() != null)
              Icon(_trailingIcon(), color: _trailingColor(), size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Vista de resultados
// ─────────────────────────────────────────────

class _ResultsView extends StatelessWidget {
  final Model model;
  const _ResultsView({required this.model});

  @override
  Widget build(BuildContext context) {
    final result = model.attemptResult!;

    return Center(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.only(bottom: 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.primary.withOpacity(0.1),
                border: Border.all(color: CustomColors.primary, width: 3),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${result.score ?? 0}%',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primary,
                    ),
                  ),
                  Text(
                    'Puntaje',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '¡Quiz completado!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${result.correctAnswers} de ${result.totalQuestions} respuestas correctas',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
