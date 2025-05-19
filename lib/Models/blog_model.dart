class BlogModel {
  final String id;
  final String title;
  final String author;
  final String date;
  final String content;
  final String imageUrl;
  final List<String> tags;

  BlogModel({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    required this.imageUrl,
    required this.tags,
  });

  // Factory method to create a BlogModel from a JSON map
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      date: json['date'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
      tags: List<String>.from(json['tags'] as List),
    );
  }

  // Method to convert a BlogModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'date': date,
      'content': content,
      'imageUrl': imageUrl,
      'tags': tags,
    };
  }
}