import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/features/document/children/flashcard/models/flashcard_model.dart';
import 'package:techbot/features/document/children/flashcard/repository/repositorty.dart';

part 'state.dart';

class FlashcardCubit extends Cubit<FlashcardState> {
  FlashcardCubit(this.repository) : super(FlashcardInitial(Model()));

  final FlashcardRepository repository;

  Future<void> getFlashcards(int documentId) async {
    emit(FlashcardLoading(state.model));
    try {
      final flashcards = await repository.getFlashcards(documentId);
      emit(FlashcardSuccess(state.model.copyWith(flashcards: flashcards)));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(FlashcardSuccess(state.model.copyWith(flashcards: null)));
      } else {
        emit(FlashcardError(state.model, e.toString()));
      }
    } catch (e) {
      emit(FlashcardError(state.model, e.toString()));
    }
  }

  Future<void> createFlashcard(int documentId) async {
    emit(FlashcardLoading(state.model));
    try {
      final flashcard = await repository.createFlashcards(documentId);
      emit(FlashcardSuccess(state.model.copyWith(flashcards: flashcard)));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(FlashcardSuccess(state.model.copyWith(flashcards: null)));
      } else {
        emit(FlashcardError(state.model, e.toString()));
      }
    } catch (e) {
      emit(FlashcardError(state.model, e.toString()));
    }
  }
}
