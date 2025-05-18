import 'package:digital_quiz_competition_platform/Models/quiz_model.dart';
import 'package:digital_quiz_competition_platform/Services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizSearchController extends ChangeNotifier {
  final SupabaseService _supabaseService;

  List<Quiz> _searchResults = [];
  List<Quiz> get searchResults => _searchResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  QuizSearchController({SupabaseService? supabaseService})
      : _supabaseService =
            supabaseService ?? SupabaseService(Supabase.instance.client);

  // Search quizzes by query
  Future<void> searchQuizzes(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _searchResults = await _supabaseService.searchQuizzes(query);
    } catch (e) {
      _errorMessage = 'Failed to search quizzes: $e';
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get all quizzes
  Future<void> getAllQuizzes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _searchResults = await _supabaseService.getAllQuizzes();
    } catch (e) {
      _errorMessage = 'Failed to fetch quizzes: $e';
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get quizzes by category
  Future<void> getQuizzesByCategory(String category) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _searchResults = await _supabaseService.getQuizzesByCategory(category);
    } catch (e) {
      _errorMessage = 'Failed to fetch quizzes by category: $e';
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear search results
  void clearSearchResults() {
    _searchResults = [];
    _errorMessage = '';
    notifyListeners();
  }
}
