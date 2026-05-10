import 'package:digital_pet/core/errors/failures.dart';
import 'package:digital_pet/features/story/domain/entities/story_entity.dart';

abstract class StoryRepository {
  Future<StoryEntity> generateStory(List<dynamic> sensorLogs);
}
