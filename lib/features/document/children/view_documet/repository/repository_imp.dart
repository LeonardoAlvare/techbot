import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/document/children/view_documet/repository/repository.dart';

class ViewDocumentRepositoryImp implements ViewDocumentRepository {
  final Dio dio;
  ViewDocumentRepositoryImp(this.dio);

  @override
  Future<List<int>> viewDocument(int id) async {
    final response = await dio.get(
      '${ApiUrl.baseUrl}/documents/$id/file',
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data;
  }
}
