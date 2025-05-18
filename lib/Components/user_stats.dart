// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/leaderboard_model.dart';

class UserStats extends StatelessWidget {
  final LeaderboardEntry? userEntry;
  final int totalParticipants;
  final LeaderboardTimeFilter timeFilter;

  const UserStats({
    Key? key,
    required this.userEntry,
    required this.totalParticipants,
    required this.timeFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userEntry == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your ${timeFilter.displayName} Stats",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Rank',
                '#${userEntry!.rank}',
                'Out of $totalParticipants',
                Icons.leaderboard,
              ),
              _buildStatItem(
                'Points',
                '${userEntry!.points}',
                'Total points',
                Icons.star,
              ),
              _buildStatItem(
                'Wins',
                '${userEntry!.wins}',
                'Total wins',
                Icons.emoji_events,
              ),
            ],
          ),
          if (userEntry!.rank > 3) ...[
            const SizedBox(height: 15),
            Center(
              child: Text(
                _getMotivationalMessage(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  String _getMotivationalMessage() {
    if (userEntry!.rank <= 10) {
      return "You're in the top 10! Keep it up!";
    } else if (userEntry!.rank <= totalParticipants / 2) {
      return "You're in the top half! Keep pushing to reach the top!";
    } else {
      return "Keep practicing to climb the ranks!";
    }
  }
}