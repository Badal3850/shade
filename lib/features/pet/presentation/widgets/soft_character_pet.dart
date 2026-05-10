import 'package:flutter/material.dart';

class SoftCharacterPet extends StatefulWidget {
  const SoftCharacterPet({super.key});

  @override
  State<SoftCharacterPet> createState() => _SoftCharacterPetState();
}

class _SoftCharacterPetState extends State<SoftCharacterPet>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -10, end: 0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow
          AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, _) {
              return Container(
                width: 140 * _glowAnimation.value,
                height: 140 * _glowAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors.primary.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
          // Pet character
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: Transform.rotate(
                  angle: (_floatAnimation.value / 10) * 0.02,
                  child: _buildCharacter(context),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCharacter(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Tail
          Positioned(
            right: -4,
            top: 50,
            child: Container(
              width: 20,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    const Color(0xFFb08be0).withValues(alpha: 0.6),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
          // Body
          Positioned(
            bottom: 15,
            child: Container(
              width: 76,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(38),
                gradient: const RadialGradient(
                  center: Alignment(0.4, 0.3),
                  colors: [
                    Color(0xFFd4bbff),
                    Color(0xFF9b6fd4),
                  ],
                ),
              ),
            ),
          ),
          // Belly
          Positioned(
            bottom: 25,
            child: Container(
              width: 44,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(22),
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ),
          // Arms
          Positioned(
            bottom: 35,
            left: 2,
            child: Container(
              width: 18,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: const RadialGradient(
                  colors: [Color(0xFFdcc5ff), Color(0xFFb08be0)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            right: 2,
            child: Container(
              width: 18,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: const RadialGradient(
                  colors: [Color(0xFFdcc5ff), Color(0xFFb08be0)],
                ),
              ),
            ),
          ),
          // Head
          Positioned(
            top: 15,
            child: Container(
              width: 68,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(32),
                gradient: const RadialGradient(
                  center: Alignment(0.4, 0.3),
                  colors: [
                    Color(0xFFdcc5ff),
                    Color(0xFFb08be0),
                  ],
                ),
              ),
            ),
          ),
          // Ears
          Positioned(
            top: 3,
            left: 6,
            child: Container(
              width: 22,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                gradient: const RadialGradient(
                  colors: [Color(0xFFdcc5ff), Color(0xFFb08be0)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 3,
            right: 6,
            child: Container(
              width: 22,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                gradient: const RadialGradient(
                  colors: [Color(0xFFdcc5ff), Color(0xFFb08be0)],
                ),
              ),
            ),
          ),
          // Ear inner
          Positioned(
            top: 7,
            left: 10,
            child: Container(
              width: 14,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color(0xFFf4a0b5).withValues(alpha: 0.4),
              ),
            ),
          ),
          Positioned(
            top: 7,
            right: 10,
            child: Container(
              width: 14,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color(0xFFf4a0b5).withValues(alpha: 0.4),
              ),
            ),
          ),
          // Eyes
          Positioned(
            top: 32,
            left: 18,
            child: ClipOval(
              child: Container(
                width: 14,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 1,
                      top: 3,
                      child: ClipOval(
                        child: Container(
                          width: 9,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2a1f3d),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 18,
            child: ClipOval(
              child: Container(
                width: 14,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 3,
                      child: ClipOval(
                        child: Container(
                          width: 9,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2a1f3d),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 2,
                      top: 2,
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Blush
          Positioned(
            top: 48,
            left: 8,
            child: ClipOval(
              child: Container(
                width: 14,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFf4a0b5).withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
          Positioned(
            top: 48,
            right: 8,
            child: ClipOval(
              child: Container(
                width: 14,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFf4a0b5).withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
          // Nose
          Positioned(
            top: 45,
            child: ClipOval(
              child: Container(
                width: 7,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFf4a0b5).withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
          // Feet
          Positioned(
            bottom: 2,
            left: 10,
            child: Container(
              width: 26,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: const RadialGradient(
                  colors: [Color(0xFFdcc5ff), Color(0xFFb08be0)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 10,
            child: Container(
              width: 26,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: const RadialGradient(
                  colors: [Color(0xFFdcc5ff), Color(0xFFb08be0)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
