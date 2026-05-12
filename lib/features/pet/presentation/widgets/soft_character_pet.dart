import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shade/features/pet/presentation/providers/pet_state_provider.dart';

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
  late final AnimationController _jumpController;
  late final Animation<double> _jumpAnimation;

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
    _jumpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _jumpAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -30), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -30, end: 0), weight: 50),
    ]).animate(CurvedAnimation(parent: _jumpController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _floatController.dispose();
    _glowController.dispose();
    _jumpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final provider = context.watch<PetStateProvider>();
    final petState = provider.petState;
    final sensorReading = provider.sensorReading;

    if (provider.isPetJumping && !_jumpController.isAnimating) {
      _jumpController.forward(from: 0).then((_) {
        provider.setPetJumping(false);
      });
    }
    
    // Calculate tilt from accelerometer (normalized roughly)
    final tiltX = (sensorReading.accelerometerX ?? 0).clamp(-5, 5) / 5.0;
    final tiltY = (sensorReading.accelerometerY ?? 0).clamp(-5, 5) / 5.0;

    return SizedBox(
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow
          AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, _) {
              final glowColor = petState.health < 30
                  ? const Color(0xFFff2d78)
                  : colors.primary;
              return Container(
                width: 140 * _glowAnimation.value,
                height: 140 * _glowAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      glowColor.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
          // Pet character
          AnimatedBuilder(
            animation: Listenable.merge([_floatAnimation, _jumpAnimation]),
            builder: (context, _) {
              return Transform(
                transform: Matrix4.identity()
                  ..translateByDouble(0.0, _floatAnimation.value + _jumpAnimation.value, 0, 1)
                  ..rotateZ((_floatAnimation.value / 10) * 0.02)
                  ..rotateY(tiltX * 0.2)
                  ..rotateX(-tiltY * 0.1),
                alignment: Alignment.center,
                child: _buildCharacter(context, tiltX, tiltY, petState.mood),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCharacter(BuildContext context, double tiltX, double tiltY, int mood) {
    final eyeWidth = mood < 40 ? 12.0 : 14.0;
    final eyeHeight = mood < 40 ? 10.0 : 16.0;
    final eyeTopRadius = mood < 40 ? const Radius.circular(5) : const Radius.circular(7);
    final eyeBottomRadius = mood < 40 ? const Radius.circular(2) : const Radius.circular(7);
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
            top: 32 + (tiltY * 2),
            left: 18 + (tiltX * 3),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: eyeTopRadius,
                topRight: eyeTopRadius,
                bottomLeft: eyeBottomRadius,
                bottomRight: eyeBottomRadius,
              ),
              child: Container(
                width: eyeWidth,
                height: eyeHeight,
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
            top: 32 + (tiltY * 2),
            right: 18 - (tiltX * 3),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: eyeTopRadius,
                topRight: eyeTopRadius,
                bottomLeft: eyeBottomRadius,
                bottomRight: eyeBottomRadius,
              ),
              child: Container(
                width: eyeWidth,
                height: eyeHeight,
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
