import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  const NoteModel({
    required this.id,
    required this.title,
    this.firstLine = '',
    this.data = '',
    required this.lastEditedAt,
    required this.createdAt,
    required this.folderId,
    required this.isArchived,
    required this.isPinned,
  });

  final String id;
  final String? title;
  final String? firstLine;
  final String? data;
  final DateTime lastEditedAt;
  final DateTime createdAt;
  final String folderId;
  final bool isArchived;
  final bool isPinned;

  NoteModel copyWith({
    String? id,
    String? title,
    String? firstLine,
    String? data,
    DateTime? lastEditedAt,
    DateTime? createdAt,
    String? folderId,
    bool? isArchived,
    bool? isPinned,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      firstLine: firstLine ?? this.firstLine,
      data: data ?? this.data,
      lastEditedAt: lastEditedAt ?? this.lastEditedAt,
      createdAt: createdAt ?? this.createdAt,
      folderId: folderId ?? this.folderId,
      isArchived: isArchived ?? this.isArchived,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        firstLine,
        data,
        lastEditedAt,
        createdAt,
        isArchived,
        isPinned,
      ];
}
