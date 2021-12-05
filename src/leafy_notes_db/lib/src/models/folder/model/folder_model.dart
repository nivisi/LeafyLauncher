import 'package:equatable/equatable.dart';

class FolderModel extends Equatable {
  const FolderModel({
    required this.id,
    required this.title,
    required this.lastEditedAt,
    required this.createdAt,
    required this.isDefault,
  });

  final String id;
  final String title;
  final DateTime lastEditedAt;
  final DateTime createdAt;
  final bool isDefault;

  FolderModel copyWith({
    String? id,
    String? title,
    DateTime? lastEditedAt,
    DateTime? createdAt,
    bool? isDefault,
  }) {
    return FolderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      lastEditedAt: lastEditedAt ?? this.lastEditedAt,
      createdAt: createdAt ?? this.createdAt,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        lastEditedAt,
        createdAt,
        isDefault,
      ];
}
