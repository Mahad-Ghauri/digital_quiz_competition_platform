import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLanguage = 'English';
  
  final Map<String, Map<String, String>> _localizedValues = {
    'English': {
      // Settings
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
      
      // Blog
      'blogs': 'Blogs',
      'blogDetails': 'Blog Details',
      'relatedArticles': 'Related Articles',
      'relatedArticlesPlaceholder': 'Related articles will appear here',
      'author': 'Author',
      'date': 'Date',
      'readMore': 'Read More',
      
      // Blog Tags
      'civics': 'Civics',
      'citizenship': 'Citizenship',
      'responsibility': 'Responsibility',
      'quiz': 'Quiz',
      'learning': 'Learning',
      'competition': 'Competition',
      'community': 'Community',
      'engagement': 'Engagement',
      'socialImpact': 'Social Impact',
      'youth': 'Youth',
      'civicAction': 'Civic Action',
      'leadership': 'Leadership',
      'voting': 'Voting',
      'democracy': 'Democracy',
      'rights': 'Rights',
      'environment': 'Environment',
      'sustainability': 'Sustainability',
      'law': 'Law',
      'civicEducation': 'Civic Education',
      'activism': 'Activism',
      'change': 'Change',
      'inclusion': 'Inclusion',
      'equality': 'Equality',
    },
    'Spanish': {
      // Settings
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
      
      // Blog
      'blogs': 'Blogs',
      'blogDetails': 'Detalles del Blog',
      'relatedArticles': 'Artículos Relacionados',
      'relatedArticlesPlaceholder': 'Los artículos relacionados aparecerán aquí',
      'author': 'Autor',
      'date': 'Fecha',
      'readMore': 'Leer Más',
      
      // Blog Tags
      'civics': 'Educación Cívica',
      'citizenship': 'Ciudadanía',
      'responsibility': 'Responsabilidad',
      'quiz': 'Cuestionario',
      'learning': 'Aprendizaje',
      'competition': 'Competencia',
      'community': 'Comunidad',
      'engagement': 'Compromiso',
      'socialImpact': 'Impacto Social',
      'youth': 'Juventud',
      'civicAction': 'Acción Cívica',
      'leadership': 'Liderazgo',
      'voting': 'Votación',
      'democracy': 'Democracia',
      'rights': 'Derechos',
      'environment': 'Medio Ambiente',
      'sustainability': 'Sostenibilidad',
      'law': 'Ley',
      'civicEducation': 'Educación Cívica',
      'activism': 'Activismo',
      'change': 'Cambio',
      'inclusion': 'Inclusión',
      'equality': 'Igualdad',
    },
    'French': {
      // Settings
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
      
      // Blog
      'blogs': 'Blogs',
      'blogDetails': 'Détails du Blog',
      'relatedArticles': 'Articles Connexes',
      'relatedArticlesPlaceholder': 'Les articles connexes apparaîtront ici',
      'author': 'Auteur',
      'date': 'Date',
      'readMore': 'Lire Plus',
      
      // Blog Tags
      'civics': 'Éducation Civique',
      'citizenship': 'Citoyenneté',
      'responsibility': 'Responsabilité',
      'quiz': 'Quiz',
      'learning': 'Apprentissage',
      'competition': 'Compétition',
      'community': 'Communauté',
      'engagement': 'Engagement',
      'socialImpact': 'Impact Social',
      'youth': 'Jeunesse',
      'civicAction': 'Action Civique',
      'leadership': 'Leadership',
      'voting': 'Vote',
      'democracy': 'Démocratie',
      'rights': 'Droits',
      'environment': 'Environnement',
      'sustainability': 'Durabilité',
      'law': 'Loi',
      'civicEducation': 'Éducation Civique',
      'activism': 'Activisme',
      'change': 'Changement',
      'inclusion': 'Inclusion',
      'equality': 'Égalité',
    },
    'German': {
      // Settings
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
      
      // Blog
      'blogs': 'Blogs',
      'blogDetails': 'Blog-Details',
      'relatedArticles': 'Verwandte Artikel',
      'relatedArticlesPlaceholder': 'Verwandte Artikel werden hier angezeigt',
      'author': 'Autor',
      'date': 'Datum',
      'readMore': 'Weiterlesen',
      
      // Blog Tags
      'civics': 'Staatsbürgerkunde',
      'citizenship': 'Staatsbürgerschaft',
      'responsibility': 'Verantwortung',
      'quiz': 'Quiz',
      'learning': 'Lernen',
      'competition': 'Wettbewerb',
      'community': 'Gemeinschaft',
      'engagement': 'Engagement',
      'socialImpact': 'Soziale Auswirkungen',
      'youth': 'Jugend',
      'civicAction': 'Bürgerliches Engagement',
      'leadership': 'Führung',
      'voting': 'Abstimmung',
      'democracy': 'Demokratie',
      'rights': 'Rechte',
      'environment': 'Umwelt',
      'sustainability': 'Nachhaltigkeit',
      'law': 'Gesetz',
      'civicEducation': 'Politische Bildung',
      'activism': 'Aktivismus',
      'change': 'Veränderung',
      'inclusion': 'Inklusion',
      'equality': 'Gleichheit',
    },
    'Chinese': {
      // Settings
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
      
      // Blog
      'blogs': '博客',
      'blogDetails': '博客详情',
      'relatedArticles': '相关文章',
      'relatedArticlesPlaceholder': '相关文章将显示在这里',
      'author': '作者',
      'date': '日期',
      'readMore': '阅读更多',
      
      // Blog Tags
      'civics': '公民教育',
      'citizenship': '公民身份',
      'responsibility': '责任',
      'quiz': '测验',
      'learning': '学习',
      'competition': '竞赛',
      'community': '社区',
      'engagement': '参与',
      'socialImpact': '社会影响',
      'youth': '青年',
      'civicAction': '公民行动',
      'leadership': '领导力',
      'voting': '投票',
      'democracy': '民主',
      'rights': '权利',
      'environment': '环境',
      'sustainability': '可持续性',
      'law': '法律',
      'civicEducation': '公民教育',
      'activism': '行动主义',
      'change': '变革',
      'inclusion': '包容',
      'equality': '平等',
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