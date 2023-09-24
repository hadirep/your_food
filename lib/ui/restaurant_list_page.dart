import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/provider/restaurant_list_provider.dart';
import 'package:your_food/ui/restaurant_search_page.dart';
import 'package:your_food/ui/settings_page.dart';
import 'package:your_food/utils/result_state.dart';
import 'package:your_food/widgets/custom_restaurant_list.dart';
import 'package:your_food/widgets/platform_widget.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_list_page';

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
              child: CircularProgressIndicator(color: secondaryColor));
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.listResult.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.listResult.restaurants[index];
              return CustomRestaurantList(listSearchModel: restaurant);
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
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                'assets/icon_your_food.png',
                height: 50,
                width: 50,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/your_food.png',
                  width: 200,
                  height: 50,
                ),
              ),
              const Divider(color: primaryColor),
              ListTile(
                title: const Text(
                  "Settings",
                  style: TextStyle(color: primaryColor, fontSize: 15),
                ),
                trailing: const Icon(Icons.settings, color: primaryColor),
                onTap: () =>
                    Navigator.pushNamed(context, SettingsPage.routeName),
              ),
            ],
          ),
        ),
      ),
      body: _buildList(),
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
        trailing: IconButton(
          icon: const Icon(Icons.settings),
          color: primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, SettingsPage.routeName);
          },
        ),
      ),
      child: _buildList(),
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
