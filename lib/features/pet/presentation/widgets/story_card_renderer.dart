import 'package:flutter/material.dart';

class StoryCardRenderer extends StatelessWidget {
  const StoryCardRenderer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('WEEKLY STORY'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 450,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        color: colors.primary.withValues(alpha: 0.05),
                        child: Icon(Icons.auto_awesome, size: 80, color: colors.primary.withValues(alpha: 0.3)),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WEEK 18: THE DRIFT',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                                color: colors.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'A week of quiet contemplation and steady progress. Your pet has reached level 4.',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: colors.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                _StatChip(label: 'Steps', value: '12,402', color: colors.primary),
                                const SizedBox(width: 8),
                                _StatChip(label: 'Mood', value: 'Serene', color: colors.secondary),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text('EXPORT & SHARE'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
