import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/features/document/children/summary/models/summary_model.dart';
import 'package:techbot/features/document/children/summary/repository/repository.dart';

part 'state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit(this.repository) : super(SummaryInitial(Model()));

  final SummaryRepository repository;

  Future<void> getSummary(int documentId) async {
    emit(SummaryLoading(state.model));
    try {
      final summary = await repository.getSummary(documentId);

      emit(SummarySuccess(state.model.copyWith(summary: summary)));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(SummarySuccess(state.model.copyWith(summary: null)));
      } else {
        emit(SummaryError(state.model, e.toString()));
      }
    } catch (e) {
      emit(SummaryError(state.model, e.toString()));
    }
  }

  Future<void> createSummary(int documentId) async {
    emit(SummaryLoading(state.model));
    try {
      final summary = await repository.createSummary(documentId);
      emit(SummarySuccess(state.model.copyWith(summary: summary)));
    } catch (e) {
      emit(SummaryError(state.model, e.toString()));
    }
  }
}
