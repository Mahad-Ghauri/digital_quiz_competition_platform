
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final Color color;
  final String level;
  final String title;
  final String iconPath;
  final bool isCompleted;
  final bool isCurrentLevel;
  final bool isLocked;

  const LevelCard({
    super.key,
    required this.color,
    required this.level,
    required this.title,
    required this.iconPath,
    this.isCompleted = false,
    this.isCurrentLevel = false,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Left side content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isCompleted)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 16,
                      ),
                    ),
                  if (isCurrentLevel)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    level,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            // Right side image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  isLocked
                      ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(iconPath, width: 40, height: 40),
                          const Icon(Icons.lock, color: Colors.white, size: 20),
                        ],
                      )
                      : Image.asset(iconPath, width: 40, height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
