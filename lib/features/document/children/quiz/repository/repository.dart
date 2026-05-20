import 'package:techbot/features/document/children/quiz/models/atempt_model.dart';
import 'package:techbot/features/document/children/quiz/models/quiz_attempt_model.dart';
import 'package:techbot/features/document/children/quiz/models/quiz_model.dart';

abstract class QuizRepository {
  Future<QuizModel> getQuiz(int id);
  Future<QuizModel> createQuiz(int id);
  Future<AttemptModel> submitAttempt(QuizAttemptModel attemptModel, int id);
}
