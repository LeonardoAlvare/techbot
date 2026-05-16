import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/features/view_subject/models/document_model.dart';
import 'package:techbot/features/view_subject/repository/repository.dart';

part 'state.dart';

class ViewSubjectCubit extends Cubit<ViewSubjectState> {
  ViewSubjectCubit(this.repository) : super(ViewSubjectInitial(Model()));

  final ViewSubjectRepository repository;

  Future<void> getDocuments(int id) async {
    emit(ViewSubjectLoading(state.model));
    try {
      final documents = await repository.getSubjectDocuments(id);
      emit(ViewSubjectLoaded(state.model.copyWith(documents: documents)));
    } catch (e) {
      emit(ViewSubjectError(state.model, e.toString()));
    }
  }

  void setFile(File file) {
    emit(UploadInput(state.model.copyWith(selectedFile: file)));
  }

  void setNameDocument(String name) {
    emit(UploadInput(state.model.copyWith(nameDocument: name)));
  }

  Future<void> uploadDocument(int idSubject) async {
    emit(ViewSubjectLoading(state.model));

    try {
      await repository.createDocument(
        state.model.nameDocument,
        state.model.selectedFile!,
        idSubject,
      );
      emit(UploadDocumentSuccess(state.model));
      await getDocuments(idSubject);
    } catch (e) {
      emit(UploadDocumentError(state.model, e.toString()));
    }
  }
}
