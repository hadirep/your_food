import 'package:dartz/dartz.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/domain/repositories/restaurant_repository.dart';
import 'package:your_food/common/failure.dart';

class SearchRestaurant {
  final RestaurantRepository repository;

  SearchRestaurant(this.repository);

  Future<Either<Failure, List<Restaurant>>> execute(String query) {
    return repository.searchRestaurant(query);
  }
}