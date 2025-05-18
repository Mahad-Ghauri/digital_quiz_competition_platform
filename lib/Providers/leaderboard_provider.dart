import 'package:flutter/material.dart';
import '../Controllers/leaderboard_controller.dart';
import '../Models/leaderboard_model.dart';

class LeaderboardProvider extends ChangeNotifier {
  final LeaderboardController _controller = LeaderboardController();
  
  List<LeaderboardEntry> _entries = [];
  List<LeaderboardEntry> _topPerformers = [];
  LeaderboardTimeFilter _currentFilter = LeaderboardTimeFilter.weekly;
  bool _isLoading = false;
  String? _error;
  int? _currentUserRank;
  
  // Getters
  List<LeaderboardEntry> get entries => _entries;
  List<LeaderboardEntry> get topPerformers => _topPerformers;
  LeaderboardTimeFilter get currentFilter => _currentFilter;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _entries.isNotEmpty;
  int? get currentUserRank => _currentUserRank;
  
  // Initialize the provider
  Future<void> initialize() async {
    await fetchLeaderboard();
  }
  
  // Change the time filter
  Future<void> changeFilter(LeaderboardTimeFilter filter) async {
    if (_currentFilter != filter) {
      _currentFilter = filter;
      notifyListeners();
      await fetchLeaderboard();
    }
  }
  
  // Fetch leaderboard data
  Future<void> fetchLeaderboard() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _entries = await _controller.getLeaderboardData(_currentFilter);
      _topPerformers = _controller.getTopPerformers(_entries);
      
      // Get current user rank (mock user ID for demo)
      _currentUserRank = _controller.getUserRank('user_3', _entries);
      
      _error = null;
    } catch (e) {
      _error = 'Failed to load leaderboard data: ${e.toString()}';
      _entries = [];
      _topPerformers = [];
      _currentUserRank = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Refresh the leaderboard
  Future<void> refreshLeaderboard() async {
    // Clear cache to get fresh data
    _controller.clearCache(_currentFilter);
    await fetchLeaderboard();
  }
  
  // Clear all cache
  void clearAllCache() {
    _controller.clearCache();
  }
  
  // Get user's position in the leaderboard
  LeaderboardEntry? getCurrentUserEntry() {
    if (_currentUserRank == null) return null;
    
    for (final entry in _entries) {
      if (entry.rank == _currentUserRank) {
        return entry;
      }
    }
    return null;
  }
  
  @override
  void dispose() {
    // Clear cache when provider is disposed
    _controller.clearCache();
    super.dispose();
  }
}