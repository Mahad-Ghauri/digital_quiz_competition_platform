import 'dart:async';
import '../Models/leaderboard_model.dart';

class LeaderboardService {
  // Simulate API call with a delay
  Future<List<LeaderboardEntry>> getLeaderboard(LeaderboardTimeFilter filter) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate random failure (1 in 10 chance)
    if (DateTime.now().millisecond % 10 == 0) {
      throw Exception('Failed to load leaderboard data');
    }
    
    // Return mock data based on filter
    const int entryCount = 20;
    List<LeaderboardEntry> entries = [];
    
    for (int i = 0; i < entryCount; i++) {
      // Different point calculation based on filter
      int points;
      int wins;
      
      switch (filter) {
        case LeaderboardTimeFilter.daily:
          points = 100 - (i * 5);
          wins = (5 - (i * 0.2)).round().clamp(0, 5);
          break;
        case LeaderboardTimeFilter.weekly:
          points = 500 - (i * 20);
          wins = (15 - (i * 0.5)).round().clamp(0, 15);
          break;
        case LeaderboardTimeFilter.monthly:
          points = 2000 - (i * 80);
          wins = (40 - (i * 1.5)).round().clamp(0, 40);
          break;
        case LeaderboardTimeFilter.allTime:
          points = 10000 - (i * 300);
          wins = (100 - (i * 4)).round().clamp(0, 100);
          break;
      }
      
      entries.add(
        LeaderboardEntry(
          userId: 'user_${i + 1}',
          username: 'Player ${i + 1}',
          points: points,
          wins: wins,
          photoUrl: i < 5 ? 'https://ui-avatars.com/api/?name=Player+${i + 1}' : null,
          rank: i + 1,
        ),
      );
    }
    
    return entries;
  }
}