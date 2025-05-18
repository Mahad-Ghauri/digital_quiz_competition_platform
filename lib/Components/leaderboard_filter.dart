import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/leaderboard_model.dart';

class LeaderboardFilter extends StatelessWidget {
  final LeaderboardTimeFilter selectedFilter;
  final Function(LeaderboardTimeFilter) onFilterChanged;

  const LeaderboardFilter({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: LeaderboardTimeFilter.values.map((filter) {
          return _buildTimeFilter(
            filter.displayName,
            isSelected: selectedFilter == filter,
            onTap: () => onFilterChanged(filter),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTimeFilter(
    String text, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? Colors.blue 
              : Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}