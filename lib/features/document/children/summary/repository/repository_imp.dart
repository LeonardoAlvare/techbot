import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/document/children/summary/models/summary_model.dart';
import 'package:techbot/features/document/children/summary/repository/repository.dart';

class SummaryRepositoryImp extends SummaryRepository {
  final Dio dio;
  SummaryRepositoryImp(this.dio);

  @override
  Future<SummaryModel> createSummary(int id) async {
    final response = await dio.post('${ApiUrl.baseUrl}/summary/$id');
    return SummaryModel.fromJson(response.data);
  }

  @override
  Future<SummaryModel> getSummary(int id) async {
    final response = await dio.get('${ApiUrl.baseUrl}/summary/$id');
    return SummaryModel.fromJson(response.data);
  }
}
