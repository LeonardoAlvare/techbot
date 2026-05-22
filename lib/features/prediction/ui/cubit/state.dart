part of 'cubit.dart';

sealed class PredictionState extends Equatable {
  final Model model;
  const PredictionState(this.model);

  @override
  List<Object> get props => [model];
}

final class PredictionInitial extends PredictionState {
  const PredictionInitial(super.model);
}

final class PredictionLoading extends PredictionState {
  const PredictionLoading(super.model);
}

final class PredictionSuccess extends PredictionState {
  const PredictionSuccess(super.model);
}

final class PredictionError extends PredictionState {
  const PredictionError(super.model);
}

class Model extends Equatable {
  final PredictionModel? prediction;

  const Model({this.prediction});

  Model copyWith({PredictionModel? prediction}) {
    return Model(prediction: prediction ?? this.prediction);
  }

  @override
  List<Object> get props => [prediction ?? ''];
}
