import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/state_enum.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/common/utils.dart';
import 'package:your_food/presentation/provider/favorite_restaurant_notifier.dart';
import 'package:your_food/presentation/widgets/restaurant_card.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/restaurant_favorite_page';

  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with RouteAware {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<FavoriteRestaurantNotifier>(context, listen: false)
            .fetchFavoriteRestaurant()
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<FavoriteRestaurantNotifier>(context, listen: false)
        .fetchFavoriteRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite List",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? primaryColor
                : darkPrimaryColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? primaryColor
                : darkPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<FavoriteRestaurantNotifier>(
          builder: (context, data, child) {
            if (data.favoriteState == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (data.favoriteState == RequestState.loaded) {
              return ListView.builder(
                itemCount: data.favoriteRestaurant.length,
                itemBuilder: (context, index) {
                  final favorite = data.favoriteRestaurant[index];
                  return RestaurantCard(favorite);
                },
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
