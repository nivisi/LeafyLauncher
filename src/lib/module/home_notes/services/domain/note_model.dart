class NoteModel {
  NoteModel({
    required this.title,
    this.firstLine = '',
    required this.lastEdited,
    required this.created,
  });

  final String title;
  final String firstLine;
  final DateTime lastEdited;
  final DateTime created;
}
