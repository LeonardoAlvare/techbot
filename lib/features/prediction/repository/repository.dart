import 'package:techbot/features/prediction/models/prediction_model.dart';

abstract class PredictionRepository {
  Future<PredictionModel> predict();
}
