import 'dart:convert';

class CategoryModel {
  String title;
  String id;
  CategoryModel({
    required this.title,
    required this.id,
  });

  CategoryModel copyWith({
    String? title,
    String? id,
  }) {
    return CategoryModel(
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(var source) =>
   CategoryModel.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryModel(title: $title, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CategoryModel &&
      other.title == title &&
      other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ id.hashCode;
}
