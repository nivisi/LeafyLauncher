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
  });

  final String id;
  final String? title;
  final String? firstLine;
  final String? data;
  final DateTime lastEditedAt;
  final DateTime createdAt;
  final String folderId;

  NoteModel copyWith({
    String? id,
    String? title,
    String? firstLine,
    String? data,
    DateTime? lastEditedAt,
    DateTime? createdAt,
    String? folderId,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      firstLine: firstLine ?? this.firstLine,
      data: data ?? this.data,
      lastEditedAt: lastEditedAt ?? this.lastEditedAt,
      createdAt: createdAt ?? this.createdAt,
      folderId: folderId ?? this.folderId,
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
      ];
}
