import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Models/category_model.dart';
import '../Models/question_model.dart';

class QuizProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<CategoryModel> _categories = [];
  List<QuestionModel> _questions = [];
  String? _selectedCategoryId;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = false;
  String? _error;

  List<CategoryModel> get categories => _categories;
  List<QuestionModel> get questions => _questions;
  String? get selectedCategoryId => _selectedCategoryId;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isLoading => _isLoading;
  String? get error => _error;
  QuestionModel? get currentQuestion =>
      _questions.isNotEmpty && _currentQuestionIndex < _questions.length
          ? _questions[_currentQuestionIndex]
          : null;

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response =
          await _supabase.from('categories').select().order('name');

      _categories = response
          .map((json) => CategoryModel.fromJson(json))
          .toList()
          .cast<CategoryModel>();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Error fetching categories: $e';
      debugPrint(_error);
      notifyListeners();
    }
  }

  Future<void> fetchQuestions(String categoryId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _supabase
          .from('questions')
          .select()
          .eq('category_id', categoryId)
          .order('created_at');

      _questions = response
          .map((json) => QuestionModel.fromJson(json))
          .toList()
          .cast<QuestionModel>();

      _selectedCategoryId = categoryId;
      _currentQuestionIndex = 0;
      _score = 0;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Error fetching questions: $e';
      debugPrint(_error);
      notifyListeners();
    }
  }

  void answerQuestion(String selectedAnswer) {
    if (currentQuestion == null) return;

    if (selectedAnswer == currentQuestion!.correctAnswer) {
      _score += currentQuestion!.points;
      notifyListeners();
    }
  }

  void moveToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _error = null;
    notifyListeners();
  }

  CategoryModel? getCategoryById(String id) {
    try {
      return _categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  CategoryModel? get currentCategory {
    if (_selectedCategoryId == null) return null;
    return getCategoryById(_selectedCategoryId!);
  }
}
