import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shade/core/layout/app_layout.dart';
import 'package:shade/features/pet/presentation/providers/pet_state_provider.dart';
import 'package:shade/features/pet/presentation/widgets/stats_section.dart';
import 'package:shade/features/pet/presentation/widgets/sensor_strip.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PetStatsScreen extends StatefulWidget {
  const PetStatsScreen({super.key});

  @override
  State<PetStatsScreen> createState() => _PetStatsScreenState();
}

class _PetStatsScreenState extends State<PetStatsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PetStateProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Text(
          'Error: ${provider.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILED STATS').animate().fadeIn(duration: 400.ms),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (AppLayout.isWide(context)) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: StatsSection(petState: provider.petState)
                        .animate().fadeIn(duration: 600.ms),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        const _ChartPlaceholder()
                            .animate().fadeIn(delay: 200.ms, duration: 600.ms),
                        const SizedBox(height: 24),
                        SensorStrip(sensorReading: provider.sensorReading)
                            .animate().fadeIn(delay: 400.ms, duration: 600.ms),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          // narrow layout (existing)
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                StatsSection(petState: provider.petState)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.1, end: 0),
                const SizedBox(height: 24),
                const _ChartPlaceholder()
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
                const SizedBox(height: 24),
                SensorStrip(sensorReading: provider.sensorReading)
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideY(begin: 0.1, end: 0),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ChartPlaceholder extends StatelessWidget {
  const _ChartPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACTIVITY TREND',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              final height = 40.0 + (index * 15.0) % 100.0;
              return Container(
                width: 20,
                height: height,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.2 + (index * 0.1)),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map((d) => Text(d, style: TextStyle(fontSize: 8, color: colors.onSurface.withValues(alpha: 0.4))))
                .toList(),
          ),
        ],
      ),
    );
  }
}
