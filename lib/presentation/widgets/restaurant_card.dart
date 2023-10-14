import 'package:cached_network_image/cached_network_image.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/presentation/pages/restaurant_detail_page.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ClipRRect(
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
  }
}
