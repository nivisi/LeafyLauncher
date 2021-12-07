import '../../leafy_notes_database.dart';

class FolderWithNotes {
  FolderWithNotes({required this.folder, required this.notes});

  final FolderModel folder;
  final List<NoteModel> notes;
}
