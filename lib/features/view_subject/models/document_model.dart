class DocumentModel {
  final int? id;
  final String? title;
  final String? content;
  final String? filePath;
  final dynamic audioUrl;
  final int? subjectId;

  DocumentModel({
    this.id,
    this.title,
    this.content,
    this.filePath,
    this.audioUrl,
    this.subjectId,
  });

  DocumentModel copyWith({
    int? id,
    String? title,
    String? content,
    String? filePath,
    dynamic audioUrl,
    int? subjectId,
  }) => DocumentModel(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    filePath: filePath ?? this.filePath,
    audioUrl: audioUrl ?? this.audioUrl,
    subjectId: subjectId ?? this.subjectId,
  );

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    filePath: json["file_path"],
    audioUrl: json["audio_url"],
    subjectId: json["subject_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "file_path": filePath,
    "audio_url": audioUrl,
    "subject_id": subjectId,
  };
}
