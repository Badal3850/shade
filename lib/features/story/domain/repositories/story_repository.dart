import 'package:shade/features/story/domain/entities/story_entity.dart';

abstract class StoryRepository {
  Future<StoryEntity> generateStory(List<dynamic> sensorLogs);
}
