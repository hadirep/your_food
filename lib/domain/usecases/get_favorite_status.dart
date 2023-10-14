import 'package:your_food/domain/repositories/restaurant_repository.dart';

class GetFavoriteStatus {
  final RestaurantRepository repository;

  GetFavoriteStatus(this.repository);

  Future<bool> execute(String id) async {
    return repository.isAddedToFavorite(id);
  }
}