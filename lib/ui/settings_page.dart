import 'dart:io';

import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/provider/preferences_provider.dart';
import 'package:your_food/provider/scheduling_provider.dart';
import 'package:your_food/widgets/custom_dialog.dart';
import 'package:your_food/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

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
      ),
      backgroundColor: secondaryColor,
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  }),
            ),
          ),
          Material(
            child: ListTile(
              title: const Text('Restaurant Notification'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                      value: provider.isDailyRestaurantActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyRestaurant(value);
                        }
                      });
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
