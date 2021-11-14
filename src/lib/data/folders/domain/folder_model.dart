import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:leafy_launcher/data/base/db_entity_base.dart';
import 'package:leafy_launcher/data/base/hive_types.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';

part 'folder_model.g.dart';

@HiveType(typeId: HiveTypes.folder)
class FolderModel extends DbEntityBase {
  FolderModel({
    required String id,
    required this.title,
    required this.createdAt,
    required this.lastEditedAt,
    required this.notes,
    required this.isDefaultOne,
  }) : super(id);

  FolderModel.createDefault({
    required String id,
    required this.notes,
    required this.createdAt,
    required this.lastEditedAt,
  })  : title = '',
        isDefaultOne = true,
        super(id);

  @HiveField(1)
  @protected
  final String title;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final DateTime lastEditedAt;

  @HiveField(4)
  final List<NoteModel> notes;

  @HiveField(5)
  final bool isDefaultOne;

  String get normalizedTitle =>
      isDefaultOne ? L10nProvider.getText(L10n.defaultFolderTitle) : title;

  FolderModel copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? lastEditedAt,
    List<NoteModel>? notes,
    bool? isDefaultOne,
  }) {
    return FolderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastEditedAt: lastEditedAt ?? this.lastEditedAt,
      notes: notes ?? this.notes,
      isDefaultOne: isDefaultOne ?? this.isDefaultOne,
    );
  }
}
