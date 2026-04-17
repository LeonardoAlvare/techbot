import 'package:techbot/features/home/models/create_subject_model.dart';
import 'package:techbot/features/home/models/subject_model.dart';

abstract class HomeRepository {
  Future<List<SubjectModel>> getSubject(String token);
  Future<CreateSubjectModel> createSubject(
    String token,
    String name,
    String description,
  );
}
