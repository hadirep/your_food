import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/navigation.dart';
import 'package:your_food/data/db/database_helper.dart';
import 'package:your_food/data/model/restaurant_list_search_model.dart';
import 'package:your_food/data/preferences/preferences_helper.dart';
import 'package:your_food/provider/database_provider.dart';
import 'package:your_food/provider/preferences_provider.dart';
import 'package:your_food/provider/restaurant_detail_provider.dart';
import 'package:your_food/provider/restaurant_list_provider.dart';
import 'package:your_food/provider/restaurant_search_provider.dart';
import 'package:your_food/provider/scheduling_provider.dart';
import 'package:your_food/ui/home_page.dart';
import 'package:your_food/ui/restaurant_detail_page.dart';
import 'package:your_food/ui/restaurant_search_page.dart';
import 'package:your_food/ui/settings_page.dart';
import 'package:your_food/data/api/api_service.dart';
import 'package:your_food/utils/background_service.dart';
import 'package:your_food/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantListProvider>(
            create: (_) => RestaurantListProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider<RestaurantSearchProvider>(
            create: (_) => RestaurantSearchProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider<RestaurantDetailProvider>(
            create: (_) =>
                RestaurantDetailProvider(apiService: ApiService(), id: ''),
          ),
          ChangeNotifierProvider<DatabaseProvider>(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ],
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              theme: provider.themeData,
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              initialRoute: HomePage.routeName,
              routes: {
                HomePage.routeName: (context) => const HomePage(),
                RestaurantDetailPage.routeName: (context) =>
                    RestaurantDetailPage(
                      listSearchModel: ModalRoute.of(context)
                          ?.settings
                          .arguments as ListSearchModel,
                    ),
                RestaurantSearchPage.routeName: (context) =>
                    const RestaurantSearchPage(),
                SettingsPage.routeName: (context) => const SettingsPage(),
              },
            );
          },
        ));
  }
}
