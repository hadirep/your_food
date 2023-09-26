import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:your_food/data/api/api_service_test.dart';
import 'package:your_food/data/model/restaurant_detail_model.dart';
import 'package:your_food/data/model/restaurant_list_search_model.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchRestaurantList', () {
    test('returns a RestaurantListModel is successfully', () async {
      final client = MockClient();

      when(client.get(Uri.parse(ApiServiceTest.baseUrl+ApiServiceTest.list)))
      .thenAnswer((_) async =>
          http.Response('{"error":false, "message":"success", "count":20, "restaurants":[]}', 200)
      );

      expect(await ApiServiceTest(client).getList(), isA<RestaurantListModel>());
    });

    test('returns a RestaurantSearchModel is successfully', () async {
      final client = MockClient();
      const query = 'Melting Pot';

      when(client.get(Uri.parse(ApiServiceTest.baseUrl+ApiServiceTest.search + query)))
          .thenAnswer((_) async =>
          http.Response('{"error":false, "founded":1, "restaurants":[]}', 200)
      );

      expect(await ApiServiceTest(client).getSearch(query), isA<RestaurantSearchModel>());
    });

    test('returns a RestaurantDetailModel is successfully', () async {
      final client = MockClient();
      const id = 'rqdv5juczeskfw1e867';

      when(client.get(Uri.parse(ApiServiceTest.baseUrl+ApiServiceTest.detail + id)))
          .thenAnswer((_) async =>
          http.Response('{"error":false, "message":"success", "restaurant":{}}', 200)
      );

      expect(await ApiServiceTest(client).getDetail(id), isA<RestaurantDetailModel>());
    });
  });
}