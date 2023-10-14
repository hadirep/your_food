import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/common/state_enum.dart';
import 'package:your_food/presentation/provider/restaurant_search_notifier.dart';
import 'package:your_food/presentation/widgets/restaurant_card.dart';

class RestaurantSearchPage extends StatelessWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_search_page';

  Widget _buildList(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: MediaQuery.of(context).padding,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onSubmitted: (query) {
                        Provider.of<RestaurantSearchNotifier>(context, listen: false)
                            .fetchRestaurantSearch(query);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search title',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.search,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Search Result',
                      style: myTextTheme.titleLarge,
                    ),
                    Consumer<RestaurantSearchNotifier>(
                      builder: (context, data, child) {
                        if (data.state == RequestState.loading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (data.state == RequestState.loaded) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: data.searchResult.length,
                              itemBuilder: (context, index) {
                                final restaurant = data.searchResult[index];
                                return RestaurantCard(restaurant);
                              },
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Container(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
            ? primaryColor
            : darkPrimaryColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).brightness == Brightness.dark
              ? primaryColor
              : darkPrimaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildList(context),
    );
  }
}
