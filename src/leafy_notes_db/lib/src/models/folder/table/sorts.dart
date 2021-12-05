part of '../dao/folder_dao.dart';

OrderingTerm _foldersByLastEditedAt($FoldersTable table) {
  return OrderingTerm(
    expression: table.lastEditedAt,
    mode: OrderingMode.desc,
  );
}

OrderingTerm _foldersByTitle($FoldersTable table) {
  return OrderingTerm(expression: table.title);
}
