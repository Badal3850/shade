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
    return _ClassicViewport();
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
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: PixelGridPet(),
      ),
    );
  }
}

class _MochiViewport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mochi = Theme.of(context).extension<MochiExtras>()!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: SoftCharacterPet(),
      ),
    );
  }
}

class _ClassicViewport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colors.surfaceContainerHighest,
      ),
      alignment: Alignment.center,
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: SoftCharacterPet(),
      ),
    );
  }
}
