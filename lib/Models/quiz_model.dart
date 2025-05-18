class Quiz {
  final String id;
  final String title;
  final String description;
  final String category;
  final int questionCount;
  final String createdBy;
  final DateTime createdAt;
  final String? imageUrl;
  final int difficulty; // 1-5 scale
  final int timeLimit; // in minutes

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.questionCount,
    required this.createdBy,
    required this.createdAt,
    this.imageUrl,
    required this.difficulty,
    required this.timeLimit,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      questionCount: json['question_count'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
      imageUrl: json['image_url'],
      difficulty: json['difficulty'],
      timeLimit: json['time_limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'question_count': questionCount,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'image_url': imageUrl,
      'difficulty': difficulty,
      'time_limit': timeLimit,
    };
  }
}