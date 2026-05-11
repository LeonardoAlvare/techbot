import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Future<void> createSubject() async {
    emit(HomeLoading(state.model));

    try {
      await repository.createSubject(state.model.name, state.model.description);

      await getSubject();
    } catch (e) {
      emit(HomeError(state.model));
    }
  }

  Future<void> getSubject() async {
    emit(HomeLoading(state.model));
    try {
      final subjects = await repository.getSubject();
      emit(HomeSuccess(state.model.copyWith(subjects: subjects)));
    } catch (e) {
      emit(HomeError(state.model));
    }
  }
}
