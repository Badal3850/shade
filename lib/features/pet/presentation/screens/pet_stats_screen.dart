import 'package:flutter/material.dart';
import 'package:shade/core/di/injection_container.dart';
import 'package:shade/features/pet/presentation/providers/pet_state_provider.dart';
import 'package:shade/features/pet/presentation/widgets/stats_section.dart';
import 'package:shade/features/pet/presentation/widgets/sensor_strip.dart';

class PetStatsScreen extends StatefulWidget {
  const PetStatsScreen({super.key});

  @override
  State<PetStatsScreen> createState() => _PetStatsScreenState();
}

class _PetStatsScreenState extends State<PetStatsScreen> {
  late final PetStateProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = sl<PetStateProvider>();
    _provider.addListener(_onStateChanged);
  }

  void _onStateChanged() => setState(() {});

  @override
  void dispose() {
    _provider.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILED STATS'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            StatsSection(petState: _provider.petState),
            const SizedBox(height: 24),
            const _ChartPlaceholder(),
            const SizedBox(height: 24),
            SensorStrip(sensorReading: _provider.sensorReading),
          ],
        ),
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
      height: 200,
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
