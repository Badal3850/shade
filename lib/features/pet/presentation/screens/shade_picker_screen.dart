import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shade/core/theme/theme_manager.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShadePickerScreen extends StatelessWidget {
  const ShadePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SELECT SHADE')
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: -0.2, end: 0),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ThemeStyle.values.length,
        itemBuilder: (context, index) {
          final style = ThemeStyle.values[index];
          final isSelected = themeManager.currentStyle == style;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ShadeTile(
              style: style,
              isSelected: isSelected,
              onTap: () {
                HapticFeedback.mediumImpact();
                themeManager.setStyle(style);
              },
            ),
          ).animate().fadeIn(delay: (index * 100).ms, duration: 500.ms).slideX(begin: 0.1, end: 0);
        },
      ),
    );
  }
}

class _ShadeTile extends StatelessWidget {
  final ThemeStyle style;
  final bool isSelected;
  final VoidCallback onTap;

  const _ShadeTile({
    required this.style,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary.withValues(alpha: 0.1) : colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.primary : colors.primary.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            _PreviewCircle(style: style),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style.label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? colors.primary : colors.onSurface,
                    ),
                  ),
                  Text(
                    _getDescription(style),
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: colors.primary),
          ],
        ),
      ),
    );
  }

  String _getDescription(ThemeStyle style) {
    return switch (style) {
      ThemeStyle.paper => 'Literary, warm, and archival.',
      ThemeStyle.petlExe => 'High-contrast, 8-bit, terminal aesthetic.',
      ThemeStyle.mochi => 'Glassmorphic, soft, and dreamy.',
      ThemeStyle.forest => 'Organic, calm, and earthy.',
      ThemeStyle.sunset => 'Bold, sharp, and high-energy.',
    };
  }
}

class _PreviewCircle extends StatelessWidget {
  final ThemeStyle style;
  const _PreviewCircle({required this.style});

  @override
  Widget build(BuildContext context) {
    final (bg, primary) = switch (style) {
      ThemeStyle.paper => (const Color(0xFFF5F0E8), const Color(0xFF8B4513)),
      ThemeStyle.petlExe => (const Color(0xFF0a0a0f), const Color(0xFF00ffee)),
      ThemeStyle.mochi => (const Color(0xFF0e0b14), const Color(0xFFc4b5fd)),
      ThemeStyle.forest => (const Color(0xFF0A1A0C), const Color(0xFF4ADE80)),
      ThemeStyle.sunset => (const Color(0xFF130800), const Color(0xFFFF6B35)),
    };

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: primary.withValues(alpha: 0.5), width: 2),
      ),
      child: Center(
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: primary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
