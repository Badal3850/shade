import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';

// ──────────────────────────────────────────────
// PETL.EXE Extras
// ──────────────────────────────────────────────

class PetlExtras extends ThemeExtension<PetlExtras> {
  final bool showScanlines;
  final bool showPixelGrid;
  final Color gridColor;
  final Color scanlineColor;
  final Color glitchPrimary;
  final Color glitchSecondary;

  const PetlExtras({
    required this.showScanlines,
    required this.showPixelGrid,
    required this.gridColor,
    required this.scanlineColor,
    required this.glitchPrimary,
    required this.glitchSecondary,
  });

  @override
  PetlExtras copyWith({
    bool? showScanlines,
    bool? showPixelGrid,
    Color? gridColor,
    Color? scanlineColor,
    Color? glitchPrimary,
    Color? glitchSecondary,
  }) {
    return PetlExtras(
      showScanlines: showScanlines ?? this.showScanlines,
      showPixelGrid: showPixelGrid ?? this.showPixelGrid,
      gridColor: gridColor ?? this.gridColor,
      scanlineColor: scanlineColor ?? this.scanlineColor,
      glitchPrimary: glitchPrimary ?? this.glitchPrimary,
      glitchSecondary: glitchSecondary ?? this.glitchSecondary,
    );
  }

  @override
  PetlExtras lerp(ThemeExtension<PetlExtras>? other, double t) {
    if (other is! PetlExtras) return this;
    return PetlExtras(
      showScanlines: t < 0.5 ? showScanlines : other.showScanlines,
      showPixelGrid: t < 0.5 ? showPixelGrid : other.showPixelGrid,
      gridColor: Color.lerp(gridColor, other.gridColor, t)!,
      scanlineColor: Color.lerp(scanlineColor, other.scanlineColor, t)!,
      glitchPrimary: Color.lerp(glitchPrimary, other.glitchPrimary, t)!,
      glitchSecondary:
          Color.lerp(glitchSecondary, other.glitchSecondary, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetlExtras &&
          showScanlines == other.showScanlines &&
          showPixelGrid == other.showPixelGrid &&
          gridColor == other.gridColor &&
          scanlineColor == other.scanlineColor &&
          glitchPrimary == other.glitchPrimary &&
          glitchSecondary == other.glitchSecondary);

  @override
  int get hashCode => Object.hash(
        showScanlines,
        showPixelGrid,
        gridColor,
        scanlineColor,
        glitchPrimary,
        glitchSecondary,
      );
}

// ──────────────────────────────────────────────
// Mochi Extras
// ──────────────────────────────────────────────

class MochiExtras extends ThemeExtension<MochiExtras> {
  final List<Color> ambientGlowColors;
  final double ambientBlurRadius;
  final double glassBlurIntensity;
  final double glassOpacity;
  final double glassBorderOpacity;
  final Color glassHighlightColor;

  const MochiExtras({
    required this.ambientGlowColors,
    required this.ambientBlurRadius,
    required this.glassBlurIntensity,
    required this.glassOpacity,
    required this.glassBorderOpacity,
    required this.glassHighlightColor,
  });

  @override
  MochiExtras copyWith({
    List<Color>? ambientGlowColors,
    double? ambientBlurRadius,
    double? glassBlurIntensity,
    double? glassOpacity,
    double? glassBorderOpacity,
    Color? glassHighlightColor,
  }) {
    return MochiExtras(
      ambientGlowColors: ambientGlowColors ?? this.ambientGlowColors,
      ambientBlurRadius: ambientBlurRadius ?? this.ambientBlurRadius,
      glassBlurIntensity: glassBlurIntensity ?? this.glassBlurIntensity,
      glassOpacity: glassOpacity ?? this.glassOpacity,
      glassBorderOpacity: glassBorderOpacity ?? this.glassBorderOpacity,
      glassHighlightColor: glassHighlightColor ?? this.glassHighlightColor,
    );
  }

  @override
  MochiExtras lerp(ThemeExtension<MochiExtras>? other, double t) {
    if (other is! MochiExtras) return this;
    return MochiExtras(
      ambientGlowColors:
          t < 0.5 ? ambientGlowColors : other.ambientGlowColors,
      ambientBlurRadius:
          lerpDouble(ambientBlurRadius, other.ambientBlurRadius, t)!,
      glassBlurIntensity:
          lerpDouble(glassBlurIntensity, other.glassBlurIntensity, t)!,
      glassOpacity:
          lerpDouble(glassOpacity, other.glassOpacity, t)!,
      glassBorderOpacity:
          lerpDouble(glassBorderOpacity, other.glassBorderOpacity, t)!,
      glassHighlightColor:
          Color.lerp(glassHighlightColor, other.glassHighlightColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MochiExtras &&
          listEquals(ambientGlowColors, other.ambientGlowColors) &&
          ambientBlurRadius == other.ambientBlurRadius &&
          glassBlurIntensity == other.glassBlurIntensity &&
          glassOpacity == other.glassOpacity &&
          glassBorderOpacity == other.glassBorderOpacity &&
          glassHighlightColor == other.glassHighlightColor);

  @override
  int get hashCode => Object.hash(
        Object.hashAll(ambientGlowColors),
        ambientBlurRadius,
        glassBlurIntensity,
        glassOpacity,
        glassBorderOpacity,
        glassHighlightColor,
      );
}

// ──────────────────────────────────────────────
// Forest Extras
// ──────────────────────────────────────────────

class ForestExtras extends ThemeExtension<ForestExtras> {
  final Color leafAccent;
  final Color mossColor;

  const ForestExtras({
    required this.leafAccent,
    required this.mossColor,
  });

  @override
  ForestExtras copyWith({
    Color? leafAccent,
    Color? mossColor,
  }) {
    return ForestExtras(
      leafAccent: leafAccent ?? this.leafAccent,
      mossColor: mossColor ?? this.mossColor,
    );
  }

  @override
  ForestExtras lerp(ThemeExtension<ForestExtras>? other, double t) {
    if (other is! ForestExtras) return this;
    return ForestExtras(
      leafAccent: Color.lerp(leafAccent, other.leafAccent, t)!,
      mossColor: Color.lerp(mossColor, other.mossColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ForestExtras &&
          leafAccent == other.leafAccent &&
          mossColor == other.mossColor);

  @override
  int get hashCode => Object.hash(leafAccent, mossColor);
}

// ──────────────────────────────────────────────
// Sunset Extras
// ──────────────────────────────────────────────

class SunsetExtras extends ThemeExtension<SunsetExtras> {
  final Color emberColor;
  final Color flameColor;

  const SunsetExtras({
    required this.emberColor,
    required this.flameColor,
  });

  @override
  SunsetExtras copyWith({Color? emberColor, Color? flameColor}) {
    return SunsetExtras(
      emberColor: emberColor ?? this.emberColor,
      flameColor: flameColor ?? this.flameColor,
    );
  }

  @override
  SunsetExtras lerp(ThemeExtension<SunsetExtras>? other, double t) {
    if (other is! SunsetExtras) return this;
    return SunsetExtras(
      emberColor: Color.lerp(emberColor, other.emberColor, t)!,
      flameColor: Color.lerp(flameColor, other.flameColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SunsetExtras &&
          emberColor == other.emberColor &&
          flameColor == other.flameColor);

  @override
  int get hashCode => Object.hash(emberColor, flameColor);
}

// ──────────────────────────────────────────────
// Paper Extras
// ──────────────────────────────────────────────

class PaperExtras extends ThemeExtension<PaperExtras> {
  final Color inkColor;
  final Color parchmentColor;
  final Color siennaAccent;
  final double pageMargin;

  const PaperExtras({
    required this.inkColor,
    required this.parchmentColor,
    required this.siennaAccent,
    required this.pageMargin,
  });

  @override
  PaperExtras copyWith({
    Color? inkColor,
    Color? parchmentColor,
    Color? siennaAccent,
    double? pageMargin,
  }) {
    return PaperExtras(
      inkColor: inkColor ?? this.inkColor,
      parchmentColor: parchmentColor ?? this.parchmentColor,
      siennaAccent: siennaAccent ?? this.siennaAccent,
      pageMargin: pageMargin ?? this.pageMargin,
    );
  }

  @override
  PaperExtras lerp(ThemeExtension<PaperExtras>? other, double t) {
    if (other is! PaperExtras) return this;
    return PaperExtras(
      inkColor: Color.lerp(inkColor, other.inkColor, t)!,
      parchmentColor: Color.lerp(parchmentColor, other.parchmentColor, t)!,
      siennaAccent: Color.lerp(siennaAccent, other.siennaAccent, t)!,
      pageMargin: lerpDouble(pageMargin, other.pageMargin, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaperExtras &&
          inkColor == other.inkColor &&
          parchmentColor == other.parchmentColor &&
          siennaAccent == other.siennaAccent &&
          pageMargin == other.pageMargin);

  @override
  int get hashCode =>
      Object.hash(inkColor, parchmentColor, siennaAccent, pageMargin);
}
