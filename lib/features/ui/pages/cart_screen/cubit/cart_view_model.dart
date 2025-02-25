import 'package:ecommerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:ecommerce_app/domain/usecase/delete_items_in_cart_use_case.dart';
import 'package:ecommerce_app/domain/usecase/get_items_in_cart_use_case.dart';
import 'package:ecommerce_app/domain/usecase/update_count_in_cart_use_case.dart';
import 'package:ecommerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartViewModel extends Cubit<CartStates> {
  CartViewModel(
      {required this.getItemsInCartUseCase,
      required this.deleteItemsInCartUseCase,
      required this.updateCountInCartUseCase})
      : super(GetCartLoadingState());

  GetItemsInCartUseCase getItemsInCartUseCase;
  DeleteItemsInCartUseCase deleteItemsInCartUseCase;
  UpdateCountInCartUseCase updateCountInCartUseCase;
  List<GetProductsEntity> productsList = [];

  void getItemsInCart() async {
    emit(GetCartLoadingState());
    var either = await getItemsInCartUseCase.invoke();
    either.fold((error) {
      emit(GetCartErrorState(failures: error));
    }, (response) {
      productsList = response.data!.products!;
      emit(GetCartSuccessState(responseEntity: response));
    });
  }

  void deleteItemsInCart(String productId) async {
    var either = await deleteItemsInCartUseCase.invoke(productId);
    either.fold((error) {
      emit(DeleteCartErrorState(failures: error));
    }, (response) {
      productsList.removeWhere((product) => product.product!.id == productId);
      print("removed successfully");
      emit(DeleteCartSuccessState(responseEntity: response));
      getItemsInCart();
    });
  }

  void updateCountInCart(String productId, int count) async {
    var either = await updateCountInCartUseCase.invoke(productId, count);
    either.fold((error) {
      emit(UpdateCountCartErrorState(failures: error));
    }, (response) {
      print("updated successfully");
      emit(GetCartSuccessState(responseEntity: response));
      getItemsInCart();
    });
  }
}
