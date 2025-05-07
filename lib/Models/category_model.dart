class CategoryModel {
  final String id;
  final String name;
  final String displayName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.displayName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      displayName: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'display_name': displayName};
  }
}
