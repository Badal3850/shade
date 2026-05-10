import 'package:flutter/material.dart';
import 'package:shade/core/theme/theme_extensions.dart';
import 'package:shade/features/sensors/domain/entities/sensor_reading.dart';

class SensorStrip extends StatelessWidget {
  final SensorReading sensorReading;
  const SensorStrip({super.key, required this.sensorReading});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).extension<PetlExtras>() != null) {
      return _PetlSensors(sensorReading: sensorReading);
    }
    if (Theme.of(context).extension<MochiExtras>() != null) {
      return _MochiSensors(sensorReading: sensorReading);
    }
    if (Theme.of(context).extension<ForestExtras>() != null) {
      return _ForestSensors(sensorReading: sensorReading);
    }
    if (Theme.of(context).extension<SunsetExtras>() != null) {
      return _SunsetSensors(sensorReading: sensorReading);
    }
    return _PaperSensors(sensorReading: sensorReading);
  }
}

// ── Data ──

class _SensorItem {
  final String label;
  final String? value;
  final IconData icon;
  const _SensorItem({
    required this.label,
    this.value,
    required this.icon,
  });
}

List<_SensorItem> _buildSensorItems(SensorReading reading) {
  final movement = (reading.accelerometerX?.abs() ?? 0) +
      (reading.accelerometerY?.abs() ?? 0) +
      (reading.accelerometerZ?.abs() ?? 0);
  
  return [
    _SensorItem(
      label: 'MOVEMENT',
      value: movement > 0.1 ? movement.toStringAsFixed(2) : 'IDLE',
      icon: Icons.vibration,
    ),
    _SensorItem(
      label: 'BATTERY',
      value: reading.batteryLevel != null ? '${reading.batteryLevel}%' : '--',
      icon: Icons.battery_std,
    ),
    _SensorItem(
      label: 'STEPS',
      value: reading.stepCount != null ? '${reading.stepCount}' : '--',
      icon: Icons.directions_walk,
    ),
  ];
}

// ── PETL.EXE: pixel chips ──

class _PetlSensors extends StatelessWidget {
  final SensorReading sensorReading;
  const _PetlSensors({required this.sensorReading});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final items = _buildSensorItems(sensorReading);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: colors.primary.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        children: items.map((item) {
          return Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, size: 10, color: colors.secondary),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${item.label} ${item.value ?? '--'}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 6,
                      color: colors.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Mochi: gradient pills ──

class _MochiSensors extends StatelessWidget {
  final SensorReading sensorReading;
  const _MochiSensors({required this.sensorReading});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mochi = Theme.of(context).extension<MochiExtras>()!;
    final items = _buildSensorItems(sensorReading);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map((item) {
            return Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.surface.withValues(alpha: mochi.glassOpacity * 1.2),
                    colors.surfaceContainerHighest.withValues(alpha: mochi.glassOpacity * 0.6),
                  ],
                ),
                border: Border.all(
                  color: colors.outline.withValues(alpha: mochi.glassBorderOpacity),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 14, color: colors.primary),
                  const SizedBox(width: 6),
                  Text(
                    '${item.label}  ${item.value ?? '--'}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: colors.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ── Forest: organic chips ──

class _ForestSensors extends StatelessWidget {
  final SensorReading sensorReading;
  const _ForestSensors({required this.sensorReading});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final items = _buildSensorItems(sensorReading);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colors.tertiary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, size: 12, color: colors.primary),
                const SizedBox(width: 4),
                Text(
                  item.value ?? '--',
                  style: TextStyle(fontSize: 10, color: colors.onSurface, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Sunset: bold data blocks ──

class _SunsetSensors extends StatelessWidget {
  final SensorReading sensorReading;
  const _SunsetSensors({required this.sensorReading});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final items = _buildSensorItems(sensorReading);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.1),
        border: Border(left: BorderSide(color: colors.primary, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.label, style: TextStyle(fontSize: 8, color: colors.onSurface.withValues(alpha: 0.5))),
              Text(item.value ?? '--', style: TextStyle(fontSize: 12, color: colors.primary, fontWeight: FontWeight.bold)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ── Paper: subtle text list ──

class _PaperSensors extends StatelessWidget {
  final SensorReading sensorReading;
  const _PaperSensors({required this.sensorReading});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final items = _buildSensorItems(sensorReading);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.primary.withValues(alpha: 0.1))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return Text(
            '${item.label}: ${item.value ?? '--'}',
            style: TextStyle(fontSize: 10, fontFamily: 'serif', fontStyle: FontStyle.italic, color: colors.onSurface.withValues(alpha: 0.6)),
          );
        }).toList(),
      ),
    );
  }
}
