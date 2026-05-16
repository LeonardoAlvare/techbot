part of 'cubit.dart';

sealed class HomeState extends Equatable {
  final Model model;

  const HomeState(this.model);

  @override
  List<Object> get props => [model];
}

final class HomeInitial extends HomeState {
  const HomeInitial(super.model);
}

final class HomeLoading extends HomeState {
  const HomeLoading(super.model);
}

final class HomeSuccess extends HomeState {
  const HomeSuccess(super.model);
}

final class HomeError extends HomeState {
  const HomeError(super.model);
}

final class UpdateInput extends HomeState {
  const UpdateInput(super.model);
}

final class SubjectCreatedSuccess extends HomeState {
  const SubjectCreatedSuccess(super.model);
}

final class SubjectCreatedError extends HomeState {
  const SubjectCreatedError(super.model);
}

class Model extends Equatable {
  final String name;
  final String description;
  final List<SubjectModel>? subjects;

  const Model({
    this.name = '',
    this.description = '',
    this.subjects = const [],
  });

  Model copyWith({
    String? name,
    String? description,
    List<SubjectModel>? subjects,
  }) => Model(
    name: name ?? this.name,
    description: description ?? this.description,
    subjects: subjects ?? this.subjects,
  );

  @override
  List<Object> get props => [name, description, subjects ?? []];
}
