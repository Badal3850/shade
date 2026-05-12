import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shade/core/theme/theme_manager.dart';
import 'package:shade/features/onboarding/pet_name_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final themeManager = context.watch<ThemeManager>();
    final nameManager = context.read<PetNameManager>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  'name your\nshade.',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _controller,
                  autofocus: true,
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: 'e.g. Biscuit, Void, Chaos',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Give it a name.' : null,
                ),
                const SizedBox(height: 24),
                Text(
                  'pick a vibe',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.5,
                    color: colors.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ThemeStyle.values.map((style) {
                    final selected = themeManager.currentStyle == style;
                    return GestureDetector(
                      onTap: () => themeManager.setStyle(style),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _styleColor(style),
                          border: Border.all(
                            color: selected
                                ? colors.primary
                                : Colors.transparent,
                            width: 3,
                          ),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: colors.primary.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                  )
                                ]
                              : null,
                        ),
                        child: selected
                            ? Icon(Icons.check, size: 20, color: colors.onPrimary)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ThemeStyle.values
                      .map((s) => SizedBox(
                            width: 48,
                            child: Text(
                              s.label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8,
                                color: colors.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await nameManager.setName(_controller.text);
                      await nameManager.completeOnboarding();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacementNamed('/');
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text("let's go"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _styleColor(ThemeStyle style) {
    return switch (style) {
      ThemeStyle.paper => const Color(0xFFE8E0D5),
      ThemeStyle.petlExe => const Color(0xFF0a0a0f),
      ThemeStyle.mochi => const Color(0xFFE8D5F0),
      ThemeStyle.forest => const Color(0xFF2D5A27),
      ThemeStyle.sunset => const Color(0xFFFF6B35),
    };
  }
}
