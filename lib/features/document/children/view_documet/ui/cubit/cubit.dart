import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/features/document/children/view_documet/repository/repository.dart';
import 'package:techbot/features/document/children/view_documet/utils/base64_to_file.dart';

part 'state.dart';

class ViewDocumentCubit extends Cubit<ViewDocumentState> {
  ViewDocumentCubit(this.repository) : super(ViewDocumentInitial(Model()));

  final ViewDocumentRepository repository;

  Future<void> getDocument(int id) async {
    emit(ViewDocumentLoading(state.model));

    try {
      final document = await repository.viewDocument(id);
      final filePath = await Base64ToFile.base64ToFile(document);

      emit(ViewDocumentSuccess(state.model.copyWith(filePath: filePath)));
    } catch (e) {
      emit(ViewDocumentError(state.model, e.toString()));
    }
  }
}
