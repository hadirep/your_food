import 'package:your_food/domain/entities/customer_review.dart';
import 'package:equatable/equatable.dart';

class CustomerReviewModel extends Equatable{
  const CustomerReviewModel({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) => CustomerReviewModel(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };

  CustomerReview toEntity() {
    return CustomerReview(name: name, review: review, date: date);
  }

  @override
  List<Object?> get props => [name, review, date];
}