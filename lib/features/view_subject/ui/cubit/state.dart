part of 'cubit.dart';

sealed class ViewSubjectState extends Equatable {
  final Model model;
  const ViewSubjectState(this.model);

  @override
  List<Object> get props => [];
}

final class ViewSubjectInitial extends ViewSubjectState {
  const ViewSubjectInitial(super.model);
}

final class ViewSubjectLoaded extends ViewSubjectState {
  const ViewSubjectLoaded(super.model);
}

final class ViewSubjectError extends ViewSubjectState {
  final String message;
  const ViewSubjectError(super.model, this.message);
}

final class ViewSubjectLoading extends ViewSubjectState {
  const ViewSubjectLoading(super.model);
}

final class UploadDocumentSuccess extends ViewSubjectState {
  const UploadDocumentSuccess(super.model);
}

final class UploadDocumentError extends ViewSubjectState {
  final String message;
  const UploadDocumentError(super.model, this.message);
}

final class UploadInput extends ViewSubjectState {
  const UploadInput(super.model);
}

class Model extends Equatable {
  final List<DocumentModel>? documents;
  final File? selectedFile;
  final String nameDocument;

  const Model({
    this.documents = const [],
    this.selectedFile,
    this.nameDocument = '',
  });

  Model copyWith({
    List<DocumentModel>? documents,
    File? selectedFile,
    String? nameDocument,
  }) => Model(
    documents: documents ?? this.documents,
    selectedFile: selectedFile ?? this.selectedFile,
    nameDocument: nameDocument ?? this.nameDocument,
  );

  @override
  List<Object> get props => [documents ?? [], ?selectedFile, nameDocument];
}
