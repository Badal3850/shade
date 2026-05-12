import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shade/core/layout/app_layout.dart';
import 'package:shade/features/onboarding/pet_name_manager.dart';
import 'package:shade/features/pet/presentation/providers/pet_state_provider.dart';
import 'package:shade/features/pet/presentation/widgets/pet_viewport.dart';
import 'package:shade/features/pet/presentation/widgets/post_card.dart';
import 'package:shade/features/pet/presentation/widgets/sensor_strip.dart';
import 'package:shade/features/pet/presentation/widgets/stats_section.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PetHomeScreen extends StatefulWidget {
  const PetHomeScreen({super.key});

  @override
  State<PetHomeScreen> createState() => _PetHomeScreenState();
}

class _PetHomeScreenState extends State<PetHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PetStateProvider>();
    final nameManager = context.watch<PetNameManager>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return _ErrorView(
        message: provider.error!,
        onRetry: provider.initialize,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (AppLayout.isWide(context)) {
          return _WideHomeLayout(
            provider: provider,
            nameManager: nameManager,
          );
        }
        return _NarrowHomeLayout(
          provider: provider,
          nameManager: nameManager,
        );
      },
    );
  }
}

class _NarrowHomeLayout extends StatelessWidget {
  final PetStateProvider provider;
  final PetNameManager nameManager;
  const _NarrowHomeLayout({required this.provider, required this.nameManager});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            if (nameManager.hasName)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Row(
                  children: [
                    Text(
                      nameManager.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '— your shade',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
            const PetViewport()
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2, end: 0, curve: Curves.easeOutCubic),
            SensorStrip(sensorReading: provider.sensorReading)
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideX(begin: -0.2, end: 0, curve: Curves.easeOutCubic),
            StatsSection(petState: provider.petState)
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: provider.feed,
                  icon: const Icon(Icons.restaurant, size: 18),
                  label: const Text('FEED'),
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 600.ms),
            const PostCard()
                .animate()
                .fadeIn(delay: 600.ms, duration: 800.ms)
                .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _WideHomeLayout extends StatelessWidget {
  final PetStateProvider provider;
  final PetNameManager nameManager;
  const _WideHomeLayout({required this.provider, required this.nameManager});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: pet + sensors + feed
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  const PetViewport(),
                  SensorStrip(sensorReading: provider.sensorReading),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.tonalIcon(
                        onPressed: provider.feed,
                        icon: const Icon(Icons.restaurant, size: 18),
                        label: const Text('FEED'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider
          const VerticalDivider(width: 1),
          // Right: name + stats + post
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (nameManager.hasName)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: Row(
                        children: [
                          Text(
                            nameManager.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '— your shade',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  StatsSection(petState: provider.petState),
                  const PostCard(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: 'Error',
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: colors.error.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.6),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
