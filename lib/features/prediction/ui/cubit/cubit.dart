import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/features/prediction/models/prediction_model.dart';
import 'package:techbot/features/prediction/repository/repository.dart';

part 'state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  PredictionCubit(this.repository) : super(PredictionInitial(Model()));

  final PredictionRepository repository;

  Future<void> predict() async {
    emit(PredictionLoading(state.model));
    try {
      final prediction = await repository.predict();
      emit(PredictionSuccess(state.model.copyWith(prediction: prediction)));
    } catch (e) {
      emit(PredictionError(state.model));
    }
  }
}
