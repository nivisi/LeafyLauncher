part of '../dao/folder_dao.dart';

OrderingTerm _foldersByIsDefault($FoldersTable table) {
  return OrderingTerm(
    expression: table.isDefault,
    mode: OrderingMode.desc,
  );
}

OrderingTerm _foldersByLastEditedAt($FoldersTable table) {
  return OrderingTerm(
    expression: table.lastEditedAt,
    mode: OrderingMode.desc,
  );
}

// OrderingTerm _foldersByTitle($FoldersTable table) {
//   return OrderingTerm(expression: table.title);
// }
