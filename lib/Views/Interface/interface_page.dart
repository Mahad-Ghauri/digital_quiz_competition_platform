import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/category_card.dart';
import '../../Components/featured_quiz_card.dart';
import '../../Components/bottom_nav_bar.dart';
import '../search_page.dart';
import '../leaderboard_page.dart';
import '../settings_page.dart';

class InterfacePage extends StatefulWidget {
  const InterfacePage({super.key});

  @override
  State<InterfacePage> createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  int _currentIndex = 0;

  // List of categories for the quiz
  final List<String> categories = [
    'Art & Literature',
    'Language',
    'Science & Nature',
    'General',
    'Food & Drink',
    'People & Places',
    'Geography',
    'History & Holidays',
    'Entertainment',
    'Toys & Games',
    'Music',
    'Mathematics',
  ];

  // Category icons
  final Map<String, IconData> categoryIcons = {
    'Art & Literature': Icons.book,
    'Language': Icons.translate,
    'Science & Nature': Icons.science,
    'General': Icons.lightbulb,
    'Food & Drink': Icons.restaurant,
    'People & Places': Icons.people,
    'Geography': Icons.public,
    'History & Holidays': Icons.history,
    'Entertainment': Icons.movie,
    'Toys & Games': Icons.sports_esports,
    'Music': Icons.music_note,
    'Mathematics': Icons.calculate,
  };

  // Colors for the category cards
  final List<Color> cardColors = [
    Colors.red.shade300,
    Colors.blue.shade300,
    Colors.green.shade300,
    Colors.amber.shade300,
    Colors.purple.shade300,
    Colors.teal.shade300,
    Colors.pink.shade300,
    Colors.orange.shade300,
    Colors.indigo.shade300,
    Colors.lime.shade300,
    Colors.cyan.shade300,
    Colors.brown.shade300,
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomePage(),
          const SearchPage(),
          const LeaderboardPage(),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  Widget _buildHomePage() {
    return Container(
      child: Stack(
        children: [
          // Background image
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // App title and header
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quiz Master",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),

          // Category title
          Positioned(
            top: 120,
            left: 20,
            child: Text(
              "Select Category",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          // Categories horizontal scroll
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            height: 70,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    categoryName: categories[index],
                    icon: categoryIcons[categories[index]]!,
                    color: cardColors[index],
                    onTap: () {
                      // Handle category selection
                    },
                  );
                },
              ),
            ),
          ),

          // Featured quizzes
          Positioned(
            top: 250,
            left: 20,
            child: Text(
              "Featured Quizzes",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          // Featured quiz cards
          Positioned(
            top: 290,
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final randomCategory = categories[index % categories.length];
                  final iconData = categoryIcons[randomCategory]!;
                  final cardColor = cardColors[index % cardColors.length];

                  return FeaturedQuizCard(
                    categoryName: randomCategory,
                    icon: iconData,
                    color: cardColor,
                    questionCount: "10 Questions",
                    rating: "4.${index + 5}",
                    onPlay: () {
                      // Handle quiz start
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
