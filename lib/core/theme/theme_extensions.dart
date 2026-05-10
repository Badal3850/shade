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
