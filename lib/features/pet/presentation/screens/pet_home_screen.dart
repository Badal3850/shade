import 'package:flutter/material.dart';
import 'package:shade/core/di/injection_container.dart';
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
  late final PetStateProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = sl<PetStateProvider>();
    _provider.addListener(_onStateChanged);
    _provider.initialize();
  }

  void _onStateChanged() => setState(() {});

  @override
  void dispose() {
    _provider.removeListener(_onStateChanged);
    _provider.recordClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_provider.error != null) {
      return _ErrorView(
        message: _provider.error!,
        onRetry: _retry,
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            const PetViewport()
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2, end: 0, curve: Curves.easeOutCubic),
            SensorStrip(sensorReading: _provider.sensorReading)
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideX(begin: -0.2, end: 0, curve: Curves.easeOutCubic),
            StatsSection(petState: _provider.petState)
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
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

  void _retry() {
    _provider.initialize();
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
            Icon(
              Icons.error_outline,
              size: 48,
              color: colors.error.withValues(alpha: 0.6),
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
