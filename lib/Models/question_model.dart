class QuestionModel {
  final String id;
  final String categoryId;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final int points;

  QuestionModel({
    required this.id,
    required this.categoryId,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.points,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      categoryId: json['category_id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correct_answer'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
      'points': points,
    };
  }
}
