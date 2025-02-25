import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/failures/failures.dart';
import 'package:ecommerce_app/domain/entities/AddToCartResponseEntity.dart';
import 'package:ecommerce_app/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:ecommerce_app/domain/entities/ProductResponseEntity.dart';

abstract class HomeRepository {
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getAllCategories();

  Future<Either<Failures, CategoryOrBrandResponseEntity>> getAllBrands();

  Future<Either<Failures, ProductResponseEntity>> getAllProducts();

  Future<Either<Failures, AddToCartResponseEntity>> addToCart(String productId);
}
