import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../Providers/quiz_provider.dart';

class OptionsList extends StatefulWidget {
  final QuizProvider quizProvider;
  final VoidCallback onCorrectAnswer;
  final VoidCallback onQuizComplete;

  const OptionsList({
    super.key,
    required this.quizProvider,
    required this.onCorrectAnswer,
    required this.onQuizComplete,
  });

  @override
  State<OptionsList> createState() => _OptionsListState();
}

class _OptionsListState extends State<OptionsList> {
  String? selectedOption;
  bool answerChecked = false;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.quizProvider.currentQuestion!.options
            .asMap()
            .entries
            .map((entry) {
          int index = entry.key;
          String option = entry.value;
          bool isSelected = selectedOption == option;

          // Determine option state for styling
          Color cardColor;
          Color borderColor;
          Color textColor;
          IconData? trailingIcon;

          if (answerChecked) {
            if (option == widget.quizProvider.currentQuestion!.correctAnswer) {
              cardColor = Colors.green.shade50;
              borderColor = Colors.green;
              textColor = Colors.green.shade800;
              trailingIcon = Icons.check_circle;
            } else if (isSelected) {
              cardColor = Colors.red.shade50;
              borderColor = Colors.red;
              textColor = Colors.red.shade800;
              trailingIcon = Icons.cancel;
            } else {
              cardColor = Colors.grey.shade50;
              borderColor = Colors.grey.shade300;
              textColor = Colors.black87;
              trailingIcon = null;
            }
          } else {
            cardColor = isSelected ? Colors.blue.shade50 : Colors.grey.shade50;
            borderColor = isSelected ? Colors.blue : Colors.grey.shade300;
            textColor = isSelected ? Colors.blue.shade800 : Colors.black87;
            trailingIcon = isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: answerChecked ? null : () => _selectOption(option),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Option letter
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: answerChecked
                            ? borderColor.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        String.fromCharCode(65 + index), // A, B, C, D...
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: answerChecked
                              ? borderColor
                              : Colors.blue.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Option text
                    Expanded(
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: textColor,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),

                    // Status icon
                    if (trailingIcon != null)
                      Icon(trailingIcon, color: borderColor, size: 20),
                  ],
                ),
              ),
            ).animate().slideX(
                  begin: index.isEven ? -0.3 : 0.3,
                  end: 0,
                  delay: Duration(milliseconds: 100 * index),
                  duration: 400.ms,
                  curve: Curves.easeOutQuad,
                ),
          );
        }).toList(),

        // Next button
        if (answerChecked)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: _moveToNextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Text(
                widget.quizProvider.currentQuestionIndex >=
                        widget.quizProvider.questions.length - 1
                    ? "Finish Quiz"
                    : "Next Question",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ).animate().scale(delay: 300.ms, duration: 400.ms),
          ),
      ],
    );
  }

  void _selectOption(String option) {
    final correctAnswer = widget.quizProvider.currentQuestion!.correctAnswer;
    final isCorrectAnswer = option == correctAnswer;

    setState(() {
      selectedOption = option;
      answerChecked = true;
      isCorrect = isCorrectAnswer;
    });

    // Only update the score in the provider, don't move to next question
    widget.quizProvider.answerQuestion(option);

    if (isCorrectAnswer) {
      widget.onCorrectAnswer();
    }
  }

  void _moveToNextQuestion() {
    if (widget.quizProvider.currentQuestionIndex >=
        widget.quizProvider.questions.length - 1) {
      // This is the last question, show completion dialog
      widget.onQuizComplete();
    } else {
      // Move to the next question
      widget.quizProvider.moveToNextQuestion();

      // Reset the state for the new question
      setState(() {
        selectedOption = null;
        answerChecked = false;
        isCorrect = false;
      });
    }
  }
}
