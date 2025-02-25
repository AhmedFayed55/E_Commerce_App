import 'package:ecommerce_app/domain/entities/ProductResponseEntity.dart';
import 'package:ecommerce_app/domain/usecase/add_to_cart_use_case.dart';
import 'package:ecommerce_app/domain/usecase/get_all_products_use_case.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductTabViewModel extends Cubit<ProductStates> {
  GetAllProductsUseCase getAllProductsUseCase;
  AddToCartUseCase addToCartUseCase;

  ProductTabViewModel(
      {required this.getAllProductsUseCase, required this.addToCartUseCase})
      : super(ProductInitialState());

  //todo: hold date - handle logic

  List<ProductEntity> productsList = [];
  int numberOfCartItems = 0;

  static ProductTabViewModel get(context) =>
      BlocProvider.of<ProductTabViewModel>(context);

  void getAllProducts() async {
    emit(ProductInitialState());
    var either = await getAllProductsUseCase.invoke();
    either.fold((error) {
      emit(ProductErrorState(failures: error));
    }, (response) {
      productsList = response.data!;
      emit(ProductSuccessState(productResponseEntity: response));
    });
  }

  void addToCart(String productId) async {
    emit(AddCartLoadingState());
    var either = await addToCartUseCase.invoke(productId);
    either.fold((error) {
      emit(AddCartErrorState(failures: error));
    }, (response) {
      numberOfCartItems = response.numOfCartItems!.toInt();
      print("number of cart items : $numberOfCartItems");
      emit(AddCartSuccessState(addToCartResponseEntity: response));
    });
  }
}
