import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/utils.dart';
import 'package:your_food/presentation/pages/favorite_page.dart';
import 'package:your_food/presentation/pages/login_page.dart';
import 'package:your_food/presentation/pages/register_page.dart';
import 'package:your_food/presentation/pages/reset_password_page.dart';
import 'package:your_food/presentation/pages/restaurant_list_page.dart';
import 'package:your_food/presentation/pages/restaurant_search_page.dart';
import 'package:your_food/presentation/provider/favorite_restaurant_notifier.dart';
import 'package:your_food/presentation/provider/restaurant_detail_notifier.dart';
import 'package:your_food/presentation/provider/restaurant_list_notifier.dart';
import 'package:your_food/presentation/provider/restaurant_search_notifier.dart';
import 'package:your_food/presentation/pages/restaurant_detail_page.dart';
import 'package:your_food/injection.dart' as di;
import 'package:your_food/presentation/provider/theme_notifier.dart';

import 'firebase_options.dart';

Future<void> main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<FavoriteRestaurantNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ThemeNotifier>(),
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, provider, child) {
          return MaterialApp(
            theme: provider.themeData,
            debugShowCheckedModeBanner: false,
            home: const LoginPage(),
            navigatorObservers: [routeObserver],
            onGenerateRoute: (RouteSettings settings) {
              switch(settings.name) {
                case '/login_page':
                  return MaterialPageRoute(builder: (_) => const LoginPage());
                case RegisterPage.routeName:
                  return CupertinoPageRoute(builder: (_) => const RegisterPage());
                case ResetPasswordPage.routeName:
                  return CupertinoPageRoute(builder: (_) => const ResetPasswordPage());
                case RestaurantListPage.routeName:
                  return CupertinoPageRoute(builder: (_) => const RestaurantListPage());
                case RestaurantDetailPage.routeName:
                  final id = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (_) => RestaurantDetailPage(id: id),
                    settings: settings,
                  );
                case RestaurantSearchPage.routeName:
                  return CupertinoPageRoute(builder: (_) => const RestaurantSearchPage());
                case FavoritePage.routeName:
                  return CupertinoPageRoute(builder: (_) => const FavoritePage());
                default:
                  return MaterialPageRoute(builder: (_) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Page not found :('),
                      ),
                    );
                  });
              }
            },
          );
        },
      ),
    );
  }
}
