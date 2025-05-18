// ignore_for_file: unused_field

import 'package:digital_quiz_competition_platform/Models/quiz_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabaseClient;
  
  // Mock data for testing
  final List<Quiz> _mockQuizzes = [
    Quiz(
      id: '1',
      title: 'Science Quiz: The Human Body',
      description: 'Test your knowledge about the human body and its systems.',
      category: 'Science',
      questionCount: 15,
      createdBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69',
      difficulty: 3,
      timeLimit: 15,
    ),
    Quiz(
      id: '2',
      title: 'Mathematics: Algebra Basics',
      description: 'Practice your algebra skills with this quiz covering equations, expressions, and more.',
      category: 'Mathematics',
      questionCount: 10,
      createdBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb',
      difficulty: 4,
      timeLimit: 20,
    ),
    Quiz(
      id: '3',
      title: 'World History: Ancient Civilizations',
      description: 'Explore the ancient civilizations of Egypt, Greece, Rome, and more.',
      category: 'History',
      questionCount: 20,
      createdBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      imageUrl: 'https://images.unsplash.com/photo-1603888613934-ee2f7d143dd0',
      difficulty: 3,
      timeLimit: 25,
    ),
    Quiz(
      id: '4',
      title: 'Geography: Countries and Capitals',
      description: 'Test your knowledge of countries and their capitals around the world.',
      category: 'Geography',
      questionCount: 25,
      createdBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      imageUrl: 'https://images.unsplash.com/photo-1526778548025-fa2f459cd5ce',
      difficulty: 2,
      timeLimit: 20,
    ),
    Quiz(
      id: '5',
      title: 'Literature: Classic Novels',
      description: 'How well do you know the classic novels and their authors?',
      category: 'Literature',
      questionCount: 15,
      createdBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
      difficulty: 4,
      timeLimit: 15,
    ),
    Quiz(
      id: '6',
      title: 'Sports: Olympic Games',
      description: 'Test your knowledge about the history and events of the Olympic Games.',
      category: 'Sports',
      questionCount: 12,
      createdBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      imageUrl: 'https://images.unsplash.com/photo-1569517282132-25d22f4573e6',
      difficulty: 2,
      timeLimit: 10,
    ),
    Quiz(
      id: '7',
      title: 'Technology: Computer Basics',
      description: 'How much do you know about computers and their components?',
      category: 'Technology',
      questionCount: 18,
      createdBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
      imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97',
      difficulty: 1,
      timeLimit: 15,
    ),
    Quiz(
      id: '8',
      title: 'General Knowledge: Trivia Mix',
      description: 'A mix of trivia questions from various categories to test your general knowledge.',
      category: 'General Knowledge',
      questionCount: 30,
      createdBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      imageUrl: 'https://images.unsplash.com/photo-1606326608606-aa0b62935f2b',
      difficulty: 3,
      timeLimit: 30,
    ),
  ];

  SupabaseService(this._supabaseClient);

  // Get all quizzes
  Future<List<Quiz>> getAllQuizzes() async {
    // For testing, return mock data
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return _mockQuizzes;
    
    // Actual implementation for Supabase
    /*
    try {
      final response = await _supabaseClient
          .from('quizzes')
          .select()
          .order('created_at', ascending: false);

      return response.map<Quiz>((quiz) => Quiz.fromJson(quiz)).toList();
    } catch (e) {
      throw Exception('Failed to fetch quizzes: $e');
    }
    */
  }

  // Search quizzes by title, description, or category
  Future<List<Quiz>> searchQuizzes(String query) async {
    // For testing, filter mock data
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    final lowercaseQuery = query.toLowerCase();
    return _mockQuizzes.where((quiz) {
      return quiz.title.toLowerCase().contains(lowercaseQuery) ||
          quiz.description.toLowerCase().contains(lowercaseQuery) ||
          quiz.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
    
    // Actual implementation for Supabase
    /*
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
    */
  }

  // Get quizzes by category
  Future<List<Quiz>> getQuizzesByCategory(String category) async {
    // For testing, filter mock data
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    return _mockQuizzes.where((quiz) => quiz.category == category).toList();
    
    // Actual implementation for Supabase
    /*
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
    */
  }

  // Get quiz by ID
  Future<Quiz> getQuizById(String id) async {
    // For testing, find in mock data
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    final quiz = _mockQuizzes.firstWhere(
      (quiz) => quiz.id == id,
      orElse: () => throw Exception('Quiz not found'),
    );
    
    return quiz;
    
    // Actual implementation for Supabase
    /*
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
    */
  }
}