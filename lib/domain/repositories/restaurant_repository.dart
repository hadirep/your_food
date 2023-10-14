import 'package:dartz/dartz.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:your_food/common/failure.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurantList();
  Future<Either<Failure, RestaurantDetail>> getRestaurantDetail(String id);
  Future<Either<Failure, List<Restaurant>>> searchRestaurant(String query);
  Future<Either<Failure, String>> saveFavorite(RestaurantDetail restaurant);
  Future<Either<Failure, String>> removeFavorite(RestaurantDetail restaurant);
  Future<bool> isAddedToFavorite(String id);
  Future<Either<Failure, List<Restaurant>>> getFavoriteRestaurant();
}
