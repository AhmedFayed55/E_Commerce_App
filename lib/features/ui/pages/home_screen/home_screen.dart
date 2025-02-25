import 'package:ecommerce_app/core/utils/app_assets.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_routes.dart';
import 'package:ecommerce_app/core/utils/app_styles.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/home_screen_cubit/home_screen_view_model.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_states.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(viewModel.selectedIndex, context),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: viewModel.bodyList[viewModel.selectedIndex],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: AppColors.primaryColor),
                child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    currentIndex: viewModel.selectedIndex,
                    onTap: viewModel.bottomNavOnTab,
                    iconSize: 24.sp,
                    items: [
                      bottomNavigationBarItemBuilder(
                        isSelected: viewModel.selectedIndex == 0,
                        selectedIcon: AppAssets.homeIconSelected,
                        unSelectedIcon: AppAssets.homeIconUnSelected,
                      ),
                      bottomNavigationBarItemBuilder(
                        isSelected: viewModel.selectedIndex == 1,
                        selectedIcon: AppAssets.categoriesIconSelected,
                        unSelectedIcon: AppAssets.categoriesIconUnSelected,
                      ),
                      bottomNavigationBarItemBuilder(
                        isSelected: viewModel.selectedIndex == 2,
                        selectedIcon: AppAssets.favoriteIconSelected,
                        unSelectedIcon: AppAssets.favoriteIconUnSelected,
                      ),
                      bottomNavigationBarItemBuilder(
                        isSelected: viewModel.selectedIndex == 3,
                        selectedIcon: AppAssets.profileIconSelected,
                        unSelectedIcon: AppAssets.profileIconUnSelected,
                      ),
                    ])),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavigationBarItemBuilder({
    required bool isSelected,
    required String selectedIcon,
    required String unSelectedIcon,
  }) {
    return BottomNavigationBarItem(
        icon: CircleAvatar(
          foregroundColor:
              isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          backgroundColor:
              isSelected ? AppColors.whiteColor : AppColors.transparent,
          radius: 25.r,
          child: Image.asset(isSelected ? selectedIcon : unSelectedIcon),
        ),
        label: "");
  }

  PreferredSizeWidget buildAppBar(int index, BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      leadingWidth: double.infinity,
      toolbarHeight: index != 3 ? 120.h : 90.h,
      leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 18.h),
                child: Image.asset(
                  AppAssets.routeImageBlue,
                  width: 66.w,
                  height: 22.h,
                ),
              ),
              Visibility(
                visible: index != 3,
                child: Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      style: AppStyles.regular14Text,
                      cursorColor: AppColors.primaryColor,
                      onTap: () {
                        // todo: implement search logic
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.h),
                        hintStyle: AppStyles.light14SearchHint,
                        hintText: 'What do you search for?',
                        prefixIcon: Icon(Icons.search,
                            size: 30.sp, color: AppColors.primaryColor),
                      ),
                    )),
                    InkWell(
                      onTap: () {
                        // todo : navigate to cart screen
                        Navigator.of(context)
                            .pushNamed(AppRoutes.cartScreenRoute);
                      },
                      child: BlocBuilder<ProductTabViewModel, ProductStates>(
                        builder: (context, state) {
                          return Badge(
                            alignment: AlignmentDirectional.topStart,
                            backgroundColor: AppColors.greenColor,
                            label: Text(ProductTabViewModel.get(context)
                                .numberOfCartItems
                                .toString()),
                            child: ImageIcon(
                              AssetImage(AppAssets.shoppingCart),
                              size: 35.sp,
                              color: AppColors.primaryColor,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )),
              )
            ],
          )),
    );
  }
}
