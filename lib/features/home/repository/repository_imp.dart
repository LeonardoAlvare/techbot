import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/home/models/create_subject_model.dart';
import 'package:techbot/features/home/models/subject_model.dart';
import 'package:techbot/features/home/repository/repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final Dio dio;

  HomeRepositoryImp(this.dio);

  @override
  Future<CreateSubjectModel> createSubject(
    String token,
    String name,
    String description,
  ) async {
    final response = await dio.post(
      '${ApiUrl.baseUrl}/subject/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: {'name': name, 'description': description},
    );

    return CreateSubjectModel.fromJson(response.data);
  }

  @override
  Future<List<SubjectModel>> getSubject(String token) async {
    final response = await dio.get(
      '${ApiUrl.baseUrl}/subject/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return (response.data as List)
        .map((e) => SubjectModel.fromJson(e))
        .toList();
  }
}
