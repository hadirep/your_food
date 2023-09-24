import 'package:flutter/material.dart';
import 'package:your_food/data/api/api_service.dart';
import 'package:your_food/data/model/restaurant_list_search_model.dart';
import 'package:your_food/utils/result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchListRestaurant();
  }

  late RestaurantListModel _restaurantListModel;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantListModel get listResult => _restaurantListModel;
  ResultState get state => _state;

  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantListModel = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet Connection...';
    }
  }
}
