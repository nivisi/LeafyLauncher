// ignore_for_file: hash_and_equals

import 'package:hive/hive.dart';
import 'package:leafy_launcher/data/base/db_entity_base.dart';
import 'package:leafy_launcher/data/base/hive_types.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';

part 'note_model.g.dart';

@HiveType(typeId: HiveTypes.note)
class NoteModel extends DbEntityBase {
  NoteModel({
    required String id,
    required this.title,
    this.firstLine = '',
    this.text = '',
    required this.lastEdited,
    required this.createdAt,
    required this.folder,
  }) : super(id);

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String firstLine;

  @HiveField(3)
  final String text;

  @HiveField(4)
  final DateTime lastEdited;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final FolderModel folder;

  String get normalizedTitle => title.isNotEmpty
      ? title
      : firstLine.isNotEmpty
          ? firstLine
          : L10nProvider.getText(L10n.leafyNotesUntitledNote);

  NoteModel copyWith({
    String? id,
    String? title,
    String? firstLine,
    String? text,
    DateTime? lastEdited,
    DateTime? createdAt,
    FolderModel? folder,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      firstLine: firstLine ?? this.firstLine,
      text: text ?? this.text,
      lastEdited: lastEdited ?? this.lastEdited,
      createdAt: createdAt ?? this.createdAt,
      folder: folder ?? this.folder,
    );
  }

  @override
  bool operator ==(other) {
    if (other is! NoteModel) {
      return false;
    }

    return id == other.id &&
        title == other.title &&
        firstLine == other.firstLine &&
        text == other.text &&
        lastEdited == other.lastEdited &&
        createdAt == other.createdAt;
  }
}
