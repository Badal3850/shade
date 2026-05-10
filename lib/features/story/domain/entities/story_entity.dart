import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  final String id;
  final String petHandle;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final StoryType type;

  const StoryEntity({
    required this.id,
    required this.petHandle,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.type,
  });

  @override
  List<Object?> get props => [id, petHandle, content, imageUrl, createdAt, type];
}

enum StoryType { weekly, dream, milestone, yearEnd }
