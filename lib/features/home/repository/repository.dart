import 'package:techbot/features/home/models/create_subject_model.dart';
import 'package:techbot/features/home/models/subject_model.dart';

abstract class HomeRepository {
  Future<List<SubjectModel>> getSubject();
  Future<CreateSubjectModel> createSubject(String name, String description);
}
