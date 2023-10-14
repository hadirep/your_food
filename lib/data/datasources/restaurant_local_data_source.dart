import 'package:your_food/common/exception.dart';
import 'package:your_food/data/datasources/db/database_helper.dart';
import 'package:your_food/data/models/restaurant_table.dart';

abstract class RestaurantLocalDataSource {
  Future<String> insertFavorite(RestaurantTable restaurant);
  Future<String> removeFavorite(RestaurantTable restaurant);
  Future<RestaurantTable?> getRestaurantById(String id);
  Future<List<RestaurantTable>> getFavoriteRestaurant();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  final DatabaseHelper databaseHelper;

  RestaurantLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertFavorite(RestaurantTable restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      return 'Added to Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(RestaurantTable restaurant) async {
    try {
      await databaseHelper.removeFavorite(restaurant);
      return 'Removed from Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<RestaurantTable?> getRestaurantById(String id) async {
    final result = await databaseHelper.getRestaurantById(id);
    if (result != null) {
      return RestaurantTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<RestaurantTable>> getFavoriteRestaurant() async {
    final result = await databaseHelper.getFavoriteRestaurant();
    return result.map((data) => RestaurantTable.fromMap(data)).toList();
  }
}