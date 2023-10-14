import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:equatable/equatable.dart';

class RestaurantTable extends Equatable {
  final String id;
  final String? name;
  final String? pictureId;
  final String? city;
  final double? rating;

  const RestaurantTable({
    required this.id,
    required this.name,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantTable.fromEntity(RestaurantDetail restaurant) => RestaurantTable(
    id: restaurant.id,
    name: restaurant.name,
    pictureId: restaurant.pictureId,
    city: restaurant.city,
    rating: restaurant.rating,
  );


  factory RestaurantTable.fromMap(Map<String, dynamic> map) => RestaurantTable(
      id: map['id'],
      name: map['name'],
      pictureId: map['pictureId'],
      city: map['city'],
      rating: map['rating'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'pictureId': pictureId,
    'city': city,
    'rating': rating,
  };

  Restaurant toEntity() => Restaurant.favorite(
    id: id,
    name: name,
    pictureId: pictureId,
    city: city,
    rating: rating,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, pictureId, city, rating];

}