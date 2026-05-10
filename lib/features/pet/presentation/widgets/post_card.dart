import 'package:flutter/material.dart';
import 'package:shade/core/theme/theme_extensions.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).extension<PetlExtras>() != null) {
      return _PetlPost();
    }
    if (Theme.of(context).extension<MochiExtras>() != null) {
      return _MochiPost();
    }
    return _ClassicPost();
  }
}

// ── PETL.EXE: terminal-log card ──

class _PetlPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(2),
        color: colors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.terminal, size: 10, color: colors.secondary),
              const SizedBox(width: 4),
              Text(
                'shade.exe v2.0.1',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 7,
                  color: colors.secondary,
                ),
              ),
              const Spacer(),
              Text(
                '[ ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')} ]',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 6,
                  color: colors.primary.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _logLine(colors, '> PETL-0001: All systems nominal'),
          _logLine(colors, '> Hunger levels within tolerance'),
          _logLine(colors, '> Energy output: stable'),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(1),
            ),
            child: Text(
              '> Awaiting next指令...',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 7,
                color: colors.primary.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logLine(ColorScheme colors, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 7,
          color: colors.primary.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}

// ── Mochi: chat bubble ──

class _MochiPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mochi = Theme.of(context).extension<MochiExtras>()!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.surface.withValues(alpha: mochi.glassOpacity),
            colors.surfaceContainerHighest
                .withValues(alpha: mochi.glassOpacity * 0.5),
          ],
        ),
        border: Border.all(
          color: colors.outline.withValues(alpha: mochi.glassBorderOpacity),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '\u{1F338} mochi',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colors.primary,
                ),
              ),
              const Spacer(),
              Text(
                'now playing',
                style: TextStyle(
                  fontSize: 9,
                  color: colors.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '"snuggled up in a cozy corner,\nwatching the stars drift by..."',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: colors.onSurface.withValues(alpha: 0.7),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.music_note, size: 12, color: colors.tertiary),
              const SizedBox(width: 4),
              Text(
                'lofi chill beats',
                style: TextStyle(
                  fontSize: 9,
                  color: colors.tertiary,
                ),
              ),
              const Spacer(),
              Text(
                '3:42',
                style: TextStyle(
                  fontSize: 8,
                  color: colors.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Classic: Material card ──

class _ClassicPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: colors.primary.withValues(alpha: 0.2),
                    child: Icon(Icons.pets, size: 18, color: colors.primary),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shade',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        'just now',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onSurface.withValues(alpha: 0.4),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Everything is going well! Feeling energetic and ready to explore.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.favorite_border,
                      size: 16, color: colors.onSurface.withValues(alpha: 0.4)),
                  const SizedBox(width: 4),
                  Text(
                    '12',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.4),
                        ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.chat_bubble_outline,
                      size: 16, color: colors.onSurface.withValues(alpha: 0.4)),
                  const SizedBox(width: 4),
                  Text(
                    '3',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.4),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
