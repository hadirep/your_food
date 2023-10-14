import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/common/state_enum.dart';
import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:your_food/presentation/provider/restaurant_detail_notifier.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail_page';

  final String id;
  const RestaurantDetailPage({super.key, required this.id});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RestaurantDetailNotifier>(context, listen: false)
          .fetchRestaurantDetail(widget.id);
      Provider.of<RestaurantDetailNotifier>(context, listen: false)
          .loadFavoriteStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.restaurantState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.restaurantState == RequestState.loaded) {
            final restaurant = provider.restaurant;
            return DetailContent(restaurant, provider.isAddedToFavorite);
          } else {
            return Center(child: Text(provider.message));
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final RestaurantDetail restaurant;
  final bool isAddedFavorite;

  const DetailContent(this.restaurant, this.isAddedFavorite, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
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
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: '$imageLarge${restaurant.pictureId}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  title: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      restaurant.name,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? primaryColor
                            : darkPrimaryColor,
                      ),
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      restaurant.name,
                      style: myTextTheme.headlineMedium,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: iconColor, size: 17,
                      ),
                      Text(
                        "${restaurant.city}, Indonesia",
                        style: myTextTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Rating: ${restaurant.rating}",
                            style: myTextTheme.bodyLarge,
                          ),
                          const Icon(Icons.star, color: secondaryColor, size: 15),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (!isAddedFavorite) {
                            await Provider.of<RestaurantDetailNotifier>(
                                context,
                                listen: false)
                                .addFavorite(restaurant);
                          } else {
                            await Provider.of<RestaurantDetailNotifier>(
                                context,
                                listen: false)
                                .removeFromFavorite(restaurant);
                          }
                          final message =
                          await Future.delayed(const Duration(seconds: 1));
                          if (context.mounted) {
                            Provider.of<RestaurantDetailNotifier>(context,
                                  listen: false)
                                  .favoriteMessage;
                          }

                          if (message == RestaurantDetailNotifier.favoriteAddSuccessMessage ||
                              message == RestaurantDetailNotifier.favoriteRemoveSuccessMessage) {
                            await Future.delayed(const Duration(seconds: 1));
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)));
                            }
                          } else {
                            await Future.delayed(const Duration(seconds: 1));
                            if (context.mounted) {
                              showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(message),
                                );
                              },
                            );
                            }
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            isAddedFavorite
                                ? const Icon(Icons.favorite, color: primaryColor)
                                : const Icon(Icons.favorite_border, color: primaryColor),
                            const SizedBox(width: 5),
                            const Text('Favorite', style: TextStyle(color: primaryColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: dividerColor),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Categories: ",
                      style: myTextTheme.titleLarge,
                    ),
                  ),
                  Row(
                    children: restaurant.categories
                        .map(
                          (categories) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                const Icon(Icons.home, color: primaryColor),
                                const SizedBox(width: 5),
                                Text(
                                  categories.name,
                                  style: const TextStyle(color: primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                  const Divider(color: dividerColor),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Menus: ",
                      style: myTextTheme.titleLarge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Drinks: ",
                      style: myTextTheme.bodyMedium,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: restaurant.menus.drinks.map(
                            (menus) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  const Icon(Icons.fastfood_outlined,
                                      color: primaryColor),
                                  const SizedBox(width: 5),
                                  Text(
                                    menus.name,
                                    style: const TextStyle(
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Foods: ",
                      style: myTextTheme.bodyMedium,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: restaurant.menus.foods
                          .map(
                            (menus) => Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  const Icon(Icons.fastfood_outlined,
                                      color: primaryColor),
                                  const SizedBox(width: 5),
                                  Text(
                                    menus.name,
                                    style: const TextStyle(
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                  const Divider(color: dividerColor),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Description: ",
                      style: myTextTheme.titleLarge,
                    ),
                  ),
                  Text(
                    restaurant.description,
                    maxLines: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(color: dividerColor),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Customer Reviews: ",
                      style: myTextTheme.titleLarge,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: restaurant.customerReviews
                          .map((review) => Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${review.name} \n${review.review} \n${review.date}',
                              style: const TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
