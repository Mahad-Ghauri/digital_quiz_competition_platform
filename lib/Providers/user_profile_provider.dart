import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProfile {
  String name;
  String username;
  String? profileImagePath;
  int quizzesTaken;
  int totalScore;
  List<String> achievements;
  
  UserProfile({
    required this.name,
    required this.username,
    this.profileImagePath,
    this.quizzesTaken = 0,
    this.totalScore = 0,
    this.achievements = const [],
  });
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'profileImagePath': profileImagePath,
      'quizzesTaken': quizzesTaken,
      'totalScore': totalScore,
      'achievements': achievements,
    };
  }
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? 'User',
      username: json['username'] ?? 'username',
      profileImagePath: json['profileImagePath'],
      quizzesTaken: json['quizzesTaken'] ?? 0,
      totalScore: json['totalScore'] ?? 0,
      achievements: json['achievements'] != null 
          ? List<String>.from(json['achievements']) 
          : [],
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
    int? quizzesTaken,
    int? totalScore,
    List<String>? achievements,
  }) async {
    if (name != null) _userProfile.name = name;
    if (username != null) _userProfile.username = username;
    if (profileImagePath != null) _userProfile.profileImagePath = profileImagePath;
    if (quizzesTaken != null) _userProfile.quizzesTaken = quizzesTaken;
    if (totalScore != null) _userProfile.totalScore = totalScore;
    if (achievements != null) _userProfile.achievements = achievements;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile', json.encode(_userProfile.toJson()));
    
    notifyListeners();
  }
}