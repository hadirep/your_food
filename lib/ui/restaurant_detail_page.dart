import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_food/common/styles.dart';
import 'package:your_food/data/api/api_service.dart';
import 'package:your_food/data/model/restaurant_list_search_model.dart';
import 'package:your_food/provider/restaurant_detail_provider.dart';
import 'package:your_food/widgets/custom_restaurant_detail.dart';
import 'package:your_food/utils/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  final ListSearchModel listSearchModel;
  const RestaurantDetailPage({Key? key, required this.listSearchModel})
      : super(key: key);

  static const routeName = '/restaurant_detail_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: ApiService(), id: listSearchModel.id),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(color: secondaryColor),
              );
            } else if (state.state == ResultState.hasData) {
              var restaurant = state.result.restaurant;
              return CustomRestaurantDetail(detailModel: restaurant!);
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
