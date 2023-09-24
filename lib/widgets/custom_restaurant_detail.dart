import 'package:flutter/material.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/data/model/restaurant_detail_model.dart';

class CustomRestaurantDetail extends StatelessWidget {
  final DetailModel detailModel;
  const CustomRestaurantDetail({Key? key, required this.detailModel})
      : super(key: key);

  static dynamic image = 'https://restaurant-api.dicoding.dev/images/large/';

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
                  icon: const Icon(Icons.arrow_back, color: secondaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: image + detailModel.pictureId,
                    child: Image.network(
                      image + detailModel.pictureId,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  title: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      detailModel.name!,
                      style: const TextStyle(color: secondaryColor)
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
                      detailModel.name!,
                      style: myTextTheme.headlineMedium,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: iconColor, size: 17),
                      Text(
                        "${detailModel.city}, Indonesia",
                        style: myTextTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Rating: ${detailModel.rating}",
                        style: myTextTheme.bodyLarge,
                      ),
                      const Icon(Icons.star, color: secondaryColor, size: 15),
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
                    children: detailModel.categories!
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
                                      categories.name!,
                                      style:
                                          const TextStyle(color: primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
                      children: detailModel.menus!.drinks!
                          .map(
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
                                        menus.name!,
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
                      children: detailModel.menus!.foods!
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
                                        menus.name!,
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
                  const Divider(color: dividerColor),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Description: ",
                      style: myTextTheme.titleLarge,
                    ),
                  ),
                  Text(
                    detailModel.description!,
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
                      children: detailModel.customerReviews!
                          .map(
                            (review) => Padding(
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
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          )),
    ));
  }
}
