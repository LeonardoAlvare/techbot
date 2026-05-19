part of 'cubit.dart';

sealed class SummaryState extends Equatable {
  final Model model;

  const SummaryState(this.model);

  @override
  List<Object> get props => [model];
}

final class SummaryInitial extends SummaryState {
  const SummaryInitial(super.model);
}

final class SummaryLoading extends SummaryState {
  const SummaryLoading(super.model);
}

final class SummarySuccess extends SummaryState {
  const SummarySuccess(super.model);
}

final class SummaryError extends SummaryState {
  final String message;

  const SummaryError(super.model, this.message);
}

class Model extends Equatable {
  final SummaryModel? summary;

  const Model({this.summary});

  Model copyWith({SummaryModel? summary}) => Model(summary: summary);

  @override
  List<Object> get props => [summary ?? {}];
}
