// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import '../../Providers/quiz_provider.dart';
import '../../Components/result_card.dart';
import '../../Components/options_list.dart';
import '../../Components/quiz_views.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator()
                      .animate()
                      .scale(duration: 700.ms, curve: Curves.easeOut)
                      .then(delay: 300.ms)
                      .fadeIn(duration: 500.ms),
                  const SizedBox(height: 20),
                  Text(
                    'Loading questions...',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                ],
              ),
            );
          }

          if (quizProvider.error != null) {
            return ErrorView(quizProvider: quizProvider);
          }

          if (quizProvider.currentQuestion == null) {
            return const NoQuestionsView();
          }

          // Update progress animation when question changes
          _updateProgressAnimation(quizProvider);
  
          return Stack(
            children: [
              // Background with gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.indigo.shade900,
                      Colors.blue.shade800,
                      Colors.blue.shade500,
                    ],
                  ),
                ),
              ),

              // Particles effect
              CustomPaint(
                painter: ParticlesPainter(),
                child: Container(),
              ),

              // Main content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(quizProvider, context),
                      const SizedBox(height: 20),
                      _buildProgressIndicator(quizProvider),
                      const SizedBox(height: 30),
                      Expanded(
                        child: _buildQuestionCard(quizProvider, context),
                      ),
                    ],
                  ),
                ),
              ),

              // Confetti overlay for correct answers
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi / 2,
                  maxBlastForce: 5,
                  minBlastForce: 1,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 0.1,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.yellow,
                    Colors.purple,
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _updateProgressAnimation(QuizProvider quizProvider) {
    double newProgress =
        (quizProvider.currentQuestionIndex + 1) / quizProvider.questions.length;
    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: newProgress,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.reset();
    _animationController.forward();
  }

  Widget _buildHeader(QuizProvider quizProvider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button with glowing effect
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ).animate().fadeIn(duration: 500.ms),

        // Score display with bounce animation
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade500, Colors.indigo.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 24),
              const SizedBox(width: 8),
              Text(
                "${quizProvider.score}",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .then(delay: 200.ms)
            .scale(duration: 400.ms, curve: Curves.elasticOut),
      ],
    );
  }

  Widget _buildProgressIndicator(QuizProvider quizProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Animated progress bar
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 12,
                child: Stack(
                  children: [
                    // Background
                    Container(color: Colors.white.withOpacity(0.3)),

                    // Progress
                    FractionallySizedBox(
                      widthFactor: _progressAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.lightBlue.shade300,
                              Colors.blue.shade600
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 10),

        // Question counter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.questions.length}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            Text(
              "Time: 00:30",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ).animate().slideX(
            begin: -0.2, end: 0, duration: 500.ms, curve: Curves.easeOut),
      ],
    );
  }

  Widget _buildQuestionCard(QuizProvider quizProvider, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Category: ${quizProvider.currentCategory?.displayName ?? 'Quiz'}",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
              ).animate().slideX(begin: -0.5, end: 0, duration: 400.ms),

              const SizedBox(height: 20),

              // Question text
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Text(
                    quizProvider.currentQuestion!.question,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                ),
              ),

              const SizedBox(height: 20),

              // Options list
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: OptionsList(
                    quizProvider: quizProvider,
                    onCorrectAnswer: () {
                      _confettiController.play();
                    },
                    onQuizComplete: () {
                      _showQuizCompleteDialog(context, quizProvider);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().scale(duration: 400.ms, curve: Curves.easeOut);
  }

  void _showQuizCompleteDialog(
      BuildContext context, QuizProvider quizProvider) {
    // Calculate percentage
    int percentage =
        ((quizProvider.score / quizProvider.questions.length) * 100).round();
    String message;
    Color messageColor;
    IconData resultIcon;

    // Determine message based on score
    if (percentage >= 80) {
      message = "Excellent!";
      messageColor = Colors.green;
      resultIcon = Icons.emoji_events;
    } else if (percentage >= 60) {
      message = "Good job!";
      messageColor = Colors.blue;
      resultIcon = Icons.thumb_up;
    } else {
      message = "Keep practicing!";
      messageColor = Colors.orange;
      resultIcon = Icons.refresh;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white.withOpacity(0.95),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Icon(
                resultIcon,
                size: 80,
                color: messageColor,
              ).animate().scale(duration: 600.ms),
              const SizedBox(height: 20),
              Text(
                "Quiz Complete!",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 10),
              Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: messageColor,
                ),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 30),
              ResultCard(
                title: "Score",
                value: "${quizProvider.score}/${quizProvider.questions.length}",
                color: Colors.blue.shade50,
                textColor: Colors.blue.shade800,
                icon: Icons.check_circle,
              )
                  .animate()
                  .slideY(begin: 0.5, end: 0, delay: 600.ms, duration: 500.ms),
              const SizedBox(height: 15),
              ResultCard(
                title: "Percentage",
                value: "$percentage%",
                color: Colors.green.shade50,
                textColor: Colors.green.shade800,
                icon: Icons.percent,
              )
                  .animate()
                  .slideY(begin: 0.5, end: 0, delay: 750.ms, duration: 500.ms),
              const SizedBox(height: 30),
              _buildActionButtons(context, quizProvider),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );

    // Play confetti for good results
    if (percentage >= 60) {
      _confettiController.play();
    }
  }

  Widget _buildActionButtons(BuildContext context, QuizProvider quizProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
              quizProvider.resetQuiz();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.home, size: 18),
                const SizedBox(width: 8),
                Text(
                  "Home",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              if (quizProvider.selectedCategoryId != null) {
                quizProvider.resetQuiz();
                quizProvider.fetchQuestions(quizProvider.selectedCategoryId!);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.refresh, size: 18),
                const SizedBox(width: 8),
                Text(
                  "Retry",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 900.ms);
  }
}

// Particle background effect
class ParticlesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);

    for (int i = 0; i < 50; i++) {
      final x = Random().nextDouble() * size.width;
      final y = Random().nextDouble() * size.height;
      final radius = Random().nextDouble() * 3 + 1;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
