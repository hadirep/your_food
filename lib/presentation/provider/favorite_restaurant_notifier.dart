import 'package:your_food/common/state_enum.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/domain/usecases/get_favorite_restaurant.dart';
import 'package:flutter/foundation.dart';

class FavoriteRestaurantNotifier extends ChangeNotifier {
  var _favoriteRestaurant = <Restaurant>[];
  List<Restaurant> get favoriteRestaurant => _favoriteRestaurant;

  var _favoriteState = RequestState.empty;
  RequestState get favoriteState => _favoriteState;

  String _message = '';
  String get message => _message;

  FavoriteRestaurantNotifier({required this.getFavoriteRestaurant});

  final GetFavoriteRestaurant getFavoriteRestaurant;

  Future<void> fetchFavoriteRestaurant() async {
    _favoriteState = RequestState.loading;
    notifyListeners();

    final result = await getFavoriteRestaurant.execute();
    result.fold(
      (failure) {
        _favoriteState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (restaurantData) {
        if(restaurantData.isEmpty) {
          _favoriteState = RequestState.empty;
          _message = "You don't have a restaurant favorite";
          notifyListeners();
        } else {
          _favoriteState = RequestState.loaded;
          _favoriteRestaurant = restaurantData;
          notifyListeners();
        }
      },
    );
  }
}
