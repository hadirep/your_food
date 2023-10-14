import 'package:dartz/dartz.dart';
import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:your_food/domain/repositories/restaurant_repository.dart';
import 'package:your_food/common/failure.dart';

class SaveFavorite {
  final RestaurantRepository repository;

  SaveFavorite(this.repository);

  Future<Either<Failure, String>> execute(RestaurantDetail restaurant) {
    return repository.saveFavorite(restaurant);
  }
}