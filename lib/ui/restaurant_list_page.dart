import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/provider/restaurant_list_provider.dart';
import 'package:your_food/ui/login_page.dart';
import 'package:your_food/ui/restaurant_search_page.dart';
import 'package:your_food/ui/settings_page.dart';
import 'package:your_food/utils/result_state.dart';
import 'package:your_food/widgets/custom_restaurant_list.dart';
import 'package:your_food/widgets/platform_widget.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_list_page';

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final _auth = FirebaseAuth.instance;

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
            color: secondaryColor,
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
                color: secondaryColor,
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
                  color: secondaryColor,
                ),
              ),
              const Divider(color: secondaryColor),
              ListTile(
                title: const Text(
                  "Settings",
                  style: TextStyle(color: secondaryColor, fontSize: 15),
                ),
                trailing: const Icon(Icons.settings, color: secondaryColor),
                onTap: () =>
                    Navigator.pushNamed(context, SettingsPage.routeName),
              ),
              ListTile(
                title: const Text(
                  "Logout",
                  style: TextStyle(color: secondaryColor, fontSize: 15),
                ),
                trailing: const Icon(Icons.logout, color: secondaryColor),
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await _auth.signOut();

                  navigator.pushReplacementNamed(LoginPage.routeName);
                },
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
          color: secondaryColor,
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
