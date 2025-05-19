class LeaderboardEntry {
  final String userId;
  final String username;
  final int points;
  final int wins;
  final String? photoUrl;
  final int rank;
  final int quizzesTaken;
  final int score;

  LeaderboardEntry({
    required this.userId,
    required this.username,
    required this.points,
    required this.wins,
    this.photoUrl,
    required this.rank,
    this.quizzesTaken = 0,
    this.score = 0,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json, int rank) {
    return LeaderboardEntry(
      userId: json['userId'] ?? '',
      username: json['username'] ?? 'Anonymous',
      points: json['points'] ?? 0,
      wins: json['wins'] ?? 0,
      photoUrl: json['photoUrl'],
      rank: rank,
      quizzesTaken: json['quizzesTaken'] ?? 0,
      score: json['score'] ?? json['points'] ?? 0,
    );
  }
}

enum LeaderboardTimeFilter {
  daily,
  weekly,
  monthly,
  allTime,
}

extension LeaderboardTimeFilterExtension on LeaderboardTimeFilter {
  String get displayName {
    switch (this) {
      case LeaderboardTimeFilter.daily:
        return 'Daily';
      case LeaderboardTimeFilter.weekly:
        return 'Weekly';
      case LeaderboardTimeFilter.monthly:
        return 'Monthly';
      case LeaderboardTimeFilter.allTime:
        return 'All Time';
    }
  }
}
