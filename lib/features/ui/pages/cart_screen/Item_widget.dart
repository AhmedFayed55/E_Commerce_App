import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/utils/app_styles.dart';
import 'package:ecommerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

/// todo : i didn't use it <==>

class ItemWidget extends StatelessWidget {
  GetProductsEntity productItem;

  ItemWidget({required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          CachedNetworkImage(
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 50.r,
                );
              },
              placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.redColor,
                    ),
                  ),
              errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: AppColors.redColor,
                  ),
              height: 100.h,
              fit: BoxFit.cover,
              imageUrl: productItem.product?.imageCover ?? ""),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(productItem.product?.title ?? "",
                        style: AppStyles.medium20Primary, softWrap: true),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  Icon(
                    Icons.remove_shopping_cart,
                    color: AppColors.primaryColor,
                    size: 25,
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: AppColors.blackColor,
                  ),
                  Text(
                    "Black | size 40",
                    style: AppStyles.regular14Text,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "EGP ${productItem.product!.price}",
                    style: AppStyles.medium20Primary,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // todo: Decrease counter
                          },
                          icon: Icon(Icons.remove_circle_outline),
                          color: AppColors.whiteColor,
                        ),
                        Text(
                          productItem.count.toString(),
                          style: AppStyles.semi16TextWhite,
                        ),
                        IconButton(
                            onPressed: () {
                              // todo: Decrease counter
                            },
                            icon: Icon(Icons.add_circle_outline_outlined),
                            color: AppColors.whiteColor),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
