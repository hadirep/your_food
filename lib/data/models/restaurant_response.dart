import 'package:equatable/equatable.dart';
import 'package:your_food/data/models/restaurant_model.dart';

class RestaurantResponse extends Equatable {
  final List<RestaurantModel> restaurantList;
  
  const RestaurantResponse({required this.restaurantList});
  
  factory RestaurantResponse.fromJson(Map<String, dynamic> json) => RestaurantResponse(
      restaurantList: List<RestaurantModel>.from((json["restaurants"] as List)
          .map((x) => RestaurantModel.fromJson(x))
          // ignore: unnecessary_null_comparison
          .where((element) => element.pictureId != null)),
  );

  Map<String, dynamic> toJson() => {
    "restaurants": List<dynamic>.from(restaurantList.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [restaurantList];
}