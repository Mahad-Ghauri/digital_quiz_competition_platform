// ignore_for_file: deprecated_member_use

import 'package:digital_quiz_competition_platform/Models/level_card.dart';
import 'package:flutter/material.dart';

class InterfacePage extends StatefulWidget {
  const InterfacePage({super.key});

  @override
  State<InterfacePage> createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange.shade300, Colors.orange.shade50],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Let's Play",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          "Be the first!",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView(
                    children: [
                      // Level 1 Card
                      LevelCard(
                        color: Colors.pink.shade300,
                        level: "Level 1",
                        title: "Travel newbie",
                        iconPath: 'assets/images/travel-bag.png',
                        isCompleted: true,
                      ),
                      const SizedBox(height: 16),
                      // Level 2 Card
                      LevelCard(
                        color: Colors.blue.shade400,
                        level: "Level 2",
                        title: "Continuing",
                        iconPath: 'assets/images/airballoon.png',
                        isCompleted: false,
                        isCurrentLevel: true,
                      ),
                      const SizedBox(height: 16),
                      // Level 3 Card
                      LevelCard(
                        color: Colors.purple.shade300,
                        level: "Level 3",
                        title: "Experienced",
                        iconPath: 'assets/images/destination.png',
                        isCompleted: false,
                        isLocked: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
