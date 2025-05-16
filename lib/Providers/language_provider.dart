import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLanguage = 'English';
  
  final Map<String, Map<String, String>> _localizedValues = {
    'English': {
      'settings': 'Settings',
      'profile': 'Profile',
      'notifications': 'Notifications',
      'darkMode': 'Dark Mode',
      'language': 'Language',
      'soundVolume': 'Sound Volume',
      'help': 'Help & Support',
      'about': 'About',
      'saveSettings': 'Save Settings',
      'logout': 'Log Out',
      'editProfile': 'Edit Profile',
      'receiveUpdates': 'Receive quiz reminders and updates',
      'switchThemes': 'Switch between light and dark themes',
      'chooseLanguage': 'Choose your preferred language',
      'adjustSound': 'Adjust game sound effects',
      'getHelp': 'Get help and contact support',
      'learnMore': 'Learn more about the app',
    },
    'Spanish': {
      'settings': 'Configuración',
      'profile': 'Perfil',
      'notifications': 'Notificaciones',
      'darkMode': 'Modo Oscuro',
      'language': 'Idioma',
      'soundVolume': 'Volumen de Sonido',
      'help': 'Ayuda y Soporte',
      'about': 'Acerca de',
      'saveSettings': 'Guardar Configuración',
      'logout': 'Cerrar Sesión',
      'editProfile': 'Editar Perfil',
      'receiveUpdates': 'Recibir recordatorios y actualizaciones de cuestionarios',
      'switchThemes': 'Cambiar entre temas claros y oscuros',
      'chooseLanguage': 'Elige tu idioma preferido',
      'adjustSound': 'Ajustar efectos de sonido del juego',
      'getHelp': 'Obtener ayuda y contactar con soporte',
      'learnMore': 'Más información sobre la aplicación',
    },
    'French': {
      'settings': 'Paramètres',
      'profile': 'Profil',
      'notifications': 'Notifications',
      'darkMode': 'Mode Sombre',
      'language': 'Langue',
      'soundVolume': 'Volume Sonore',
      'help': 'Aide et Support',
      'about': 'À Propos',
      'saveSettings': 'Enregistrer les Paramètres',
      'logout': 'Déconnexion',
      'editProfile': 'Modifier le Profil',
      'receiveUpdates': 'Recevoir des rappels et mises à jour de quiz',
      'switchThemes': 'Basculer entre thèmes clair et sombre',
      'chooseLanguage': 'Choisissez votre langue préférée',
      'adjustSound': 'Ajuster les effets sonores du jeu',
      'getHelp': 'Obtenir de l\'aide et contacter le support',
      'learnMore': 'En savoir plus sur l\'application',
    },
    'German': {
      'settings': 'Einstellungen',
      'profile': 'Profil',
      'notifications': 'Benachrichtigungen',
      'darkMode': 'Dunkelmodus',
      'language': 'Sprache',
      'soundVolume': 'Tonlautstärke',
      'help': 'Hilfe & Support',
      'about': 'Über',
      'saveSettings': 'Einstellungen Speichern',
      'logout': 'Abmelden',
      'editProfile': 'Profil Bearbeiten',
      'receiveUpdates': 'Quiz-Erinnerungen und Updates erhalten',
      'switchThemes': 'Zwischen hellen und dunklen Designs wechseln',
      'chooseLanguage': 'Wählen Sie Ihre bevorzugte Sprache',
      'adjustSound': 'Spielsoundeffekte anpassen',
      'getHelp': 'Hilfe erhalten und Support kontaktieren',
      'learnMore': 'Mehr über die App erfahren',
    },
    'Chinese': {
      'settings': '设置',
      'profile': '个人资料',
      'notifications': '通知',
      'darkMode': '深色模式',
      'language': '语言',
      'soundVolume': '音量',
      'help': '帮助与支持',
      'about': '关于',
      'saveSettings': '保存设置',
      'logout': '退出登录',
      'editProfile': '编辑个人资料',
      'receiveUpdates': '接收测验提醒和更新',
      'switchThemes': '在浅色和深色主题之间切换',
      'chooseLanguage': '选择您喜欢的语言',
      'adjustSound': '调整游戏音效',
      'getHelp': '获取帮助并联系支持',
      'learnMore': '了解有关应用程序的更多信息',
    },
  };
  
  String get currentLanguage => _currentLanguage;
  
  LanguageProvider() {
    _loadLanguage();
  }
  
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('selected_language') ?? 'English';
    notifyListeners();
  }
  
  Future<void> setLanguage(String language) async {
    if (_localizedValues.containsKey(language)) {
      _currentLanguage = language;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_language', language);
      notifyListeners();
    }
  }
  
  String translate(String key) {
    return _localizedValues[_currentLanguage]?[key] ?? 
           _localizedValues['English']?[key] ?? 
           key;
  }
}