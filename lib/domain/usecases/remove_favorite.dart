import 'package:dartz/dartz.dart';
import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:your_food/domain/repositories/restaurant_repository.dart';
import 'package:your_food/common/failure.dart';

class RemoveFavorite {
  final RestaurantRepository repository;

  RemoveFavorite(this.repository);

  Future<Either<Failure, String>> execute(RestaurantDetail restaurant) {
    return repository.removeFavorite(restaurant);
  }
}