import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/document/children/flashcard/models/flashcard_model.dart';
import 'package:techbot/features/document/children/flashcard/repository/repositorty.dart';

class FlashcardRepositoryImp implements FlashcardRepository {
  final Dio dio;
  FlashcardRepositoryImp(this.dio);

  @override
  Future<List<FlashcardModel>> createFlashcards(int id) async {
    final response = await dio.post(
      '${ApiUrl.baseUrl}/flashcards/generate/$id',
    );
    return (response.data as List)
        .map((e) => FlashcardModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<FlashcardModel>> getFlashcards(int id) async {
    final response = await dio.get('${ApiUrl.baseUrl}/flashcards/$id');
    return (response.data as List)
        .map((e) => FlashcardModel.fromJson(e))
        .toList();
  }
}
