import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetNameManager extends ChangeNotifier {
  static const _nameKey = 'pet_name';
  static const _onboardedKey = 'onboarding_done';

  final SharedPreferences _prefs;

  String _name = '';
  bool _onboardingDone = false;

  PetNameManager(this._prefs) {
    _name = _prefs.getString(_nameKey) ?? '';
    _onboardingDone = _prefs.getBool(_onboardedKey) ?? false;
  }

  String get name => _name;
  bool get onboardingDone => _onboardingDone;
  bool get hasName => _name.isNotEmpty;

  Future<void> setName(String name) async {
    _name = name.trim();
    await _prefs.setString(_nameKey, _name);
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _onboardingDone = true;
    await _prefs.setBool(_onboardedKey, true);
    notifyListeners();
  }
}
