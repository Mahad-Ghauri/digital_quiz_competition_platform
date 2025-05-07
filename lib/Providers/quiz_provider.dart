import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';

class QuizProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<CategoryModel> _categories = [];
  List<QuestionModel> _questions = [];
  String? _selectedCategoryId;
  int _currentQuestionIndex = 0;
  int _score = 0;

  List<CategoryModel> get categories => _categories;
  List<QuestionModel> get questions => _questions;
  String? get selectedCategoryId => _selectedCategoryId;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  QuestionModel? get currentQuestion =>
      _questions.isNotEmpty && _currentQuestionIndex < _questions.length
          ? _questions[_currentQuestionIndex]
          : null;

  Future<void> fetchCategories() async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .order('name');

      _categories =
          response
              .map((json) => CategoryModel.fromJson(json))
              .toList()
              .cast<CategoryModel>();

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }

  Future<void> fetchQuestions(String categoryId) async {
    try {
      final response = await _supabase
          .from('questions')
          .select()
          .eq('category_id', categoryId)
          .order('id');

      _questions =
          response
              .map((json) => QuestionModel.fromJson(json))
              .toList()
              .cast<QuestionModel>();

      _selectedCategoryId = categoryId;
      _currentQuestionIndex = 0;
      _score = 0;

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching questions: $e');
    }
  }

  void answerQuestion(String selectedAnswer) {
    if (currentQuestion == null) return;

    if (selectedAnswer == currentQuestion!.correctAnswer) {
      _score += currentQuestion!.points;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    }

    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    notifyListeners();
  }
}
