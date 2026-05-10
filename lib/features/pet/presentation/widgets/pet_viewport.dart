import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shade/core/theme/theme_extensions.dart';
import 'package:shade/features/pet/presentation/widgets/pixel_grid_pet.dart';
import 'package:shade/features/pet/presentation/widgets/soft_character_pet.dart';

class PetViewport extends StatelessWidget {
  const PetViewport({super.key});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).extension<PetlExtras>() != null) {
      return _PetlViewport();
    }
    if (Theme.of(context).extension<MochiExtras>() != null) {
      return _MochiViewport();
    }
    if (Theme.of(context).extension<ForestExtras>() != null) {
      return _ForestViewport();
    }
    if (Theme.of(context).extension<SunsetExtras>() != null) {
      return _SunsetViewport();
    }
    return _PaperViewport();
  }
}

class _PetlViewport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(2),
        color: colors.surface,
      ),
      child: Stack(
        children: [
          const RepaintBoundary(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: PixelGridPet(),
            ),
          ),
          const Positioned.fill(child: _ScanlineOverlay()),
        ],
      ),
    );
  }
}

class _ScanlineOverlay extends StatelessWidget {
  const _ScanlineOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _ScanlinePainter(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        ),
      ),
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  final Color color;
  _ScanlinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    
    for (double i = 0; i < size.height; i += 3) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MochiViewport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mochi = Theme.of(context).extension<MochiExtras>()!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
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
            child: const RepaintBoundary(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SoftCharacterPet(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ForestViewport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: const RepaintBoundary(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SoftCharacterPet(),
        ),
      ),
    );
  }
}

class _SunsetViewport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.primary, width: 2),
        color: colors.surface,
      ),
      child: const RepaintBoundary(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: PixelGridPet(),
        ),
      ),
    );
  }
}

class _PaperViewport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        border: Border.all(color: colors.primary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(2, 2),
          )
        ],
      ),
      alignment: Alignment.center,
      child: const RepaintBoundary(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SoftCharacterPet(),
        ),
      ),
    );
  }
}
