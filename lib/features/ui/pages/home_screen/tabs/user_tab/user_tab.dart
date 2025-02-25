import 'package:ecommerce_app/core/cache/shared_prefrence.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_routes.dart';
import 'package:ecommerce_app/features/ui/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class UserTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        CustomElevatedButton(
            prefixIconButton: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            backgroundColor: AppColors.redColor,
            text: "",
            onTap: () {
              // todo : remove token
              SharedPreferenceUtils.removeData(key: 'token');
              // todo : navigate to login screen
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginRoute,
                (route) => false,
              );
            })
      ],
    ));
  }
}
