import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:your_food/data/model/restaurant_detail_model.dart';
import 'package:your_food/data/model/restaurant_list_search_model.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';

  Future<RestaurantListModel> getList() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return RestaurantListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list data');
    }
  }

  Future<RestaurantSearchModel> getSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestaurantSearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant search data');
    }
  }

  Future<RestaurantDetailModel> getDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail data');
    }
  }
}
