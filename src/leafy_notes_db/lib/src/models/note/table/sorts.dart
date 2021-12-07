part of '../dao/note_dao.dart';

OrderingTerm _notesByLastEditedAt($NotesTable table) {
  return OrderingTerm.desc(table.lastEditedAt);
}

// OrderingTerm _notesByTitleOrFirstLine($NotesTable table) {
//   return OrderingTerm.asc(coalesce([table.title, table.firstLine]));
// }
