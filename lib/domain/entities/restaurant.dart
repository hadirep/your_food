import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Restaurant extends Equatable {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Restaurant.favorite({
    required this.id,
    required this.name,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    pictureId,
    city,
    rating,
  ];
}
