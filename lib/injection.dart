import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_food/data/datasources/db/database_helper.dart';
import 'package:your_food/data/datasources/preferences/preferences_helper.dart';
import 'package:your_food/data/datasources/restaurant_local_data_source.dart';
import 'package:your_food/data/datasources/restaurant_remote_data_source.dart';
import 'package:your_food/data/repositories/restaurant_repository_impl.dart';
import 'package:your_food/domain/repositories/restaurant_repository.dart';
import 'package:your_food/domain/usecases/get_favorite_restaurant.dart';
import 'package:your_food/domain/usecases/get_favorite_status.dart';
import 'package:your_food/domain/usecases/get_restaurant_detail.dart';
import 'package:your_food/domain/usecases/get_restaurant_list.dart';
import 'package:your_food/domain/usecases/remove_favorite.dart';
import 'package:your_food/domain/usecases/save_favorite.dart';
import 'package:your_food/domain/usecases/search_restaurant.dart';
import 'package:your_food/presentation/provider/favorite_restaurant_notifier.dart';
import 'package:your_food/presentation/provider/restaurant_detail_notifier.dart';
import 'package:your_food/presentation/provider/restaurant_list_notifier.dart';
import 'package:your_food/presentation/provider/restaurant_search_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:your_food/presentation/provider/theme_notifier.dart';

final locator = GetIt.instance;

void init() {
  //provider
  locator.registerFactory(
    () => RestaurantListNotifier(
      getRestaurantList: locator(),
    ),
  );

  locator.registerFactory(
    () => RestaurantDetailNotifier(
      getRestaurantDetail: locator(),
      getFavoriteStatus: locator(),
      saveFavorite: locator(),
      removeFavorite: locator(),
    ),
  );

  locator.registerFactory(
    () => RestaurantSearchNotifier(
      searchRestaurant: locator(),
    ),
  );

  locator.registerFactory(
    () => FavoriteRestaurantNotifier(
      getFavoriteRestaurant: locator(),
    ),
  );

  locator.registerFactory(
    () => ThemeNotifier(
      preferencesHelper: PreferencesHelper(
        sharedPreferences: SharedPreferences.getInstance(),
      ),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetRestaurantList(locator()));
  locator.registerLazySingleton(() => GetRestaurantDetail(locator()));
  locator.registerLazySingleton(() => SearchRestaurant(locator()));
  locator.registerLazySingleton(() => GetFavoriteStatus(locator()));
  locator.registerLazySingleton(() => SaveFavorite(locator()));
  locator.registerLazySingleton(() => RemoveFavorite(locator()));
  locator.registerLazySingleton(() => GetFavoriteRestaurant(locator()));

  // repository
  locator.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<RestaurantRemoteDataSource>(
          () => RestaurantRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<RestaurantLocalDataSource>(
          () => RestaurantLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}