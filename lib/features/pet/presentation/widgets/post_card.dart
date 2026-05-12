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
    if (Theme.of(context).extension<ForestExtras>() != null) {
      return _ForestPost();
    }
    if (Theme.of(context).extension<SunsetExtras>() != null) {
      return _SunsetPost();
    }
    return _PaperPost();
  }
}

// ── PETL.EXE: terminal-log card ──

class _PetlPost extends StatefulWidget {
  @override
  State<_PetlPost> createState() => _PetlPostState();
}

class _PetlPostState extends State<_PetlPost> {
  late final DateTime _timestamp;

  @override
  void initState() {
    super.initState();
    _timestamp = DateTime.now();
  }

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
                '[ ${_timestamp.hour.toString().padLeft(2, '0')}:${_timestamp.minute.toString().padLeft(2, '0')}:${_timestamp.second.toString().padLeft(2, '0')} ]',
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
            colors.surfaceContainerHighest.withValues(alpha: mochi.glassOpacity * 0.5),
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

// ── Forest: nature journal ──

class _ForestPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('JOURNAL ENTRY', style: TextStyle(fontSize: 10, letterSpacing: 2, color: colors.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'The air is sweet today. I found a patch of soft moss and stayed there for a while. Everything feels peaceful.',
            style: TextStyle(fontSize: 14, height: 1.6, color: colors.onSurface.withValues(alpha: 0.9)),
          ),
          const SizedBox(height: 12),
          Text('— entry #402', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: colors.onSurface.withValues(alpha: 0.4))),
        ],
      ),
    );
  }
}

// ── Sunset: bold status ──

class _SunsetPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CURRENT STATUS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.onPrimary.withValues(alpha: 0.6))),
          const SizedBox(height: 4),
          Text(
            'I AM FEELING ABSOLUTELY UNSTOPPABLE TODAY. DATA PIPELINES ARE CLEAR. ENERGY IS HIGH.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: colors.onPrimary),
          ),
        ],
      ),
    );
  }
}

// ── Paper: typewriter note ──

class _PaperPost extends StatefulWidget {
  @override
  State<_PaperPost> createState() => _PaperPostState();
}

class _PaperPostState extends State<_PaperPost> {
  late final DateTime _timestamp;

  @override
  void initState() {
    super.initState();
    _timestamp = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('MEMO', style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold, fontSize: 14)),
              const Spacer(),
              Text(_timestamp.toString().split(' ')[0], style: TextStyle(fontFamily: 'serif', fontSize: 10)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 12),
          Text(
            'The subject is showing remarkable progress. Alertness remains high despite the late hour. Further observation is recommended.',
            style: TextStyle(fontFamily: 'serif', fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
