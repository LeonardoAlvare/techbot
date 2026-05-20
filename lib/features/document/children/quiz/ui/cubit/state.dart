part of 'cubit.dart';

sealed class QuizState extends Equatable {
  final Model model;

  const QuizState(this.model);

  @override
  List<Object> get props => [model];
}

final class QuizInitial extends QuizState {
  const QuizInitial(super.model);
}

final class QuizLoading extends QuizState {
  const QuizLoading(super.model);
}

final class QuizSuccess extends QuizState {
  const QuizSuccess(super.model);
}

final class QuizError extends QuizState {
  final String message;

  const QuizError(super.model, this.message);
}

class Model extends Equatable {
  final QuizModel? quiz;
  final int currentIndex;
  final Map<int, String> selectedAnswers;
  final AttemptModel? attemptResult;

  const Model({
    this.quiz,
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.attemptResult,
  });

  bool get isLastQuestion => currentIndex == (quiz?.questions?.length ?? 1) - 1;

  bool get isFinished => attemptResult != null;

  /// Respuesta seleccionada para la pregunta actual
  String? get currentSelectedOption {
    final questionId = quiz?.questions?[currentIndex].id;
    if (questionId == null) return null;
    return selectedAnswers[questionId];
  }

  /// Si la pregunta actual ya fue respondida
  bool get currentQuestionAnswered => currentSelectedOption != null;

  /// Si la respuesta actual es correcta
  bool? get currentAnswerIsCorrect {
    if (!currentQuestionAnswered) return null;
    final question = quiz?.questions?[currentIndex];
    return currentSelectedOption == question?.correctOption;
  }

  Model copyWith({
    QuizModel? quiz,
    int? currentIndex,
    Map<int, String>? selectedAnswers,
    AttemptModel? attemptResult,
    bool clearAttemptResult = false,
  }) => Model(
    quiz: quiz ?? this.quiz,
    currentIndex: currentIndex ?? this.currentIndex,
    selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    attemptResult: clearAttemptResult
        ? null
        : attemptResult ?? this.attemptResult,
  );

  @override
  List<Object> get props => [
    quiz ?? {},
    currentIndex,
    selectedAnswers,
    attemptResult ?? {},
  ];
}
