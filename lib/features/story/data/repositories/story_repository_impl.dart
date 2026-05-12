import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:shade/features/story/domain/entities/story_entity.dart';
import 'package:shade/features/story/domain/repositories/story_repository.dart';

const _modelUrl =
    'https://huggingface.co/litert-community/gemma-4-E2B-it-litert-lm/resolve/main/gemma-4-E2B-it.litertlm';
const _modelFileName = 'gemma-4-E2B-it.litertlm';

class StoryRepositoryImpl implements StoryRepository {
  static const _systemInstruction =
      'You are Shade, a sarcastic digital pet with a sharp wit. '
      'You roast your owner based on their life data. '
      'Keep responses under 3 sentences. Be funny, edgy, but not mean-spirited.';

  /// Returns true if the model file is already downloaded.
  Future<bool> isModelInstalled() =>
      FlutterGemma.isModelInstalled(_modelFileName);

  /// Re-registers an already-downloaded Gemma 4 model with LiteRT-LM metadata.
  Future<void> activateInstalledModel() async {
    final installed = await isModelInstalled();
    if (!installed) {
      throw StateError('Gemma 4 model is not installed. Download it first.');
    }

    await _installOrActivateModel();
  }

  /// Downloads the model with progress callback [onProgress] (0-100).
  Future<void> downloadModel({void Function(int)? onProgress}) async {
    await _installOrActivateModel(onProgress: onProgress);
  }

  @override
  Future<StoryEntity> generateStory(List<Object> sensorLogs) async {
    await activateInstalledModel();
    final prompt = _buildPrompt(sensorLogs);
    final model = await FlutterGemma.getActiveModel(
      maxTokens: 256,
      preferredBackend: PreferredBackend.gpu,
    );
    try {
      final chat = await model.createChat(
        systemInstruction: _systemInstruction,
      );
      await chat.addQueryChunk(Message.text(text: prompt, isUser: true));
      final response = await chat.generateChatResponse();
      final content = response is TextResponse
          ? response.token
          : response.toString();
      return StoryEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        petHandle: 'shade',
        content: content.trim(),
        createdAt: DateTime.now(),
        type: StoryType.weekly,
      );
    } finally {
      await model.close();
    }
  }

  Future<void> _installOrActivateModel({void Function(int)? onProgress}) async {
    final installer = FlutterGemma.installModel(
      modelType: ModelType.gemma4,
      fileType: ModelFileType.litertlm,
    ).fromNetwork(_modelUrl);

    if (onProgress != null) {
      installer.withProgress(onProgress);
    }

    await installer.install();
  }

  String _buildPrompt(List<Object> sensorLogs) {
    if (sensorLogs.isEmpty) {
      return 'My owner has been completely ignoring me. Roast them.';
    }
    return 'Based on this data about my owner: $sensorLogs - write a short roast.';
  }
}
