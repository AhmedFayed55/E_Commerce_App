import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../entities/GetCartResponseEntity.dart';

abstract class CartRemoteDataSource {
  Future<Either<Failures, GetCartResponseEntity>> getItemInCart();

  Future<Either<Failures, GetCartResponseEntity>> deleteItemInCart(
      String productId);

  Future<Either<Failures, GetCartResponseEntity>> updateCountInCart(
      String productId, int count);
}
