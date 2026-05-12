import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shade/features/onboarding/pet_name_manager.dart';
import 'package:shade/features/pet/presentation/providers/pet_state_provider.dart';

class PixelGridPet extends StatefulWidget {
  const PixelGridPet({super.key});

  @override
  State<PixelGridPet> createState() => _PixelGridPetState();
}

class _PixelGridPetState extends State<PixelGridPet>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;
  late final AnimationController _jumpController;
  late final Animation<double> _jumpAnimation;

  static const _cellSize = 12.0;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -8, end: 0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _jumpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _jumpAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -40), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -40, end: 0), weight: 50),
    ]).animate(CurvedAnimation(parent: _jumpController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _floatController.dispose();
    _jumpController.dispose();
    super.dispose();
  }

  static String _moodLabel(int mood) {
    if (mood >= 70) return 'HAPPY ★';
    if (mood >= 40) return 'OKAY ~';
    if (mood >= 20) return 'SAD...';
    return 'CRITICAL !!';
  }

  static Color _badgeColor(int health) {
    if (health >= 70) return const Color(0xFFffee00);
    if (health >= 40) return const Color(0xFFff8800);
    return const Color(0xFFff2d78);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final provider = context.watch<PetStateProvider>();
    final petState = provider.petState;
    final petName = context.read<PetNameManager>().name;
    final sensorReading = provider.sensorReading;

    if (provider.isPetJumping && !_jumpController.isAnimating) {
      _jumpController.forward(from: 0).then((_) {
        provider.setPetJumping(false);
      });
    }

    // Calculate tilt
    final tiltX = (sensorReading.accelerometerX ?? 0).clamp(-5, 5) / 5.0;
    final tiltY = (sensorReading.accelerometerY ?? 0).clamp(-5, 5) / 5.0;
    return Semantics(
      label: 'Pet character display',
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 240),
        child: Stack(
          children: [
            // Grid overlay background
            Positioned.fill(
              child: ExcludeSemantics(
                child: CustomPaint(
                  painter: _GridPainter(
                    gridColor: colors.primary.withValues(alpha: 0.04),
                  ),
                ),
              ),
            ),
            // Scanline sweep
            Positioned.fill(
              child: ExcludeSemantics(
                child: _ScanlineSweep(
                  scanlineColor: colors.primary.withValues(alpha: 0.08),
                ),
              ),
            ),
            // Animated pet
            Center(
              child: AnimatedBuilder(
                animation: _floatAnimation,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..translateByDouble(
                        tiltX * 15,
                        _floatAnimation.value +
                            _jumpAnimation.value +
                            (tiltY * 5),
                        0,
                        1,
                      ),
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Mood badge
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      color: _badgeColor(petState.health),
                      child: Text(
                        petName.isNotEmpty
                            ? '${petName.toUpperCase()} · ${_moodLabel(petState.mood)}'
                            : _moodLabel(petState.mood),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 7,
                          color: Color(0xFF0a0a0f),
                        ),
                      ),
                    ),
                    // Pixel grid
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _pixels.map((row) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: row.map((code) {
                            return Container(
                              width: _cellSize,
                              height: _cellSize,
                              margin: const EdgeInsets.all(0.5),
                              decoration: BoxDecoration(
                                color: _colorFromCode(code),
                              ),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Floor
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: ExcludeSemantics(
                child: CustomPaint(
                  painter: _DashPainter(
                    color: colors.primary.withValues(alpha: 0.4),
                  ),
                  size: const Size(double.infinity, 2),
                ),
              ),
            ),
            // Shadow
            Positioned(
              bottom: 14,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _floatAnimation,
                builder: (context, _) {
                  final shadowScale =
                      1 - (_floatAnimation.value.abs() / 16) * 0.3;
                  final shadowOpacity =
                      0.6 - (_floatAnimation.value.abs() / 16) * 0.3;
                  return Center(
                    child: Transform.scale(
                      scaleX: shadowScale,
                      child: ClipOval(
                        child: Container(
                          width: 80,
                          height: 8,
                          color: colors.primary.withValues(
                            alpha: shadowOpacity * 0.5,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Corner decorations
            Positioned(
              top: 0,
              left: 0,
              child: ExcludeSemantics(
                child: _CornerBracket(
                  color: colors.primary,
                  corner: Corner.topLeft,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ExcludeSemantics(
                child: _CornerBracket(
                  color: colors.primary,
                  corner: Corner.bottomRight,
                ),
              ),
            ),
            // Labels
            Positioned(
              top: 8,
              left: 8,
              child: _BlinkingLabel('LIVE FEED', colors.secondary),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: _BlinkingLabel('● REC', colors.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helper Widgets ──

class _BlinkingLabel extends StatefulWidget {
  final String text;
  final Color color;
  const _BlinkingLabel(this.text, this.color);

  @override
  State<_BlinkingLabel> createState() => _BlinkingLabelState();
}

class _BlinkingLabelState extends State<_BlinkingLabel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Text(
        widget.text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 6,
          color: widget.color,
        ),
      ),
    );
  }
}

class _ScanlineSweep extends StatefulWidget {
  final Color scanlineColor;
  const _ScanlineSweep({required this.scanlineColor});

  @override
  State<_ScanlineSweep> createState() => _ScanlineSweepState();
}

class _ScanlineSweepState extends State<_ScanlineSweep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _animation = Tween<double>(begin: -0.1, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Align(
          alignment: Alignment(0, (_animation.value * 2) - 1),
          child: IgnorePointer(
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    widget.scanlineColor,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CornerBracket extends StatelessWidget {
  final Color color;
  final Corner corner;
  const _CornerBracket({required this.color, required this.corner});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        border: Border(
          top: corner == Corner.topLeft
              ? BorderSide(color: color, width: 2)
              : BorderSide.none,
          left: corner == Corner.topLeft
              ? BorderSide(color: color, width: 2)
              : BorderSide.none,
          bottom: corner == Corner.bottomRight
              ? BorderSide(color: color, width: 2)
              : BorderSide.none,
          right: corner == Corner.bottomRight
              ? BorderSide(color: color, width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }
}

enum Corner { topLeft, bottomRight }

// ── Painters ──

class _GridPainter extends CustomPainter {
  final Color gridColor;
  _GridPainter({required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashPainter extends CustomPainter {
  final Color color;
  _DashPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + 8, 0), paint);
      x += 16;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Pixel Data ──

Color _colorFromCode(String code) {
  switch (code) {
    case 'c':
      return const Color(0xFF00ffee);
    case 'p':
      return const Color(0xFF9b00ff);
    case 'k':
      return const Color(0xFFff2d78);
    case 'y':
      return const Color(0xFFffee00);
    case 'g':
      return const Color(0xFF00ff88);
    case 'w':
      return const Color(0xFFffffff);
    case 'b':
      return const Color(0xFF0a0a0f);
    case 'd':
      return const Color(0xFF1a1a3e);
    default:
      return Colors.transparent;
  }
}

const _pixels = <List<String>>[
  // Row 0
  [
    'n',
    'n',
    'n',
    'n',
    'n',
    'p',
    'p',
    'p',
    'p',
    'p',
    'p',
    'n',
    'n',
    'n',
    'n',
    'n',
  ],
  // Row 1
  [
    'n',
    'n',
    'n',
    'p',
    'p',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'p',
    'p',
    'n',
    'n',
    'n',
  ],
  // Row 2
  [
    'n',
    'n',
    'p',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'p',
    'n',
    'n',
  ],
  // Row 3 — eyes
  [
    'n',
    'p',
    'c',
    'c',
    'w',
    'w',
    'c',
    'c',
    'c',
    'w',
    'w',
    'c',
    'c',
    'c',
    'p',
    'n',
  ],
  // Row 4 — pupils
  [
    'n',
    'p',
    'c',
    'c',
    'w',
    'b',
    'c',
    'c',
    'c',
    'w',
    'b',
    'c',
    'c',
    'c',
    'p',
    'n',
  ],
  // Row 5
  [
    'n',
    'p',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'p',
    'n',
  ],
  // Row 6 — mouth
  [
    'n',
    'p',
    'c',
    'c',
    'c',
    'k',
    'k',
    'k',
    'k',
    'k',
    'c',
    'c',
    'c',
    'c',
    'p',
    'n',
  ],
  // Row 7
  [
    'n',
    'p',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'p',
    'n',
  ],
  // Row 8
  [
    'n',
    'n',
    'p',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'p',
    'n',
    'n',
  ],
  // Row 9 — belly
  [
    'p',
    'n',
    'p',
    'c',
    'y',
    'y',
    'c',
    'c',
    'c',
    'c',
    'y',
    'y',
    'c',
    'p',
    'n',
    'p',
  ],
  // Row 10
  [
    'c',
    'p',
    'n',
    'p',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'c',
    'p',
    'n',
    'p',
    'c',
  ],
  // Row 11 — arms
  [
    'c',
    'c',
    'p',
    'n',
    'p',
    'c',
    'c',
    'c',
    'c',
    'c',
    'p',
    'n',
    'p',
    'c',
    'c',
    'c',
  ],
  // Row 12
  [
    'n',
    'n',
    'n',
    'n',
    'p',
    'c',
    'c',
    'c',
    'c',
    'c',
    'p',
    'n',
    'n',
    'n',
    'n',
    'n',
  ],
  // Row 13 — legs
  [
    'n',
    'n',
    'n',
    'p',
    'c',
    'c',
    'n',
    'n',
    'n',
    'c',
    'c',
    'p',
    'n',
    'n',
    'n',
    'n',
  ],
  // Row 14
  [
    'n',
    'n',
    'n',
    'p',
    'c',
    'c',
    'n',
    'n',
    'n',
    'c',
    'c',
    'p',
    'n',
    'n',
    'n',
    'n',
  ],
  // Row 15 — feet
  [
    'n',
    'n',
    'p',
    'c',
    'c',
    'p',
    'n',
    'n',
    'n',
    'p',
    'c',
    'c',
    'p',
    'n',
    'n',
    'n',
  ],
];
