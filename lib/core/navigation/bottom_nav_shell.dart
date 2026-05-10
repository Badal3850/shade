import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shade/core/theme/theme_extensions.dart';
import 'package:shade/core/theme/theme_manager.dart';
import 'package:shade/features/pet/presentation/screens/pet_home_screen.dart';
import 'package:shade/features/pet/presentation/screens/pet_feed_screen.dart';
import 'package:shade/features/pet/presentation/screens/pet_stats_screen.dart';
import 'package:shade/features/pet/presentation/screens/shade_picker_screen.dart';
import 'package:shade/features/pet/presentation/widgets/story_card_renderer.dart';
import 'package:animations/animations.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BottomNavShell extends StatefulWidget {
  const BottomNavShell({super.key});

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  int _currentIndex = 0;

  static const _screens = <Widget>[
    PetHomeScreen(),
    PetFeedScreen(),
    StoryCardRenderer(),
    PetStatsScreen(),
    ShadePickerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeStyle = _resolveTheme(context);
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentIndex != 0) {
          setState(() => _currentIndex = 0);
        }
      },
      child: Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 400),
          reverse: false,
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: KeyedSubtree(
            key: ValueKey<int>(_currentIndex),
            child: _screens[_currentIndex],
          ),
        ),
        bottomNavigationBar: _buildNav(context, themeStyle),
      ),
    );
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    HapticFeedback.lightImpact();
    setState(() => _currentIndex = index);
  }

  ThemeStyle _resolveTheme(BuildContext context) {
    if (Theme.of(context).extension<PetlExtras>() != null) return ThemeStyle.petlExe;
    if (Theme.of(context).extension<MochiExtras>() != null) return ThemeStyle.mochi;
    if (Theme.of(context).extension<ForestExtras>() != null) return ThemeStyle.forest;
    if (Theme.of(context).extension<SunsetExtras>() != null) return ThemeStyle.sunset;
    return ThemeStyle.paper;
  }

  Widget _buildNav(BuildContext context, ThemeStyle themeStyle) {
    return switch (themeStyle) {
      ThemeStyle.petlExe => _buildPetlNav(context),
      ThemeStyle.mochi => _buildMochiNav(context),
      ThemeStyle.forest => _buildForestNav(context),
      ThemeStyle.sunset => _buildSunsetNav(context),
      ThemeStyle.paper => _buildPaperNav(context),
    };
  }

  Widget _buildPetlNav(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.primary.withValues(alpha: 0.15))),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _petlNavItem(context, _pixelHome, 'HOME', 0),
          _petlNavItem(context, _pixelFeed, 'FEED', 1),
          _petlNavItem(context, _pixelShare, 'SHARE', 2),
          _petlNavItem(context, _pixelStats, 'STATS', 3),
          _petlNavItem(context, _pixelShade, 'SHADE', 4),
        ],
      ),
    );
  }

  Widget _petlNavItem(BuildContext context, List<List<bool>> pixels, String label, int index) {
    final colors = Theme.of(context).colorScheme;
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PixelIcon(
            pixels: pixels,
            activeColor: colors.primary,
            inactiveColor: colors.onSurface.withValues(alpha: 0.3),
            active: active,
          ),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 5,
                color: active ? colors.primary : colors.onSurface.withValues(alpha: 0.4),
              )),
        ],
      ),
    );
  }

  Widget _buildMochiNav(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.outline.withValues(alpha: 0.5))),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _mochiNavItem(context, '🏠', 'Home', 0),
          _mochiNavItem(context, '📜', 'Feed', 1),
          _mochiNavItem(context, '✦', 'Share', 2),
          _mochiNavItem(context, '📊', 'Stats', 3),
          _mochiNavItem(context, '🎨', 'Shade', 4),
        ],
      ),
    );
  }

  Widget _mochiNavItem(BuildContext context, String emoji, String label, int index) {
    final colors = Theme.of(context).colorScheme;
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: active
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(colors: [
                      colors.primary.withValues(alpha: 0.12),
                      colors.secondary.withValues(alpha: 0.08),
                    ]),
                    border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
                  )
                : null,
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 5),
          Text(label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.05,
                color: active ? colors.primary : colors.onSurface.withValues(alpha: 0.4),
              )),
        ],
      ),
    );
  }

  Widget _buildForestNav(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _forestNavItem(context, Icons.eco, 0),
          _forestNavItem(context, Icons.auto_stories, 1),
          _forestNavItem(context, Icons.forest, 2),
          _forestNavItem(context, Icons.insert_chart, 3),
          _forestNavItem(context, Icons.palette, 4),
        ],
      ),
    );
  }

  Widget _forestNavItem(BuildContext context, IconData icon, int index) {
    final colors = Theme.of(context).colorScheme;
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? colors.primary.withValues(alpha: 0.15) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: active ? colors.primary : colors.onSurface.withValues(alpha: 0.4)),
      ),
    );
  }

  Widget _buildSunsetNav(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      color: colors.surface,
      height: 70,
      child: Row(
        children: [
          for (int i = 0; i < 5; i++)
            Expanded(
              child: InkWell(
                onTap: () => _onTabTapped(i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      [Icons.home, Icons.rss_feed, Icons.flare, Icons.assessment, Icons.brush][i],
                      color: _currentIndex == i ? colors.primary : colors.onSurface.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 4),
                    if (_currentIndex == i)
                      Container(width: 4, height: 4, decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaperNav(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.primary.withValues(alpha: 0.1), width: 2)),
      ),
      padding: const EdgeInsets.only(bottom: 24, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _paperNavItem(context, 'Home', 0),
          _paperNavItem(context, 'Feed', 1),
          _paperNavItem(context, 'Share', 2),
          _paperNavItem(context, 'Stats', 3),
          _paperNavItem(context, 'Shade', 4),
        ],
      ),
    );
  }

  Widget _paperNavItem(BuildContext context, String label, int index) {
    final colors = Theme.of(context).colorScheme;
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'serif',
          fontSize: 14,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          fontStyle: active ? FontStyle.italic : FontStyle.normal,
          color: active ? colors.primary : colors.onSurface.withValues(alpha: 0.4),
          decoration: active ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}



// ── Pixel Icon Widget ──

class _PixelIcon extends StatelessWidget {
  final List<List<bool>> pixels;
  final Color activeColor;
  final Color inactiveColor;
  final bool active;

  const _PixelIcon({
    required this.pixels,
    required this.activeColor,
    required this.inactiveColor,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(30, 30),
      painter: _PixelIconPainter(
        pixels: pixels,
        color: active ? activeColor : inactiveColor,
        glow: active,
      ),
    ).animate(target: active ? 1 : 0).scale(
          begin: const Offset(1, 1),
          end: const Offset(1.1, 1.1),
          duration: 200.ms,
          curve: Curves.easeOutBack,
        );
  }
}

class _PixelIconPainter extends CustomPainter {
  final List<List<bool>> pixels;
  final Color color;
  final bool glow;

  _PixelIconPainter({required this.pixels, required this.color, this.glow = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final pixelSize = size.width / 5;

    if (glow) {
      final glowPaint = Paint()
        ..color = color.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      
      for (int y = 0; y < pixels.length; y++) {
        for (int x = 0; x < pixels[y].length; x++) {
          if (pixels[y][x]) {
            canvas.drawRect(
              Rect.fromLTWH(x * pixelSize, y * pixelSize, pixelSize, pixelSize),
              glowPaint,
            );
          }
        }
      }
    }

    for (int y = 0; y < pixels.length; y++) {
      for (int x = 0; x < pixels[y].length; x++) {
        if (pixels[y][x]) {
          canvas.drawRect(
            Rect.fromLTWH(x * pixelSize, y * pixelSize, pixelSize - 1, pixelSize - 1),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PixelIconPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.glow != glow;
}

// ── Pixel Icon Data (5x5 grids from HTML concept) ──

const _pixelHome = [
  [false, false, true, false, false],
  [false, true, true, true, false],
  [true, true, true, true, true],
  [false, true, true, true, false],
  [false, true, true, true, false],
];

const _pixelFeed = [
  [true, true, true, true, true],
  [false, false, false, false, false],
  [true, true, true, false, false],
  [false, false, false, false, false],
  [true, true, true, true, false],
];

const _pixelShare = [
  [false, false, true, false, false],
  [false, true, true, true, false],
  [true, true, true, true, true],
  [false, true, true, true, false],
  [false, false, true, false, false],
];

const _pixelStats = [
  [false, false, false, true, true],
  [false, false, true, true, true],
  [false, true, true, true, true],
  [true, true, true, true, true],
  [true, true, true, true, true],
];

const _pixelShade = [
  [false, true, true, true, false],
  [true, true, false, true, true],
  [true, false, false, false, true],
  [true, true, false, true, true],
  [false, true, true, true, false],
];
