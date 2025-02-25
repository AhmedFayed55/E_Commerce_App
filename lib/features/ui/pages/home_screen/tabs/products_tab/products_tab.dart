import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_routes.dart';
import 'package:ecommerce_app/core/utils/flutter_toast.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_states.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/products_tab/product_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../di/di.dart';

class ProductsTab extends StatelessWidget {
  ProductTabViewModel viewModel = getIt<ProductTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductTabViewModel, ProductStates>(
      listener: (context, state) {
        if (state is AddCartSuccessState) {
          ToastMessage.toastMsg(
              "Added Successfully", AppColors.greenColor, AppColors.whiteColor);
        } else if (state is AddCartErrorState) {
          ToastMessage.toastMsg(state.failures.errorMessage, AppColors.redColor,
              AppColors.whiteColor);
        }
      },
      child: BlocBuilder<ProductTabViewModel, ProductStates>(
        bloc: viewModel..getAllProducts(),
        builder: (context, state) {
          return viewModel.productsList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : SafeArea(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 3.2.h,
                                    crossAxisSpacing: 16.w,
                                    mainAxisSpacing: 16.h),
                            itemCount: viewModel.productsList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //todo : navigate to product details screen
                                  Navigator.pushNamed(
                                      context, AppRoutes.productDetailsRoute,
                                      arguments: viewModel.productsList[index]);
                                },
                                child: ProductTabItem(
                                  product: viewModel.productsList[index],
                                ),
                              );
                            }))
                  ],
                ));
        },
      ),
    );
  }
}
