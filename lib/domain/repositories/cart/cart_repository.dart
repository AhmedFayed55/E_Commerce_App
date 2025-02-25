import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/failures/failures.dart';
import 'package:ecommerce_app/domain/entities/GetCartResponseEntity.dart';

abstract class CartRepository {
  Future<Either<Failures, GetCartResponseEntity>> getItemInCart();

  Future<Either<Failures, GetCartResponseEntity>> deleteItemInCart(
      String productId);

  Future<Either<Failures, GetCartResponseEntity>> updateCountInCart(
      String productId, int count);
}
