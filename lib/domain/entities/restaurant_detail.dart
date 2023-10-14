import 'package:equatable/equatable.dart';
import 'package:your_food/data/models/menus_model.dart';
import 'package:your_food/domain/entities/category.dart';
import 'package:your_food/domain/entities/customer_review.dart';

// ignore: must_be_immutable
class RestaurantDetail extends Equatable {
  RestaurantDetail({
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

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  MenusModel menus;
  double rating;
  List<CustomerReview> customerReviews;

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
