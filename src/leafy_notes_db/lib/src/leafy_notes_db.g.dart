// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leafy_notes_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String? title;
  final String? firstLine;
  final String? data;
  final DateTime createdAt;
  final DateTime lastEditedAt;
  final String folderId;
  Note(
      {required this.id,
      this.title,
      this.firstLine,
      this.data,
      required this.createdAt,
      required this.lastEditedAt,
      required this.folderId});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Note(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      firstLine: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_line']),
      data: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      lastEditedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_edited_at'])!,
      folderId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    if (!nullToAbsent || firstLine != null) {
      map['first_line'] = Variable<String?>(firstLine);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<String?>(data);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_edited_at'] = Variable<DateTime>(lastEditedAt);
    map['folder_id'] = Variable<String>(folderId);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      firstLine: firstLine == null && nullToAbsent
          ? const Value.absent()
          : Value(firstLine),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      createdAt: Value(createdAt),
      lastEditedAt: Value(lastEditedAt),
      folderId: Value(folderId),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      firstLine: serializer.fromJson<String?>(json['firstLine']),
      data: serializer.fromJson<String?>(json['data']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastEditedAt: serializer.fromJson<DateTime>(json['lastEditedAt']),
      folderId: serializer.fromJson<String>(json['folderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'firstLine': serializer.toJson<String?>(firstLine),
      'data': serializer.toJson<String?>(data),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastEditedAt': serializer.toJson<DateTime>(lastEditedAt),
      'folderId': serializer.toJson<String>(folderId),
    };
  }

  Note copyWith(
          {String? id,
          String? title,
          String? firstLine,
          String? data,
          DateTime? createdAt,
          DateTime? lastEditedAt,
          String? folderId}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        firstLine: firstLine ?? this.firstLine,
        data: data ?? this.data,
        createdAt: createdAt ?? this.createdAt,
        lastEditedAt: lastEditedAt ?? this.lastEditedAt,
        folderId: folderId ?? this.folderId,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('firstLine: $firstLine, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastEditedAt: $lastEditedAt, ')
          ..write('folderId: $folderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, firstLine, data, createdAt, lastEditedAt, folderId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.title == this.title &&
          other.firstLine == this.firstLine &&
          other.data == this.data &&
          other.createdAt == this.createdAt &&
          other.lastEditedAt == this.lastEditedAt &&
          other.folderId == this.folderId);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String?> firstLine;
  final Value<String?> data;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastEditedAt;
  final Value<String> folderId;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.firstLine = const Value.absent(),
    this.data = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastEditedAt = const Value.absent(),
    this.folderId = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.firstLine = const Value.absent(),
    this.data = const Value.absent(),
    required DateTime createdAt,
    required DateTime lastEditedAt,
    required String folderId,
  })  : id = Value(id),
        createdAt = Value(createdAt),
        lastEditedAt = Value(lastEditedAt),
        folderId = Value(folderId);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String?>? title,
    Expression<String?>? firstLine,
    Expression<String?>? data,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastEditedAt,
    Expression<String>? folderId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (firstLine != null) 'first_line': firstLine,
      if (data != null) 'data': data,
      if (createdAt != null) 'created_at': createdAt,
      if (lastEditedAt != null) 'last_edited_at': lastEditedAt,
      if (folderId != null) 'folder_id': folderId,
    });
  }

  NotesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? title,
      Value<String?>? firstLine,
      Value<String?>? data,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastEditedAt,
      Value<String>? folderId}) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      firstLine: firstLine ?? this.firstLine,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      lastEditedAt: lastEditedAt ?? this.lastEditedAt,
      folderId: folderId ?? this.folderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (firstLine.present) {
      map['first_line'] = Variable<String?>(firstLine.value);
    }
    if (data.present) {
      map['data'] = Variable<String?>(data.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastEditedAt.present) {
      map['last_edited_at'] = Variable<DateTime>(lastEditedAt.value);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<String>(folderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('firstLine: $firstLine, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastEditedAt: $lastEditedAt, ')
          ..write('folderId: $folderId')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _firstLineMeta = const VerificationMeta('firstLine');
  late final GeneratedColumn<String?> firstLine = GeneratedColumn<String?>(
      'first_line', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  late final GeneratedColumn<String?> data = GeneratedColumn<String?>(
      'data', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _lastEditedAtMeta =
      const VerificationMeta('lastEditedAt');
  late final GeneratedColumn<DateTime?> lastEditedAt =
      GeneratedColumn<DateTime?>('last_edited_at', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _folderIdMeta = const VerificationMeta('folderId');
  late final GeneratedColumn<String?> folderId = GeneratedColumn<String?>(
      'folder_id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES folders(id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, firstLine, data, createdAt, lastEditedAt, folderId];
  @override
  String get aliasedName => _alias ?? 'notes';
  @override
  String get actualTableName => 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('first_line')) {
      context.handle(_firstLineMeta,
          firstLine.isAcceptableOrUnknown(data['first_line']!, _firstLineMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_edited_at')) {
      context.handle(
          _lastEditedAtMeta,
          lastEditedAt.isAcceptableOrUnknown(
              data['last_edited_at']!, _lastEditedAtMeta));
    } else if (isInserting) {
      context.missing(_lastEditedAtMeta);
    }
    if (data.containsKey('folder_id')) {
      context.handle(_folderIdMeta,
          folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta));
    } else if (isInserting) {
      context.missing(_folderIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Note.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

class Folder extends DataClass implements Insertable<Folder> {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime lastEditedAt;
  final bool isDefault;
  Folder(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.lastEditedAt,
      required this.isDefault});
  factory Folder.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Folder(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      lastEditedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_edited_at'])!,
      isDefault: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_default'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_edited_at'] = Variable<DateTime>(lastEditedAt);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  FoldersCompanion toCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      lastEditedAt: Value(lastEditedAt),
      isDefault: Value(isDefault),
    );
  }

  factory Folder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Folder(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastEditedAt: serializer.fromJson<DateTime>(json['lastEditedAt']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastEditedAt': serializer.toJson<DateTime>(lastEditedAt),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  Folder copyWith(
          {String? id,
          String? title,
          DateTime? createdAt,
          DateTime? lastEditedAt,
          bool? isDefault}) =>
      Folder(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        lastEditedAt: lastEditedAt ?? this.lastEditedAt,
        isDefault: isDefault ?? this.isDefault,
      );
  @override
  String toString() {
    return (StringBuffer('Folder(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastEditedAt: $lastEditedAt, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, createdAt, lastEditedAt, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Folder &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.lastEditedAt == this.lastEditedAt &&
          other.isDefault == this.isDefault);
}

class FoldersCompanion extends UpdateCompanion<Folder> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastEditedAt;
  final Value<bool> isDefault;
  const FoldersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastEditedAt = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  FoldersCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    required DateTime createdAt,
    required DateTime lastEditedAt,
    this.isDefault = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt),
        lastEditedAt = Value(lastEditedAt);
  static Insertable<Folder> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastEditedAt,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (lastEditedAt != null) 'last_edited_at': lastEditedAt,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  FoldersCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastEditedAt,
      Value<bool>? isDefault}) {
    return FoldersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastEditedAt: lastEditedAt ?? this.lastEditedAt,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastEditedAt.present) {
      map['last_edited_at'] = Variable<DateTime>(lastEditedAt.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoldersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastEditedAt: $lastEditedAt, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

class $FoldersTable extends Folders with TableInfo<$FoldersTable, Folder> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FoldersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _lastEditedAtMeta =
      const VerificationMeta('lastEditedAt');
  late final GeneratedColumn<DateTime?> lastEditedAt =
      GeneratedColumn<DateTime?>('last_edited_at', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _isDefaultMeta = const VerificationMeta('isDefault');
  late final GeneratedColumn<bool?> isDefault = GeneratedColumn<bool?>(
      'is_default', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_default IN (0, 1))',
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, createdAt, lastEditedAt, isDefault];
  @override
  String get aliasedName => _alias ?? 'folders';
  @override
  String get actualTableName => 'folders';
  @override
  VerificationContext validateIntegrity(Insertable<Folder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_edited_at')) {
      context.handle(
          _lastEditedAtMeta,
          lastEditedAt.isAcceptableOrUnknown(
              data['last_edited_at']!, _lastEditedAtMeta));
    } else if (isInserting) {
      context.missing(_lastEditedAtMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Folder map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Folder.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(_db, alias);
  }
}

abstract class _$LeafyNotesDatabase extends GeneratedDatabase {
  _$LeafyNotesDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  late final $NotesTable notes = $NotesTable(this);
  late final $FoldersTable folders = $FoldersTable(this);
  late final NoteDao noteDao = NoteDao(this as LeafyNotesDatabase);
  late final FolderDao folderDao = FolderDao(this as LeafyNotesDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes, folders];
}
