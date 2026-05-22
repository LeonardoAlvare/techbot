import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/prediction/models/prediction_model.dart';
import 'package:techbot/features/prediction/repository/repository.dart';

class PredictionRepositoryImp extends PredictionRepository {
  final Dio dio;
  PredictionRepositoryImp(this.dio);

  @override
  Future<PredictionModel> predict() async {
    final response = await dio.get('${ApiUrl.baseUrl}/prediction');
    return PredictionModel.fromJson(response.data);
  }
}
