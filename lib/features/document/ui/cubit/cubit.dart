import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(DocumentInitial(Model()));

  void changeIndex(int index) {
    emit(DocumentInitial(state.model.copyWith(index: index)));
  }
}
