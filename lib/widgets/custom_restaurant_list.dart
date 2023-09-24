import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/data/model/restaurant_list_search_model.dart';
import 'package:your_food/provider/database_provider.dart';
import 'package:your_food/ui/restaurant_detail_page.dart';

class CustomRestaurantList extends StatelessWidget {
  final ListSearchModel listSearchModel;
  const CustomRestaurantList({Key? key, required this.listSearchModel})
      : super(key: key);

  static dynamic image = 'https://restaurant-api.dicoding.dev/images/medium/';

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorite(listSearchModel.id),
        builder: (context, snapshot) {
          var isFavorite = snapshot.data ?? false;
          return Material(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Hero(
                tag: image + listSearchModel.pictureId,
                child: Image.network(
                  image + listSearchModel.pictureId,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(listSearchModel.name),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: iconColor, size: 17),
                      Text('${listSearchModel.city}, Indonesia'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Rating: ${listSearchModel.rating}'),
                      const Icon(Icons.star, color: secondaryColor, size: 15),
                    ],
                  ),
                ],
              ),
              trailing: isFavorite
                  ? IconButton(
                      icon: const Icon(Icons.favorite, color: secondaryColor),
                      color: secondaryColor,
                      onPressed: () => provider.removeFavorite(listSearchModel.id),
                    )
                  : IconButton(
                      onPressed: () => provider.addFavorite(listSearchModel),
                      icon: const Icon(Icons.favorite_border, color: secondaryColor),
                    ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.routeName,
                  arguments: listSearchModel,
                );
              },
            ),
          );
        },
      );
    });
  }
}
