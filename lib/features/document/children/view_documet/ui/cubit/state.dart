part of 'cubit.dart';

sealed class ViewDocumentState extends Equatable {
  final Model model;
  const ViewDocumentState(this.model);

  @override
  List<Object> get props => [model];
}

final class ViewDocumentInitial extends ViewDocumentState {
  const ViewDocumentInitial(super.model);
}

final class ViewDocumentLoading extends ViewDocumentState {
  const ViewDocumentLoading(super.model);
}

final class ViewDocumentSuccess extends ViewDocumentState {
  const ViewDocumentSuccess(super.model);
}

final class ViewDocumentError extends ViewDocumentState {
  final String message;
  const ViewDocumentError(super.model, this.message);
}

class Model extends Equatable {
  final String? filePath;

  const Model({this.filePath});

  Model copyWith({String? filePath}) => Model(filePath: filePath);

  @override
  List<Object> get props => [filePath ?? ''];
}
