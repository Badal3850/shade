import 'package:flutter/foundation.dart';
import 'package:shade/features/story/data/repositories/story_repository_impl.dart';
import 'package:shade/features/story/domain/entities/story_entity.dart';

enum ModelStatus { unknown, notInstalled, downloading, ready, error }

class StoryProvider extends ChangeNotifier {
  final StoryRepositoryImpl _repo;

  ModelStatus _modelStatus = ModelStatus.unknown;
  int _downloadProgress = 0;
  bool _isGenerating = false;
  String? _error;
  final List<StoryEntity> _stories = [];

  StoryProvider(this._repo);

  ModelStatus get modelStatus => _modelStatus;
  int get downloadProgress => _downloadProgress;
  bool get isGenerating => _isGenerating;
  String? get error => _error;
  List<StoryEntity> get stories => List.unmodifiable(_stories);

  Future<void> checkModel() async {
    try {
      final installed = await _repo.isModelInstalled();
      if (installed) {
        await _repo.activateInstalledModel();
      }
      _modelStatus = installed ? ModelStatus.ready : ModelStatus.notInstalled;
    } catch (e) {
      _modelStatus = ModelStatus.error;
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> downloadModel() async {
    _modelStatus = ModelStatus.downloading;
    _downloadProgress = 0;
    _error = null;
    notifyListeners();
    try {
      await _repo.downloadModel(
        onProgress: (p) {
          _downloadProgress = p;
          notifyListeners();
        },
      );
      _modelStatus = ModelStatus.ready;
    } catch (e) {
      _modelStatus = ModelStatus.error;
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> generateStory({List<Object> context = const []}) async {
    if (_modelStatus != ModelStatus.ready) return;
    _isGenerating = true;
    _error = null;
    notifyListeners();
    try {
      final story = await _repo.generateStory(context);
      _stories.insert(0, story);
    } catch (e) {
      _error = e.toString();
      debugPrint('[StoryProvider] generateStory error: $e');
    }
    _isGenerating = false;
    notifyListeners();
  }
}
