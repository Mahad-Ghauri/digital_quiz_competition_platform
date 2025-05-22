import 'dart:async';
import 'package:flutter/material.dart';
import '../Models/leaderboard_model.dart';
import '../Services/leaderboard_service.dart';

class LeaderboardController {
  final LeaderboardService _service = LeaderboardService();
  
  // Cache mechanism to reduce API calls
  final Map<LeaderboardTimeFilter, List<LeaderboardEntry>> _cache = {};
  final Map<LeaderboardTimeFilter, DateTime> _cacheTimestamp = {};
  
  // Cache validity duration (5 minutes)
  final Duration _cacheDuration = const Duration(minutes: 5);
  
  // Get leaderboard data with caching
  Future<List<LeaderboardEntry>> getLeaderboardData(LeaderboardTimeFilter filter) async {
    // Check if we have valid cached data
    if (_isCacheValid(filter)) {
      return _cache[filter]!;
    }
    
    // If no valid cache, fetch from service
    try {
      final data = await _service.getLeaderboard(filter);
      
      // Update cache
      _cache[filter] = data;
      _cacheTimestamp[filter] = DateTime.now();
      
      return data;
    } catch (error) {
      // If error and we have stale cache, return it with a warning
      if (_cache.containsKey(filter)) {
        debugPrint('Warning: Using stale cache due to error: $error');
        return _cache[filter]!;
      }
      
      // Otherwise, rethrow the error
      rethrow;
    }
  }
  
  // Check if cache is valid
  bool _isCacheValid(LeaderboardTimeFilter filter) {
    if (!_cache.containsKey(filter) || !_cacheTimestamp.containsKey(filter)) {
      return false;
    }
    
    final timestamp = _cacheTimestamp[filter]!;
    final now = DateTime.now();
    
    return now.difference(timestamp) < _cacheDuration;
  }
  
  // Clear cache for a specific filter or all filters
  void clearCache([LeaderboardTimeFilter? filter]) {
    if (filter != null) {
      _cache.remove(filter);
      _cacheTimestamp.remove(filter);
    } else {
      _cache.clear();
      _cacheTimestamp.clear();
    }
  }
  
  // Get user rank from the leaderboard
  int? getUserRank(String userId, List<LeaderboardEntry> entries) {
    for (final entry in entries) {
      if (entry.userId == userId) {
        return entry.rank;
      }
    }
    return null;
  }
  
  // Get top performers (top 3)
  List<LeaderboardEntry> getTopPerformers(List<LeaderboardEntry> entries) {
    if (entries.length <= 3) {
      return entries;
    }
    return entries.sublist(0, 3);
  }
}