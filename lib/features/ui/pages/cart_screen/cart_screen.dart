import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_styles.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:ecommerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  CartViewModel viewModel = getIt<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<CartViewModel, CartStates>(
        bloc: viewModel..getItemsInCart(),
        builder: (context, state) {
          if (state is GetCartSuccessState) {
            double totalPrice =
                state.responseEntity.data!.totalCartPrice!.toDouble();
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: viewModel.productsList.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.productsList[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2)),
                              child: CachedNetworkImage(
                                imageUrl: product.product!.imageCover ?? "",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.image_not_supported),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.product!.title ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Text(
                                    "⚫ black | size 40",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Egp ${product.price}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    _quantityButton(
                                      icon: Icons.remove_circle_outline,
                                      onPressed: () {
                                        //todo : decrease count
                                        int count = product.count!.toInt();
                                        count--;
                                        viewModel.updateCountInCart(
                                            product.product!.id ?? "", count);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "${state.responseEntity.data!.products![index].count}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    _quantityButton(
                                      icon: Icons.add_circle_outline_outlined,
                                      onPressed: () {
                                        // todo : increase count
                                        int count = product.count!.toInt();
                                        count++;
                                        viewModel.updateCountInCart(
                                            product.product!.id ?? "", count);
                                      },
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.primaryColor,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    // todo : delete item
                                    viewModel.deleteItemsInCart(
                                        product.product!.id!);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Price", style: AppStyles.medium18Header),
                          Text("EGP $totalPrice",
                              style: AppStyles.medium18Header),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Check Out",
                              style: AppStyles.regular18White,
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is GetCartErrorState) {
            return Center(
              child: Text(state.failures.errorMessage),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }
        },
      ),
    );
  }

  Widget _quantityButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.primaryColor, size: 25),
        onPressed: onPressed,
      ),
    );
  }
}
