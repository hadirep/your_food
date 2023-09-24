import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/provider/restaurant_search_provider.dart';
import 'package:your_food/utils/result_state.dart';
import 'package:your_food/widgets/custom_restaurant_list.dart';
import 'package:your_food/widgets/custom_restaurant_search.dart';
import 'package:your_food/widgets/platform_widget.dart';

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
                      const CustomRestaurantSearch(),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Consumer<RestaurantSearchProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultState.loading) {
                              return const CircularProgressIndicator(
                                  color: secondaryColor);
                            } else if (state.state == ResultState.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    state.searchResult!.restaurants.length,
                                itemBuilder: (context, index) {
                                  var restaurant =
                                      state.searchResult!.restaurants[index];
                                  return CustomRestaurantList(
                                      listSearchModel: restaurant);
                                },
                              );
                            } else if (state.state == ResultState.noData) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            } else if (state.state == ResultState.error) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            } else {
                              return const Center(
                                child: Material(
                                  child: Text(''),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/your_food.png',
            width: 200,
            height: 50,
            color: secondaryColor,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: secondaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Center(
          child: Image.asset(
            'assets/your_food.png',
            width: 200,
            height: 50,
          ),
        ),
        transitionBetweenRoutes: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
