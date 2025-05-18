import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/leaderboard_model.dart';

class TopPerformers extends StatelessWidget {
  final List<LeaderboardEntry> topEntries;
  final String currentUserId;

  const TopPerformers({
    Key? key,
    required this.topEntries,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (topEntries.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
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
            "Top Performers",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildTopThree(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTopThree() {
    List<Widget> widgets = [];
    
    // Make sure we have at least 3 entries or use what we have
    final count = topEntries.length > 3 ? 3 : topEntries.length;
    
    // Reorder to show 1st in the middle, 2nd on the left, 3rd on the right
    List<int> order = count == 3 ? [1, 0, 2] : List.generate(count, (index) => index);
    
    for (int i = 0; i < count; i++) {
      final index = order[i];
      final entry = topEntries[index];
      widgets.add(_buildTopPerformerItem(entry, index));
    }
    
    return widgets;
  }

  Widget _buildTopPerformerItem(LeaderboardEntry entry, int index) {
    // Determine badge color and size based on rank
    Color badgeColor;
    double avatarSize;
    double badgeSize;
    IconData? icon;
    
    switch (entry.rank) {
      case 1:
        badgeColor = Colors.amber;
        avatarSize = 80;
        badgeSize = 30;
        icon = Icons.emoji_events;
        break;
      case 2:
        badgeColor = Colors.grey.shade400;
        avatarSize = 70;
        badgeSize = 25;
        icon = Icons.emoji_events;
        break;
      case 3:
        badgeColor = Colors.brown.shade300;
        avatarSize = 60;
        badgeSize = 22;
        icon = Icons.emoji_events;
        break;
      default:
        badgeColor = Colors.blue.shade300;
        avatarSize = 50;
        badgeSize = 20;
        icon = null;
    }
    
    final isCurrentUser = entry.userId == currentUserId;
    
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: badgeColor,
                  width: 3,
                ),
                color: Colors.grey.shade200,
                image: entry.photoUrl != null
                    ? DecorationImage(
                        image: NetworkImage(entry.photoUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: entry.photoUrl == null
                  ? Center(
                      child: Text(
                        entry.username.isNotEmpty
                            ? entry.username[0].toUpperCase()
                            : '?',
                        style: GoogleFonts.poppins(
                          fontSize: avatarSize * 0.4,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    )
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: badgeSize,
                height: badgeSize,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: icon != null
                      ? Icon(
                          icon,
                          color: Colors.white,
                          size: badgeSize * 0.6,
                        )
                      : Text(
                          "${entry.rank}",
                          style: GoogleFonts.poppins(
                            fontSize: badgeSize * 0.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            if (isCurrentUser)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          entry.username,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isCurrentUser ? Colors.blue.shade700 : Colors.black87,
          ),
        ),
        Text(
          "${entry.points} pts",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}