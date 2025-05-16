import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  bool _notificationsEnabled = true;
  
  bool get notificationsEnabled => _notificationsEnabled;
  
  NotificationProvider() {
    _loadNotificationSettings();
  }
  
  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    notifyListeners();
  }
  
  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    
    if (value) {
      // Enable notifications logic here
      debugPrint('Notifications enabled');
    } else {
      // Disable notifications logic here
      debugPrint('Notifications disabled');
    }
    
    notifyListeners();
  }
  
  // Method to schedule a notification
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    if (!_notificationsEnabled) return;
    
    // Here you would implement the actual notification scheduling
    // using a package like flutter_local_notifications
    debugPrint('Scheduling notification: $title at $scheduledTime');
  }
  
  // Method to show an immediate notification
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    if (!_notificationsEnabled) return;
    
    // Here you would implement the actual notification display
    // using a package like flutter_local_notifications
    debugPrint('Showing notification: $title');
  }
}