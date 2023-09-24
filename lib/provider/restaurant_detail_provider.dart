import 'package:flutter/material.dart';
import 'package:your_food/data/api/api_service.dart';
import 'package:your_food/data/model/restaurant_detail_model.dart';
import 'package:your_food/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late RestaurantDetailModel _restaurantDetailModel;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetailModel get result => _restaurantDetailModel;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getDetail(id);
      if (restaurantDetail.error!) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailModel = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet Connection';
    }
  }
}
