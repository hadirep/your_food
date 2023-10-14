import 'package:your_food/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.name,
  });

  final String name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };

  Category toEntity() {
    return Category(name: name);
  }

  @override
  List<Object?> get props => [name];
}