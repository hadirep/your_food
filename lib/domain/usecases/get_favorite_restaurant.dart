import 'package:dartz/dartz.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/domain/repositories/restaurant_repository.dart';
import 'package:your_food/common/failure.dart';

class GetFavoriteRestaurant {
  final RestaurantRepository _repository;

  GetFavoriteRestaurant(this._repository);

  Future<Either<Failure, List<Restaurant>>> execute() {
    return _repository.getFavoriteRestaurant();
  }
}