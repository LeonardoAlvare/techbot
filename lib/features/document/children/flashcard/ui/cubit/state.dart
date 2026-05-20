part of 'cubit.dart';

sealed class FlashcardState extends Equatable {
  final Model model;
  const FlashcardState(this.model);

  @override
  List<Object> get props => [model];
}

final class FlashcardInitial extends FlashcardState {
  const FlashcardInitial(super.model);
}

final class FlashcardLoading extends FlashcardState {
  const FlashcardLoading(super.model);
}

final class FlashcardSuccess extends FlashcardState {
  const FlashcardSuccess(super.model);
}

final class FlashcardError extends FlashcardState {
  final String message;
  const FlashcardError(super.model, this.message);
}

class Model extends Equatable {
  final List<FlashcardModel>? flashcards;

  const Model({this.flashcards});

  Model copyWith({List<FlashcardModel>? flashcards}) =>
      Model(flashcards: flashcards ?? this.flashcards);

  @override
  List<Object> get props => [flashcards ?? []];
}
