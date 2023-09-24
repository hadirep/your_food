class RestaurantListModel {
  final bool error;
  final String message;
  final int count;
  final List<ListSearchModel> restaurants;

  RestaurantListModel({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) =>
      RestaurantListModel(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<ListSearchModel>.from(
            json["restaurants"].map((x) => ListSearchModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantSearchModel {
  RestaurantSearchModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<ListSearchModel> restaurants;

  factory RestaurantSearchModel.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<ListSearchModel>.from(
            json["restaurants"].map((x) => ListSearchModel.fromJson(x))),
      );
}

class ListSearchModel {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  ListSearchModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory ListSearchModel.fromJson(Map<String, dynamic> json) =>
      ListSearchModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
