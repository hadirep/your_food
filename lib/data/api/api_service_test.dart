import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:your_food/data/model/restaurant_detail_model.dart';
import 'package:your_food/data/model/restaurant_list_search_model.dart';

class ApiServiceTest {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String list = 'list';
  static const String detail = 'detail/';
  static const String search = 'search?q=';

  final http.Client client;
  ApiServiceTest(this.client);

  Future<RestaurantListModel> getList() async {
    final response = await client.get(Uri.parse(baseUrl + list));
    if (response.statusCode == 200) {
      return RestaurantListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load List Page');
    }
  }

  Future<RestaurantSearchModel> getSearch(String query) async {
    final response = await client.get(Uri.parse(baseUrl + search + query));
    if (response.statusCode == 200) {
      return RestaurantSearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant search data');
    }
  }

  Future<RestaurantDetailModel> getDetail(String id) async {
    final response = await client.get(Uri.parse(baseUrl + detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail data');
    }
  }
}
