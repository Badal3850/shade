import 'package:flutter/material.dart';
import 'package:shade/core/theme/theme_extensions.dart';
import 'package:shade/core/theme/theme_manager.dart';
import 'package:shade/features/pet/presentation/screens/pet_home_screen.dart';

class BottomNavShell extends StatefulWidget {
  const BottomNavShell({super.key});

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  int _currentIndex = 0;

  static const _screens = <Widget>[
    PetHomeScreen(),
    _PlaceholderTab(label: 'Feed', icon: Icons.list_alt),
    _PlaceholderTab(label: 'Share', icon: Icons.share),
    _PlaceholderTab(label: 'Stats', icon: Icons.bar_chart),
  ];

  @override
  Widget build(BuildContext context) {
    final themeStyle = _resolveTheme(context);
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildNav(context, themeStyle),
    );
  }

  ThemeStyle _resolveTheme(BuildContext context) {
    if (Theme.of(context).extension<PetlExtras>() != null) {
      return ThemeStyle.petlExe;
    }
    if (Theme.of(context).extension<MochiExtras>() != null) {
      return ThemeStyle.mochi;
    }
    return ThemeStyle.classic;
  }

  Widget _buildNav(BuildContext context, ThemeStyle themeStyle) {
    switch (themeStyle) {
      case ThemeStyle.petlExe:
        return _buildPetlNav(context);
      case ThemeStyle.mochi:
        return _buildMochiNav(context);
      case ThemeStyle.classic:
        return _buildClassicNav(context);
    }
  }

  Widget _buildPetlNav(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.primary.withValues(alpha: 0.15)),
        ),
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
        ],
      ),
    );
  }

  Widget _petlNavItem(
      BuildContext context, List<List<bool>> pixels, String label, int index) {
    final colors = Theme.of(context).colorScheme;
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
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
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 5,
              color: active ? colors.primary : colors.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMochiNav(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.outline.withValues(alpha: 0.5)),
        ),
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
        ],
      ),
    );
  }

  Widget _mochiNavItem(
      BuildContext context, String emoji, String label, int index) {
    final colors = Theme.of(context).colorScheme;
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: active
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [
                        colors.primary.withValues(alpha: 0.12),
                        colors.secondary.withValues(alpha: 0.08),
                      ],
                    ),
                    border: Border.all(
                        color: colors.primary.withValues(alpha: 0.2)),
                  )
                : null,
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.05,
              color: active
                  ? colors.primary
                  : colors.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassicNav(BuildContext context) {
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (i) => setState(() => _currentIndex = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.list_alt_outlined), label: 'Feed'),
        NavigationDestination(icon: Icon(Icons.share_outlined), label: 'Share'),
        NavigationDestination(icon: Icon(Icons.bar_chart_outlined), label: 'Stats'),
      ],
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PlaceholderTab({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: colors.primary.withValues(alpha: 0.3)),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.3),
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Coming soon',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.2),
                ),
          ),
        ],
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
    final color = active ? activeColor : inactiveColor;
    return SizedBox(
      width: 32,
      height: 32,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: pixels.map((row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: row.map((on) {
              return Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  color: on ? color : Colors.transparent,
                  boxShadow: active && on
                      ? [BoxShadow(color: activeColor.withValues(alpha: 0.5), blurRadius: 2)]
                      : null,
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
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
