import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('Note')
class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().nullable().withDefault(const Constant(''))();
  TextColumn get firstLine =>
      text().nullable().withDefault(const Constant(''))();
  TextColumn get data => text().nullable().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastEditedAt => dateTime()();
  TextColumn get folderId =>
      text().customConstraint('REFERENCES folders(id)')();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();

  @override
  Set<Column>? get primaryKey => {id};
}
