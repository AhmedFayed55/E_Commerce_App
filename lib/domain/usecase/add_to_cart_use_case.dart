import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/entities/AddToCartResponseEntity.dart';
import 'package:ecommerce_app/domain/repositories/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

import '../../core/failures/failures.dart';

@injectable
class AddToCartUseCase {
  HomeRepository homeRepository;

  AddToCartUseCase({required this.homeRepository});

  Future<Either<Failures, AddToCartResponseEntity>> invoke(String productId) {
    return homeRepository.addToCart(productId);
  }
}
