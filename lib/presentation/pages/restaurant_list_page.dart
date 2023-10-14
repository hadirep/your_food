import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/common/state_enum.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/presentation/pages/restaurant_detail_page.dart';
import 'package:your_food/presentation/pages/favorite_page.dart';
import 'package:your_food/presentation/provider/restaurant_list_notifier.dart';
import 'package:your_food/presentation/pages/restaurant_search_page.dart';
import 'package:your_food/presentation/provider/theme_notifier.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list_page';

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RestaurantListNotifier>(context, listen: false)
          .fetchRestaurantList();
    });
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Consumer<RestaurantListNotifier>(builder: (context, data, child) {
        final state = data.restaurantListState;
        if (state == RequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state == RequestState.loaded) {
          return RestaurantList(data.restaurantList);
        } else {
          return Center(child: Text(data.message));
        }
      },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/your_food.png',
                  width: 200,
                  height: 50,
                  color: secondaryColor,
                ),
              ),
              const Divider(color: secondaryColor),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(
                  "Favorite List",
                  style: myTextTheme.titleLarge,
                ),
                onTap: () {
                  Navigator.pushNamed(context, FavoritePage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/your_food.png',
            width: 200,
            height: 50,
            color: secondaryColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Theme.of(context).brightness == Brightness.dark
                ? primaryColor // Warna ikon pada dark theme
                : darkPrimaryColor, // Warna ikon pada light theme
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
          ),
          Consumer<ThemeNotifier>(
            builder: (context, provider, child) {
              return GestureDetector(
                onTap: () {
                  provider.enableDarkTheme(!provider.isDarkTheme);
                },
                child: Image.asset(
                  provider.isDarkTheme ? 'assets/sun.png' : 'assets/moon.png',
                  width: 25,
                  height: 25,
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
        leading: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                'assets/icon_your_food.png',
                height: 50,
                width: 50,
                color: secondaryColor,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
      body: _buildList(),
    );
  }
}

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  const RestaurantList(this.restaurants, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading:  ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: CachedNetworkImage(
              imageUrl: '$imageMedium${restaurant.pictureId}',
              width: 80,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: Text(restaurant.name!),
          subtitle: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: iconColor, size: 17),
                  Text('${restaurant.city}, Indonesia'),
                ],
              ),
              Row(
                children: [
                  Text('Rating: ${restaurant.rating}'),
                  const Icon(Icons.star, color: secondaryColor, size: 15),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              RestaurantDetailPage.routeName,
              arguments: restaurant.id,
            );
          },
        );
      },
    );
  }
}
