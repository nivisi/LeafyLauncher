import 'dart:io';

import 'package:get/get.dart';

import 'package:leafy_launcher/services/file_system/file_system.dart';
import 'package:leafy_launcher/utils/log/logable_mixin.dart';

import 'domain/note_model.dart';

class NotesService with LogableMixin {
  late final _fileSystem = Get.find<FileSystem>();

  Future<List<NoteModel>> getNotes() async {
    return [
      NoteModel(
        title: 'First Note',
        lastEdited: DateTime(2021, 10, 22),
        created: DateTime(2021, 10, 23),
      ),
      NoteModel(
        title: 'Second Note',
        lastEdited: DateTime(2019, 6, 12),
        created: DateTime(2019, 6, 13),
      ),
      NoteModel(
        title: 'First Note',
        lastEdited: DateTime(2021, 10, 22),
        created: DateTime(2021, 10, 23),
      ),
      NoteModel(
        title: 'Second Note',
        lastEdited: DateTime(2019, 6, 12),
        created: DateTime(2019, 6, 13),
      ),
      NoteModel(
        title: 'First Note',
        lastEdited: DateTime(2021, 10, 22),
        created: DateTime(2021, 10, 23),
      ),
      NoteModel(
        title: 'Second Note',
        lastEdited: DateTime(2019, 6, 12),
        created: DateTime(2019, 6, 13),
      ),
      NoteModel(
        title: 'First Note',
        lastEdited: DateTime(2021, 10, 22),
        created: DateTime(2021, 10, 23),
      ),
      NoteModel(
        title: 'Second Note',
        lastEdited: DateTime(2019, 6, 12),
        created: DateTime(2019, 6, 13),
      ),
    ];
    logger.i('Getting notes ...');

    final leafyNotesDir = _fileSystem.leafyNotesDocumentsDirectory;

    final fileEntities = await leafyNotesDir.list().toList();

    final files = fileEntities.whereType<File>();

    logger.i('Files received ...');

    final notes = <NoteModel>[];

    for (final file in files) {
      final lastEditedAt = await file.lastModified();
      final name = file.path;

      notes.add(
        NoteModel(
          title: name,
          lastEdited: lastEditedAt,
          created: DateTime.now().toUtc(),
        ),
      );
    }

    logger.i('Note models created');

    return notes;
  }
}
