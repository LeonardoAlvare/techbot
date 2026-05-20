import 'package:techbot/features/document/children/flashcard/models/flashcard_model.dart';

abstract class FlashcardRepository {
  Future<List<FlashcardModel>> getFlashcards(int id);
  Future<List<FlashcardModel>> createFlashcards(int id);
}
