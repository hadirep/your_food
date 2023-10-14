import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [name];
}