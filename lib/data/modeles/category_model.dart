import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['_id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
    };
  }
}
