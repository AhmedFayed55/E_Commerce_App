import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/api/api_manager.dart';
import 'package:ecommerce_app/core/failures/failures.dart';
import 'package:ecommerce_app/domain/repositories/data_source/auth_remote_data_source/cart_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/endpoints.dart';
import '../../../core/cache/shared_prefrence.dart';
import '../../model/GetCartResponseDm.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  ApiManager apiManager;

  CartRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, GetCartResponseDm>> getItemInCart() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var token = SharedPreferenceUtils.getData(key: "token");
        var response = await apiManager.getData(
            endPoint: EndPoints.addToCart, // todo: same endpoint
            headers: {'token': token});
        var getCartResponse = GetCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(getCartResponse);
        } else {
          return Left(ServerError(errorMessage: getCartResponse.message!));
        }
      } else {
        return Left(NetworkError(errorMessage: "No Internet Connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetCartResponseDm>> deleteItemInCart(
      String productId) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var token = SharedPreferenceUtils.getData(key: "token");
        var response = await apiManager.deleteData(
            endPoint: "${EndPoints.addToCart}/$productId",
            headers: {'token': token});
        var getCartResponse = GetCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(getCartResponse);
        } else {
          return Left(ServerError(errorMessage: getCartResponse.message!));
        }
      } else {
        return Left(NetworkError(errorMessage: "No Internet Connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetCartResponseDm>> updateCountInCart(
      String productId, int count) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var token = SharedPreferenceUtils.getData(key: "token");
        var response = await apiManager.updateData(
            endPoint: "${EndPoints.addToCart}/$productId",
            body: {"count": "$count"},
            headers: {'token': token});
        var updateCartResponse = GetCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(updateCartResponse);
        } else {
          return Left(ServerError(errorMessage: updateCartResponse.message!));
        }
      } else {
        return Left(NetworkError(errorMessage: "No Internet Connection"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}
