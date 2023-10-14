import 'package:dartz/dartz.dart';
import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:your_food/domain/repositories/restaurant_repository.dart';
import 'package:your_food/common/failure.dart';

class GetRestaurantDetail {
  final RestaurantRepository repository;

  GetRestaurantDetail(this.repository);

  Future<Either<Failure, RestaurantDetail>> execute(String id) {
    return repository.getRestaurantDetail(id);
  }
}