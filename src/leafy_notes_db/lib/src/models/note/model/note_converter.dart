import '../../../leafy_notes_db.dart';
import 'note_model.dart';

NoteModel noteModelFromDb(Note note) {
  return NoteModel(
    id: note.id,
    title: note.title,
    lastEditedAt: note.lastEditedAt,
    createdAt: note.createdAt,
    firstLine: note.firstLine,
    data: note.data,
    folderId: note.folderId,
    isArchived: note.isArchived,
    isPinned: note.isPinned,
  );
}

Note noteModelToDb(NoteModel note) {
  return Note(
    id: note.id,
    title: note.title,
    lastEditedAt: note.lastEditedAt,
    createdAt: note.createdAt,
    firstLine: note.firstLine,
    data: note.data,
    folderId: note.folderId,
    isArchived: note.isArchived,
    isPinned: note.isPinned,
  );
}
