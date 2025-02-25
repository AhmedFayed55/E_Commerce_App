import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/api/api_manager.dart';
import 'package:ecommerce_app/core/cache/shared_prefrence.dart';
import 'package:ecommerce_app/data/model/CategoryOrBrandResponseDm.dart';
import 'package:ecommerce_app/domain/repositories/data_source/auth_remote_data_source/home_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/endpoints.dart';
import '../../../core/failures/failures.dart';
import '../../model/AddToCartResponseDm.dart';
import '../../model/ProductResponseDm.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  ApiManager apiManager;

  HomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, CategoryOrBrandResponseDm>> getAllCategories() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response =
            await apiManager.getData(endPoint: EndPoints.getAllCategories);
        var categoryResponse =
            CategoryOrBrandResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(categoryResponse);
        } else {
          return Left(ServerError(errorMessage: categoryResponse.message!));
        }
      } else {
        return Left(NetworkError(errorMessage: "No Internet Connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, CategoryOrBrandResponseDm>> getAllBrands() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response =
            await apiManager.getData(endPoint: EndPoints.getAllBrands);
        var brandResponse = CategoryOrBrandResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(brandResponse);
        } else {
          return Left(ServerError(errorMessage: brandResponse.message!));
        }
      } else {
        return Left(NetworkError(errorMessage: "No Internet Connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, ProductResponseDm>> getAllProducts() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response =
            await apiManager.getData(endPoint: EndPoints.getAllProducts);
        var productResponse = ProductResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(productResponse);
        } else {
          return Left(ServerError(errorMessage: productResponse.message!));
        }
      } else {
        return Left(NetworkError(errorMessage: "No Internet Connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, AddToCartResponseDm>> addToCart(
      String productId) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var token = SharedPreferenceUtils.getData(key: "token");
        var response = await apiManager.postData(
            endPoint: EndPoints.addToCart,
            body: {"productId": productId},
            headers: {'token': token});
        var addToCartResponse = AddToCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(addToCartResponse);
        } else {
          return Left(ServerError(errorMessage: addToCartResponse.message!));
        }
      } else {
        return Left(NetworkError(errorMessage: "No Internet Connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}
