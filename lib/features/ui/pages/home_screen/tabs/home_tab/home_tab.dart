import 'package:ecommerce_app/core/utils/app_assets.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_styles.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/home_tab/category_brand_item.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/home_tab/home_tab_cubit/home_tab_states.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/tabs/home_tab/home_tab_cubit/home_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBox(height: 16),
          buildAdvertisements(images: [
            AppAssets.advertise1,
            AppAssets.advertise2,
            AppAssets.advertise3,
          ]),
          sizedBox(height: 24),
          viewAllRow("Category"),
          BlocBuilder<HomeTabViewModel, HomeTabStates>(
            bloc: viewModel..getAllCategories(),
            builder: (context, state) {
              if (state is CategoryLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else if (state is CategoryErrorState) {
                return Center(
                  child: Text(state.failures.errorMessage),
                );
              } else if (viewModel.categoryList.isNotEmpty) {
                return buildCategoryBrandSec(list: viewModel.categoryList);
                // state.categoryResponseEntity.data!.length.toString()
              }
              return Container();
            },
          ),
          viewAllRow("Brands"),
          BlocBuilder<HomeTabViewModel, HomeTabStates>(
            bloc: viewModel..getAllBrands(),
            builder: (context, state) {
              if (state is BrandLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else if (state is BrandErrorState) {
                return Center(
                  child: Text(state.failures.errorMessage),
                );
              } else if (viewModel.brandsList.isNotEmpty) {
                return buildCategoryBrandSec(list: viewModel.brandsList);
                // state.categoryResponseEntity.data!.length.toString()
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  SizedBox sizedBox({int height = 0, int width = 0}) {
    return SizedBox(
      height: height.h,
      width: width.h,
    );
  }

  ImageSlideshow buildAdvertisements({required List<String> images}) {
    return ImageSlideshow(
        initialPage: 0,
        indicatorColor: AppColors.primaryColor,
        indicatorBottomPadding: 15.h,
        indicatorPadding: 8.w,
        indicatorRadius: 5,
        indicatorBackgroundColor: AppColors.whiteColor,
        isLoop: true,
        autoPlayInterval: 3000,
        height: 190.h,
        children: images.map((url) {
          return Image.asset(
            url,
            fit: BoxFit.fill,
          );
        }).toList());
  }

  Widget viewAllRow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyles.medium18Header,
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "View All",
              style: AppStyles.regular12Text,
            ))
      ],
    );
  }

  SizedBox buildCategoryBrandSec({required List<CategoryOrBrandEntity> list}) {
    return SizedBox(
      height: 350.h,
      width: double.infinity,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CategoryBrandItem(item: list[index]);
          }),
    );
  }
}
