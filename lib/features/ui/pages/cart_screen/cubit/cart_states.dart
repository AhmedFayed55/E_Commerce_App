import 'package:ecommerce_app/core/failures/failures.dart';
import 'package:ecommerce_app/domain/entities/GetCartResponseEntity.dart';

abstract class CartStates {}

class GetCartLoadingState extends CartStates {}

class GetCartErrorState extends CartStates {
  Failures failures;

  GetCartErrorState({required this.failures});
}

class GetCartSuccessState extends CartStates {
  GetCartResponseEntity responseEntity;

  GetCartSuccessState({required this.responseEntity});
}

class DeleteCartLoadingState extends CartStates {}

class DeleteCartErrorState extends CartStates {
  Failures failures;

  DeleteCartErrorState({required this.failures});
}

class DeleteCartSuccessState extends CartStates {
  GetCartResponseEntity responseEntity;

  DeleteCartSuccessState({required this.responseEntity});
}

class UpdateCountCartLoadingState extends CartStates {}

class UpdateCountCartErrorState extends CartStates {
  Failures failures;

  UpdateCountCartErrorState({required this.failures});
}

class UpdateCountCartSuccessState extends CartStates {
  GetCartResponseEntity responseEntity;

  UpdateCountCartSuccessState({required this.responseEntity});
}
