import 'dart:convert';

import 'package:your_food/data/models/restaurant_detail_model.dart';
import 'package:your_food/data/models/restaurant_model.dart';
import 'package:your_food/data/models/restaurant_response.dart';
import 'package:your_food/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurantList();
  Future<RestaurantDetailResponse> getRestaurantDetail(String id);
  Future<List<RestaurantModel>> searchRestaurant(String query);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  static const baseUrl = 'https://restaurant-api.dicoding.dev';

  final http.Client client;

  RestaurantRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RestaurantModel>> getRestaurantList() async {
    final response = await client.get(Uri.parse('$baseUrl/list'));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body)).restaurantList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RestaurantModel>> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse('$baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body)).restaurantList;
    } else {
      throw ServerException();
    }
  }
}