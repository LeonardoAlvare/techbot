import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/features/document/children/quiz/models/atempt_model.dart';
import 'package:techbot/features/document/children/quiz/models/quiz_attempt_model.dart'
    as attempt;
import 'package:techbot/features/document/children/quiz/models/quiz_model.dart';
import 'package:techbot/features/document/children/quiz/repository/repository.dart';

part 'state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.repository) : super(QuizInitial(const Model()));

  final QuizRepository repository;

  Future<void> getQuiz(int id) async {
    emit(QuizLoading(state.model));
    try {
      final quiz = await repository.getQuiz(id);
      emit(QuizSuccess(state.model.copyWith(quiz: quiz)));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(QuizSuccess(state.model.copyWith(quiz: null)));
      } else {
        emit(QuizError(state.model, e.toString()));
      }
    } catch (e) {
      emit(QuizError(state.model, e.toString()));
    }
  }

  Future<void> createQuiz(int documentId) async {
    emit(QuizLoading(state.model));
    try {
      final quiz = await repository.createQuiz(documentId);
      emit(QuizSuccess(state.model.copyWith(quiz: quiz)));
    } catch (e) {
      emit(QuizError(state.model, e.toString()));
    }
  }

  /// Guarda la respuesta seleccionada — NO avanza el índice
  void selectAnswer(int questionId, String selectedOption) {
    // Si ya respondió esta pregunta, no hace nada
    if (state.model.selectedAnswers.containsKey(questionId)) return;

    final updatedAnswers = Map<int, String>.from(state.model.selectedAnswers)
      ..[questionId] = selectedOption;

    emit(QuizSuccess(state.model.copyWith(selectedAnswers: updatedAnswers)));
  }

  /// Avanza a la siguiente pregunta (llamado desde el botón)
  void nextQuestion() {
    if (state.model.isLastQuestion) return;
    emit(
      QuizSuccess(
        state.model.copyWith(currentIndex: state.model.currentIndex + 1),
      ),
    );
  }

  Future<void> submitQuiz(int quizId, int timeTaken) async {
    emit(QuizLoading(state.model));
    try {
      final answers = state.model.selectedAnswers.entries
          .map(
            (e) => attempt.Answer(questionId: e.key, selectedOption: e.value),
          )
          .toList();

      final attemptModel = attempt.QuizAttemptModel(
        answers: answers,
        timeTaken: timeTaken,
      );

      final result = await repository.submitAttempt(attemptModel, quizId);
      emit(QuizSuccess(state.model.copyWith(attemptResult: result)));
    } catch (e) {
      emit(QuizError(state.model, e.toString()));
    }
  }

  void resetQuiz() {
    emit(
      QuizSuccess(
        state.model.copyWith(
          currentIndex: 0,
          selectedAnswers: {},
          clearAttemptResult: true,
        ),
      ),
    );
  }
}
