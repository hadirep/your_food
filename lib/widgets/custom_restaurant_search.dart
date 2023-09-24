import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/provider/restaurant_search_provider.dart';

class CustomRestaurantSearch extends StatefulWidget {
  const CustomRestaurantSearch({Key? key}) : super(key: key);

  @override
  State<CustomRestaurantSearch> createState() => _CustomRestaurantSearchState();
}

class _CustomRestaurantSearchState extends State<CustomRestaurantSearch> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.search,
                color: primaryColor,
                size: 30,
              ),
              title: TextField(
                controller: _controller,
                onChanged: (String query) {
                  if (query.isNotEmpty) {
                    setState(() {
                      queries = query;
                    });
                    state.fetchSearchRestaurant(query);
                  }
                },
                style: const TextStyle(color: primaryColor),
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                  hintText: 'What are you looking for?',
                  hintStyle: TextStyle(color: primaryColor),
                  fillColor: primaryColor,
                  border: InputBorder.none,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  if (queries.isNotEmpty) {
                    _controller.clear();
                    setState(() {
                      queries = '';
                    });
                  }
                },
                icon: const Icon(
                  Icons.close,
                  color: primaryColor,
                  size: 30,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
