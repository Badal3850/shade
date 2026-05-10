import 'package:flutter/material.dart';
import 'package:shade/core/theme/theme_extensions.dart';
import 'package:shade/features/pet/domain/entities/pet_entity.dart';

class _StatDef {
  final String label;
  final IconData icon;
  final Color color;
  final int Function(PetEntity) getValue;

  const _StatDef({
    required this.label,
    required this.icon,
    required this.color,
    required this.getValue,
  });
}

final _statDefs = [
  _StatDef(
    label: 'FULLNESS',
    icon: Icons.restaurant,
    color: Color(0xFF00ff88),
    getValue: _fullness,
  ),
  _StatDef(
    label: 'ENERGY',
    icon: Icons.bolt,
    color: Color(0xFF00ffee),
    getValue: (p) => p.energy,
  ),
  _StatDef(
    label: 'MOOD',
    icon: Icons.favorite,
    color: Color(0xFFff2d78),
    getValue: (p) => p.mood,
  ),
  _StatDef(
    label: 'FOCUS',
    icon: Icons.visibility,
    color: Color(0xFFffee00),
    getValue: (p) => p.alertness,
  ),
];

int _fullness(PetEntity p) => (100 - p.hunger).clamp(0, 100);

class StatsSection extends StatelessWidget {
  final PetEntity petState;
  const StatsSection({super.key, required this.petState});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).extension<PetlExtras>() != null) {
      return _PetlStats(petState: petState);
    }
    if (Theme.of(context).extension<MochiExtras>() != null) {
      return _MochiStats(petState: petState);
    }
    return _ClassicStats(petState: petState);
  }
}

// ── PETL.EXE: horizontal gradient bars ──

class _PetlStats extends StatelessWidget {
  final PetEntity petState;
  const _PetlStats({required this.petState});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// STATS',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 8,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 10),
          for (final stat in _statDefs) ...[
            _PetlStatBar(stat: stat, value: stat.getValue(petState)),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _PetlStatBar extends StatelessWidget {
  final _StatDef stat;
  final int value;
  const _PetlStatBar({required this.stat, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fraction = value / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(stat.icon, size: 10, color: stat.color),
            const SizedBox(width: 4),
            Text(
              stat.label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 7,
                color: colors.primary,
              ),
            ),
            const Spacer(),
            Text(
              '$value%',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 7,
                color: colors.primary.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: fraction),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic,
          builder: (context, anim, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: Container(
                height: 10,
                width: double.infinity,
                color: colors.surfaceContainerHighest,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: anim,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          stat.color.withValues(alpha: 0.4),
                          stat.color,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ── Mochi: 2x2 glass vitals grid ──

class _MochiStats extends StatelessWidget {
  final PetEntity petState;
  const _MochiStats({required this.petState});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'vitals',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.4,
            children: _statDefs.map((stat) {
              return _MochiStatCard(
                stat: stat,
                value: stat.getValue(petState),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _MochiStatCard extends StatelessWidget {
  final _StatDef stat;
  final int value;
  const _MochiStatCard({required this.stat, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mochi = Theme.of(context).extension<MochiExtras>()!;
    final fraction = value / 100;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(stat.icon, size: 14, color: stat.color),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  stat.label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: colors.onSurface.withValues(alpha: 0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: stat.color,
            ),
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              height: 4,
              color: colors.surfaceContainerHighest,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: fraction,
                child: Container(color: stat.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Classic: Material style ──

class _ClassicStats extends StatelessWidget {
  final PetEntity petState;
  const _ClassicStats({required this.petState});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Pet Stats',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.5),
                  ),
            ),
          ),
          for (final stat in _statDefs) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(stat.icon, size: 16, color: stat.color),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 64,
                    child: Text(
                      stat.label,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(
                        begin: 0,
                        end: stat.getValue(petState) / 100,
                      ),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      builder: (context, anim, _) {
                        return LinearProgressIndicator(
                          value: anim,
                          backgroundColor:
                              colors.surfaceContainerHighest,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: Text(
                      '${stat.getValue(petState)}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.5),
                          ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
