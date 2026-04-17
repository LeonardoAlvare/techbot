import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:techbot/features/home/models/create_subject_model.dart';
import 'package:techbot/features/home/models/subject_model.dart';
import 'package:techbot/features/home/repository/repository.dart';

part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeInitial(Model()));

  final HomeRepository repository;

  void setName(String name) {
    emit(UpdateInput(state.model.copyWith(name: name)));
  }

  void setDescription(String description) {
    emit(UpdateInput(state.model.copyWith(description: description)));
  }

  // Future<void> createSubject(String token) async {
  //   emit(HomeLoading(state.model));
  //   try {
  //     final subject = await repository.createSubject(
  //       token,
  //       state.model.name,
  //       state.model.description,
  //     );
  //     emit(
  //       HomeSuccess(
  //         state.model.copyWith(
  //           subjects: [...state.model.subjects ?? [], subject],
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     emit(HomeError(state.model));
  //   }
  // }

  Future<void> getSubject(String token) async {
    emit(HomeLoading(state.model));
    try {
      final subjects = await repository.getSubject(token);
      emit(HomeSuccess(state.model.copyWith(subjects: subjects)));
    } catch (e) {
      emit(HomeError(state.model));
    }
  }
}
