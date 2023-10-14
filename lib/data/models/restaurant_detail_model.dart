import 'package:your_food/data/models/category_model.dart';
import 'package:your_food/data/models/customer_review_model.dart';
import 'package:your_food/data/models/menus_model.dart';
import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:equatable/equatable.dart';

class RestaurantDetailResponse extends Equatable {
  const RestaurantDetailResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<CategoryModel> categories;
  final MenusModel menus;
  final double rating;
  final List<CustomerReviewModel> customerReviews;

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    final restaurant = json['restaurant'];

    return RestaurantDetailResponse(
      id: restaurant['id'],
      name: restaurant['name'],
      description: restaurant['description'],
      city: restaurant['city'],
      address: restaurant['address'],
      pictureId: restaurant['pictureId'],
      categories: List<CategoryModel>.from(
          restaurant['categories'].map((x) => CategoryModel.fromJson(x))),
      menus: MenusModel.fromJson(restaurant['menus']),
      rating: (restaurant['rating'] as num?)?.toDouble() ?? 0.0,
      customerReviews: List<CustomerReviewModel>.from(
          restaurant['customerReviews'].map((x) => CustomerReviewModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": categories,
    "menus": menus.toJson(),
    "rating": rating,
    "customerReviews": customerReviews,
  };

  RestaurantDetail toEntity() {
    return RestaurantDetail(
      id: id,
      name: name,
      description: description,
      city: city,
      address: address,
      pictureId: pictureId,
      categories: categories.map((categori) => categori.toEntity()).toList(),
      menus: menus,
      rating: rating,
      customerReviews: customerReviews.map((customer) => customer.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    city,
    address,
    pictureId,
    categories,
    menus,
    rating,
    customerReviews,
  ];
}
