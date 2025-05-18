import 'package:digital_quiz_competition_platform/Models/quiz_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabaseClient;

  SupabaseService(this._supabaseClient);

  // Get all quizzes
  Future<List<Quiz>> getAllQuizzes() async {
    try {
      final response = await _supabaseClient
          .from('quizzes')
          .select()
          .order('created_at', ascending: false);

      return response.map<Quiz>((quiz) => Quiz.fromJson(quiz)).toList();
    } catch (e) {
      throw Exception('Failed to fetch quizzes: $e');
    }
  }

  // Search quizzes by title, description, or category
  Future<List<Quiz>> searchQuizzes(String query) async {
    try {
      final response = await _supabaseClient
          .from('quizzes')
          .select()
          .or('title.ilike.%$query%,description.ilike.%$query%,category.ilike.%$query%')
          .order('created_at', ascending: false);

      return response.map<Quiz>((quiz) => Quiz.fromJson(quiz)).toList();
    } catch (e) {
      throw Exception('Failed to search quizzes: $e');
    }
  }

  // Get quizzes by category
  Future<List<Quiz>> getQuizzesByCategory(String category) async {
    try {
      final response = await _supabaseClient
          .from('quizzes')
          .select()
          .eq('category', category)
          .order('created_at', ascending: false);

      return response.map<Quiz>((quiz) => Quiz.fromJson(quiz)).toList();
    } catch (e) {
      throw Exception('Failed to fetch quizzes by category: $e');
    }
  }

  // Get quiz by ID
  Future<Quiz> getQuizById(String id) async {
    try {
      final response = await _supabaseClient
          .from('quizzes')
          .select()
          .eq('id', id)
          .single();

      return Quiz.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch quiz: $e');
    }
  }
}