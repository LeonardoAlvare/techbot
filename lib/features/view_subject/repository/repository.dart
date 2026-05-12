import 'dart:io';

import 'package:techbot/features/view_subject/models/document_model.dart';

abstract class ViewSubjectRepository {
  Future<List<DocumentModel>> getSubjectDocuments(int idSubject);
  Future<DocumentModel> createDocument(String title, File file, int idSubject);
}
