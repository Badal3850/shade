import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shade/features/story/domain/entities/story_entity.dart';
import 'package:shade/features/story/presentation/providers/story_provider.dart';

class PetFeedScreen extends StatefulWidget {
  const PetFeedScreen({super.key});

  @override
  State<PetFeedScreen> createState() => _PetFeedScreenState();
}

class _PetFeedScreenState extends State<PetFeedScreen> {
  late final StoryProvider _storyProvider;

  @override
  void initState() {
    super.initState();
    _storyProvider = GetIt.instance<StoryProvider>();
    _storyProvider.checkModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _storyProvider,
      child: Consumer<StoryProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('STORY FEED').animate().fadeIn(duration: 400.ms),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: _buildBody(context, provider),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, StoryProvider provider) {
    final colors = Theme.of(context).colorScheme;

    switch (provider.modelStatus) {
      case ModelStatus.unknown:
        return const Center(child: CircularProgressIndicator());

      case ModelStatus.notInstalled:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 48, color: colors.primary),
                const SizedBox(height: 16),
                Text(
                  'Shade AI',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Download Gemma 4 (2.4 GB) to enable on-device story generation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.onSurface.withValues(alpha: 0.6)),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: provider.downloadModel,
                  icon: const Icon(Icons.download),
                  label: const Text('Download Model'),
                ),
              ],
            ),
          ),
        );

      case ModelStatus.downloading:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(value: provider.downloadProgress / 100),
                const SizedBox(height: 16),
                Text('Downloading Gemma 4... ${provider.downloadProgress}%'),
              ],
            ),
          ),
        );

      case ModelStatus.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: ${provider.error}', style: TextStyle(color: colors.error)),
              const SizedBox(height: 12),
              FilledButton(onPressed: provider.checkModel, child: const Text('Retry')),
            ],
          ),
        );

      case ModelStatus.ready:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: provider.isGenerating ? null : provider.generateStory,
                  icon: provider.isGenerating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.auto_awesome, size: 18),
                  label: Text(provider.isGenerating ? 'Generating...' : 'Generate Story'),
                ),
              ),
            ),
            Expanded(
              child: provider.stories.isEmpty
                  ? Center(
                      child: Text(
                        'No stories yet. Generate your first one!',
                        style: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 24),
                      itemCount: provider.stories.length,
                      itemBuilder: (context, index) {
                        final story = provider.stories[index];
                        return _StoryCard(story: story)
                            .animate()
                            .fadeIn(delay: (index * 80).ms, duration: 400.ms)
                            .slideY(begin: 0.1, end: 0);
                      },
                    ),
            ),
          ],
        );
    }
  }
}

class _StoryCard extends StatelessWidget {
  final StoryEntity story;
  const _StoryCard({required this.story});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 14, color: colors.primary),
              const SizedBox(width: 6),
              Text(
                'shade',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.primary),
              ),
              const Spacer(),
              Text(
                _formatTime(story.createdAt),
                style: TextStyle(fontSize: 10, color: colors.onSurface.withValues(alpha: 0.4)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(story.content, style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
