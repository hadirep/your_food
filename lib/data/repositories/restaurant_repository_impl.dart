import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:your_food/common/exception.dart';
import 'package:your_food/common/failure.dart';
import 'package:your_food/data/datasources/restaurant_local_data_source.dart';
import 'package:your_food/data/datasources/restaurant_remote_data_source.dart';
import 'package:your_food/data/models/restaurant_table.dart';
import 'package:your_food/domain/entities/restaurant.dart';
import 'package:your_food/domain/entities/restaurant_detail.dart';
import 'package:your_food/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final RestaurantLocalDataSource localDataSource;

  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource
  });

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantList() async {
    try {
      final result = await remoteDataSource.getRestaurantList();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, RestaurantDetail>> getRestaurantDetail(String id) async {
    try {
      final result = await remoteDataSource.getRestaurantDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> searchRestaurant(String query) async {
    try {
      final result = await remoteDataSource.searchRestaurant(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveFavorite(RestaurantDetail restaurant) async {
    try {
      final result = await localDataSource.insertFavorite(RestaurantTable.fromEntity(restaurant));
      return Right(result);
    } on DatabaseException catch(e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeFavorite(RestaurantDetail restaurant) async {
    try {
      final result = await localDataSource.removeFavorite(RestaurantTable.fromEntity(restaurant));
      return Right(result);
    } on DatabaseException catch(e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToFavorite(String id) async {
    final result = await localDataSource.getRestaurantById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getFavoriteRestaurant() async {
    final result = await localDataSource.getFavoriteRestaurant();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}