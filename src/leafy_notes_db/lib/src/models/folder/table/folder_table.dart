import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('Folder')
class Folders extends Table {
  TextColumn get id => text()();
  TextColumn get title =>
      text().withLength(min: 1, max: 255).withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastEditedAt => dateTime()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  @override
  Set<Column>? get primaryKey => {id};
}
