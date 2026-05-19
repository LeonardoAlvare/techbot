import 'package:techbot/features/document/children/summary/models/summary_model.dart';

abstract class SummaryRepository {
  Future<SummaryModel> getSummary(int id);
  Future<SummaryModel> createSummary(int id);
}
