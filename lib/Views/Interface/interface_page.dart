import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../components/category_card.dart';
import '../../components/featured_quiz_card.dart';
import '../../components/bottom_nav_bar.dart';
import '../../providers/quiz_provider.dart';
import '../search_page.dart';
import '../leaderboard_page.dart';
import '../settings_page.dart';
import 'question_page.dart';

class InterfacePage extends StatefulWidget {
  const InterfacePage({super.key});

  @override
  State<InterfacePage> createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  int _currentIndex = 0;

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

  @override
  void initState() {
    super.initState();
    // Fetch categories when the page loads
    Future.microtask(() => context.read<QuizProvider>().fetchCategories());
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToQuestionPage(String categoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuestionPage()),
    );
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
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
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
                    itemCount: quizProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category = quizProvider.categories[index];
                      return CategoryCard(
                        categoryName: category.displayName,
                        icon: _getCategoryIcon(category.name),
                        color: cardColors[index % cardColors.length],
                        onTap: () {
                          quizProvider.fetchQuestions(category.id);
                          _navigateToQuestionPage(category.id);
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.9,
                        ),
                    itemCount:
                        quizProvider.categories.length > 6
                            ? 6
                            : quizProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category = quizProvider.categories[index];
                      return FeaturedQuizCard(
                        categoryName: category.displayName,
                        icon: _getCategoryIcon(category.name),
                        color: cardColors[index % cardColors.length],
                        questionCount: "10 Questions",
                        rating: "4.${index + 5}",
                        onPlay: () {
                          quizProvider.fetchQuestions(category.id);
                          _navigateToQuestionPage(category.id);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'artliterature':
        return Icons.book;
      case 'language':
        return Icons.translate;
      case 'sciencenature':
        return Icons.science;
      case 'general':
        return Icons.lightbulb;
      case 'fooddrink':
        return Icons.restaurant;
      case 'peopleplaces':
        return Icons.people;
      case 'geography':
        return Icons.public;
      case 'historyholidays':
        return Icons.history;
      case 'entertainment':
        return Icons.movie;
      case 'toysgames':
        return Icons.sports_esports;
      case 'music':
        return Icons.music_note;
      case 'mathematics':
        return Icons.calculate;
      case 'civics':
        return Icons.account_balance;
      case 'astronomy':
        return Icons.rocket;
      default:
        return Icons.category;
    }
  }
}
