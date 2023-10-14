import 'package:your_food/common/state_enum.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/domain/usecases/search_restaurant.dart';
import 'package:flutter/foundation.dart';

class RestaurantSearchNotifier extends ChangeNotifier {
  final SearchRestaurant searchRestaurant;

  RestaurantSearchNotifier({required this.searchRestaurant});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Restaurant> _searchResult = [];
  List<Restaurant> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchRestaurantSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchRestaurant.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
