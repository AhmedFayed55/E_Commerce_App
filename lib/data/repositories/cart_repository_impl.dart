import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/failures/failures.dart';
import 'package:ecommerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:ecommerce_app/domain/repositories/cart/cart_repository.dart';
import 'package:ecommerce_app/domain/repositories/data_source/auth_remote_data_source/cart_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImpl({required this.cartRemoteDataSource});

  @override
  Future<Either<Failures, GetCartResponseEntity>> getItemInCart() async {
    var either = await cartRemoteDataSource.getItemInCart();
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, GetCartResponseEntity>> deleteItemInCart(
      String productId) async {
    var either = await cartRemoteDataSource.deleteItemInCart(productId);
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, GetCartResponseEntity>> updateCountInCart(
      String productId, int count) async {
    var either = await cartRemoteDataSource.updateCountInCart(productId, count);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
