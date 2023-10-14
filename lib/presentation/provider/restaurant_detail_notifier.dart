import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:your_food/domain/usecases/get_restaurant_detail.dart';
import 'package:your_food/common/state_enum.dart';
import 'package:your_food/domain/usecases/get_favorite_status.dart';
import 'package:your_food/domain/usecases/remove_favorite.dart';
import 'package:your_food/domain/usecases/save_favorite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestaurantDetailNotifier extends ChangeNotifier {
  static const favoriteAddSuccessMessage = 'Added to Favorite';
  static const favoriteRemoveSuccessMessage = 'Removed from Favorite';

  final GetRestaurantDetail getRestaurantDetail;
  final GetFavoriteStatus getFavoriteStatus;
  final SaveFavorite saveFavorite;
  final RemoveFavorite removeFavorite;

  RestaurantDetailNotifier({
    required this.getRestaurantDetail,
    required this.getFavoriteStatus,
    required this.saveFavorite,
    required this.removeFavorite,
  });

  late RestaurantDetail _restaurant;
  RestaurantDetail get restaurant => _restaurant;

  RequestState _restaurantState = RequestState.empty;
  RequestState get restaurantState => _restaurantState;

  String _message = '';
  String get message => _message;

  bool _isAddedToFavorite = false;
  bool get isAddedToFavorite => _isAddedToFavorite;

  Future<void> fetchRestaurantDetail(String id) async {
    _restaurantState = RequestState.loading;
    notifyListeners();
    final detailResult = await getRestaurantDetail.execute(id);

    detailResult.fold(
      (failure) {
        _restaurantState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (restaurant) {
        _restaurantState = RequestState.loaded;
        _restaurant = restaurant;
        notifyListeners();
      },
    );
  }

  String _favoriteMessage = '';
  String get favoriteMessage => _favoriteMessage;

  Future<void> addFavorite(RestaurantDetail restaurant) async {
    final result = await saveFavorite.execute(restaurant);

    await result.fold(
      (failure) async {
        _favoriteMessage = failure.message;
      },
      (successMessage) async {
        _favoriteMessage = successMessage;
      },
    );

    await loadFavoriteStatus(restaurant.id);
  }

  Future<void> removeFromFavorite(RestaurantDetail restaurant) async {
    final result = await removeFavorite.execute(restaurant);

    await result.fold(
      (failure) async {
        _favoriteMessage = failure.message;
      },
      (successMessage) async {
        _favoriteMessage = successMessage;
      },
    );

    await loadFavoriteStatus(restaurant.id);
  }

  Future<void> loadFavoriteStatus(String id) async {
    final result = await getFavoriteStatus.execute(id);
    _isAddedToFavorite = result;
    notifyListeners();
  }
}
