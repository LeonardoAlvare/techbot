import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/document/children/quiz/models/atempt_model.dart';
import 'package:techbot/features/document/children/quiz/models/quiz_attempt_model.dart';
import 'package:techbot/features/document/children/quiz/models/quiz_model.dart';
import 'package:techbot/features/document/children/quiz/repository/repository.dart';

class QuizRepositoryImp extends QuizRepository {
  final Dio dio;
  QuizRepositoryImp(this.dio);

  @override
  Future<QuizModel> createQuiz(int id) async {
    final response = await dio.post('${ApiUrl.baseUrl}/quiz/$id/generate');
    return QuizModel.fromJson(response.data);
  }

  @override
  Future<QuizModel> getQuiz(int id) async {
    final response = await dio.get('${ApiUrl.baseUrl}/quiz/$id');
    return QuizModel.fromJson(response.data);
  }

  @override
  Future<AttemptModel> submitAttempt(
    QuizAttemptModel attemptModel,
    int id,
  ) async {
    final response = await dio.post(
      '${ApiUrl.baseUrl}/quiz/$id/attempt',
      data: attemptModel.toJson(),
    );
    return AttemptModel.fromJson(response.data);
  }
}
