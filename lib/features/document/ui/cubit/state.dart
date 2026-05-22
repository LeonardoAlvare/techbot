part of 'cubit.dart';

sealed class DocumentState extends Equatable {
  final Model model;
  const DocumentState(this.model);

  @override
  List<Object> get props => [model];
}

final class DocumentInitial extends DocumentState {
  const DocumentInitial(super.model);
}

class Model extends Equatable {
  final int index;
  const Model({this.index = 0});

  Model copyWith({int? index}) => Model(index: index ?? this.index);

  @override
  List<Object> get props => [index];
}
