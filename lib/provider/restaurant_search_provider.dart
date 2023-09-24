import 'package:flutter/material.dart';
import 'package:your_food/data/api/api_service.dart';
import 'package:your_food/data/model/restaurant_list_search_model.dart';
import 'package:your_food/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    fetchSearchRestaurant(query);
  }

  RestaurantSearchModel? _restaurantSearchModel;
  ResultState? _state;
  String _message = '';
  String _query = '';

  String get message => _message;
  RestaurantSearchModel? get searchResult => _restaurantSearchModel;
  String get query => _query;
  ResultState? get state => _state;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        _query = query;
        final restaurant = await apiService.getSearch(query);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantSearchModel = restaurant;
        }
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet Connection...';
    }
  }
}
