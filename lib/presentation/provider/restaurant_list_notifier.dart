import 'package:your_food/common/state_enum.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:your_food/domain/usecases/get_restaurant_list.dart';

class RestaurantListNotifier extends ChangeNotifier {
  var _restaurantList = <Restaurant>[];
  List<Restaurant> get restaurantList => _restaurantList;

  RequestState _restaurantListState = RequestState.empty;
  RequestState get restaurantListState => _restaurantListState;

  String _message = '';
  String get message => _message;

  RestaurantListNotifier({
    required this.getRestaurantList,
  });

  final GetRestaurantList getRestaurantList;

  Future<void> fetchRestaurantList() async {
    _restaurantListState = RequestState.loading;
    notifyListeners();
    final result = await getRestaurantList.execute();
    result.fold(
      (failure) {
        _restaurantListState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (restaurantData) {
        _restaurantListState = RequestState.loaded;
        _restaurantList = restaurantData;
        notifyListeners();
      },
    );
  }
}