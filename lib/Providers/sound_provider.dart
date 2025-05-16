import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundProvider with ChangeNotifier {
  double _volume = 0.7;
  bool _soundEnabled = true;

  double get volume => _volume;
  bool get soundEnabled => _soundEnabled;

  SoundProvider() {
    _loadSoundSettings();
  }

  Future<void> _loadSoundSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _volume = prefs.getDouble('sound_volume') ?? 0.7;
    _soundEnabled = prefs.getBool('sound_enabled') ?? true;
    notifyListeners();
  }

  Future<void> setVolume(double value) async {
    _volume = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('sound_volume', value);

    // Here you would implement the actual volume change
    // using a package like audioplayers or just_audio
    debugPrint('Setting volume to: $value');

    notifyListeners();
  }

  Future<void> toggleSound(bool value) async {
    _soundEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sound_enabled', value);

    // Here you would implement the actual sound toggle
    debugPrint('Sound enabled: $value');

    notifyListeners();
  }

  // Method to play a sound effect
  Future<void> playSound(String soundName) async {
    if (!_soundEnabled) return;

    // Here you would implement the actual sound playback
    // using a package like audioplayers or just_audio
    debugPrint('Playing sound: $soundName at volume $_volume');
  }
}
