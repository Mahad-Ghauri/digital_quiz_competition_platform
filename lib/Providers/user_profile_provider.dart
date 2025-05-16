import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProfile {
  String name;
  String username;
  String? profileImagePath;
  
  UserProfile({
    required this.name,
    required this.username,
    this.profileImagePath,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'profileImagePath': profileImagePath,
    };
  }
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? 'User',
      username: json['username'] ?? 'username',
      profileImagePath: json['profileImagePath'],
    );
  }
}

class UserProfileProvider with ChangeNotifier {
  UserProfile _userProfile = UserProfile(
    name: 'John Doe',
    username: 'johndoe123',
  );
  
  UserProfile get userProfile => _userProfile;
  
  UserProfileProvider() {
    _loadUserProfile();
  }
  
  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userProfileJson = prefs.getString('user_profile');
    
    if (userProfileJson != null) {
      try {
        final Map<String, dynamic> userProfileMap = json.decode(userProfileJson);
        _userProfile = UserProfile.fromJson(userProfileMap);
        notifyListeners();
      } catch (e) {
        debugPrint('Error loading user profile: $e');
      }
    }
  }
  
  Future<void> updateUserProfile({
    String? name,
    String? username,
    String? profileImagePath,
  }) async {
    if (name != null) _userProfile.name = name;
    if (username != null) _userProfile.username = username;
    if (profileImagePath != null) _userProfile.profileImagePath = profileImagePath;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile', json.encode(_userProfile.toJson()));
    
    notifyListeners();
  }
}