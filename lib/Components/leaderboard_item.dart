import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/leaderboard_model.dart';

class LeaderboardItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const LeaderboardItem({
    Key? key,
    required this.entry,
    this.isCurrentUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isCurrentUser 
            ? Colors.blue.withOpacity(0.1) 
            : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        border: isCurrentUser 
            ? Border.all(color: Colors.blue, width: 2) 
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildRankBadge(),
          const SizedBox(width: 15),
          _buildUserAvatar(),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.username,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${entry.points} points",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          _buildWinsBadge(),
        ],
      ),
    );
  }

  Widget _buildRankBadge() {
    Color backgroundColor;
    Color textColor;
    
    // Special styling for top 3
    switch (entry.rank) {
      case 1:
        backgroundColor = Colors.amber.withOpacity(0.2);
        textColor = Colors.amber.shade800;
        break;
      case 2:
        backgroundColor = Colors.blueGrey.withOpacity(0.2);
        textColor = Colors.blueGrey.shade700;
        break;
      case 3:
        backgroundColor = Colors.brown.withOpacity(0.2);
        textColor = Colors.brown.shade700;
        break;
      default:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
    }
    
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          "${entry.rank}",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.withOpacity(0.2),
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildWinsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "${entry.wins} wins",
        style: GoogleFonts.poppins(
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}