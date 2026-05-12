import 'dart:io';

import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/view_subject/models/document_model.dart';
import 'package:techbot/features/view_subject/repository/repository.dart';

final class ViewSubjectRepositoryImp implements ViewSubjectRepository {
  final Dio dio;

  ViewSubjectRepositoryImp(this.dio);

  @override
  Future<List<DocumentModel>> getSubjectDocuments(int idSubject) async {
    final response = await dio.get(
      '${ApiUrl.baseUrl}/subject/$idSubject/documents',
    );

    final data = (response.data as List).first;

    return (data['documents'] as List)
        .map((e) => DocumentModel.fromJson(e))
        .toList();
  }

  @override
  Future<DocumentModel> createDocument(
    String title,
    File file,
    int idSubject,
  ) async {
    final formData = FormData.fromMap({
      'title': title,
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final response = await dio.post(
      '${ApiUrl.baseUrl}/documents/$idSubject',
      data: formData,
    );

    return DocumentModel.fromJson(response.data);
  }
}
